unit CM4SupportClasses;

interface

uses
  SysUtils, Classes;

const
  BUFFER_SIZE = 64 * 1024;
  STRING_TERMINATOR: Word = 0;

type
  EAccessDeniedError = class(Exception);
  EFileCorruptError = class(Exception);
  ECM4LoadError = class(Exception)
  private
    FPosition: Int64;
  public
    constructor Create(Msg: string; Position: Int64);
    property Position: Int64 read FPosition;
  end;

  TStatusEvent = procedure(Status: string) of object;
  TProgressEvent = procedure(Progress: Integer) of object;

  TBufferedStreamReader = class(TStream)
  private
    FStream: TStream;
    FStreamSize: Int64;
    FBufferSize: Integer;
    FBuffer: Pointer;
    FBufferPos: Int64;
    FPosition: Int64;
    FBufferFilled: Boolean;
    procedure FillBuffer;
    procedure CopyFromBuffer(var Buffer; Start, BufferStart,
      Count: Integer);
  public
    constructor Create(Stream: TStream; BufferSize: Integer = BUFFER_SIZE);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
  end;

  TBufferedFileStream = class(TBufferedStreamReader)
  private
    FStream: TFileStream;
  public
    constructor Create(FileName: string; Mode: Word); overload;
    destructor Destroy; override;
  end;

  TCM4FileStream = class(TBufferedFileStream)
  public
    constructor Create(FileName: string; Mode: Word); overload;
    function Read(var Buffer; Count: Longint): Longint; override;
    function ReadWideString: WideString;
    procedure WriteWideString(S: WideString);
    procedure SkipWideString;
    procedure Skip(Amount: Integer);
    procedure SkipByteArray(ArraySize: Integer);
    procedure SkipWordArray(ArraySize: Integer);
    procedure SkipIntArray(ArraySize: Integer);
  end;

  TCM4Tokenizer = class(TStringList)
  public
    function Serialize(Delimiter: string): string;
  end;

implementation

{ TBufferedStreamReader }

constructor TBufferedStreamReader.Create(Stream: TStream; BufferSize: Integer);
begin
  FStream:=Stream;
  FStreamSize:=FStream.Size;
  FBufferSize:=BufferSize;
  GetMem(FBuffer, FBufferSize);
  FBufferPos:=0;
  FPosition:=0;
  FBufferFilled:=False;
end;

destructor TBufferedStreamReader.Destroy;
begin
  FreeMem(FBuffer, FBufferSize);
  inherited;
end;

procedure TBufferedStreamReader.FillBuffer;
begin
  FStream.Seek(FBufferPos, soFromBeginning);
  FStream.Read(FBuffer^, FBufferSize);
end;

procedure TBufferedStreamReader.CopyFromBuffer(var Buffer; Start: Integer; BufferStart: Integer; Count: Integer);
begin
  Move(Pointer(Integer(FBuffer) + BufferStart)^, Pointer(Integer(@Buffer) + Start)^, Count);
end;

function TBufferedStreamReader.Read(var Buffer; Count: Integer): Longint;
var
  ReadStart: Integer;
  AmountRead: Integer;
begin
  if not FBufferFilled then
  begin
    FBufferPos:=FPosition;
    FillBuffer;
    FBufferFilled:=True;
  end;

  if (FPosition < FBufferPos) or (FBufferPos + FBufferSize <= FPosition) then
  begin
    FBufferPos:=FPosition;
    FillBuffer;
  end;

  if FPosition + Count > FStreamSize then
    Result:=FStreamSize - FPosition
  else
    Result:=Count;

  ReadStart:=FPosition - FBufferPos;
  if FBufferSize - ReadStart >= Result then
  begin
    CopyFromBuffer(Buffer, 0, ReadStart, Result);
    Inc(FPosition, Result);
  end
  else
  begin
    AmountRead:=FBufferSize - ReadStart;
    CopyFromBuffer(Buffer, 0, ReadStart, AmountRead);
    Inc(FPosition, AmountRead);
    while AmountRead < Result do
    begin
      FBufferPos:=FPosition;
      FillBuffer;
      if Result - AmountRead <= FBufferSize then
      begin
        CopyFromBuffer(Buffer, AmountRead, 0, Result - AmountRead);
        Inc(FPosition, Result - AmountRead);
        AmountRead:=Result;
      end
      else
      begin
        CopyFromBuffer(Buffer, AmountRead, 0, FBufferSize);
        Inc(FPosition, FBufferSize);
        Inc(AmountRead, FBufferSize);
      end;
    end;
  end;
end;

function TBufferedStreamReader.Seek(Offset: Integer;
  Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning:
    begin
      if Offset < 0 then
        FPosition:=0
      else if Offset <= FStreamSize then
        FPosition:=Offset
      else
        FPosition:=FStreamSize;
      Result:=FPosition;
    end;
    soFromCurrent:
    begin
      Inc(FPosition, Offset);
      if FPosition > FStreamSize then
        FPosition:=FStreamSize;
      if FPosition < 0 then
        FPosition:=0;
      Result:=FPosition;
    end;
    soFromEnd:
    begin
      FPosition:=FStreamSize + Offset;
      if FPosition > FStreamSize then
        FPosition:=FStreamSize;
      if FPosition < 0 then
        FPosition:=0;
      Result:=FPosition;
    end;
    else
      raise EStreamError.Create('Unknown Seek Origin');
  end;
end;

function TBufferedStreamReader.Write(const Buffer;
  Count: Integer): Longint;
begin
  raise EStreamError.Create('Read Only Stream, You can''t write to it');
end;

{ TBufferedFileStream }

constructor TBufferedFileStream.Create(FileName: string; Mode: Word);
begin
  FStream:=TFileStream.Create(FileName, Mode);
  inherited Create(FStream);
end;

destructor TBufferedFileStream.Destroy;
begin
  FStream.Free;
  inherited;
end;

{ TCM4FileStream }

constructor TCM4FileStream.Create(FileName: string; Mode: Word);
begin
  inherited Create(FileName, Mode);
end;

function TCM4FileStream.Read(var Buffer; Count: Integer): Longint;
begin
  Result:=inherited Read(Buffer, Count);
  if Result < Count then
    raise EFileCorruptError.Create('Data file seems to be corrupt. Wanted to read ' + IntToStr(Count) + ' bytes, could only read ' + IntToStr(Result) + ' bytes.');
end;

function TCM4FileStream.ReadWideString: WideString;
var
  Length: Integer;
begin
  Result:='';
  Read(Length, 4);
  if (Length > 0) then
  begin
    SetLength(Result, Length);
    Read(Pointer(Result)^, Length * 2);
    Skip(2);
  end;
end;

procedure TCM4FileStream.Skip(Amount: Integer);
begin
  Seek(Amount, soFromCurrent);
end;

procedure TCM4FileStream.SkipByteArray(ArraySize: Integer);
var
  Length: Byte;
begin
  Read(Length, 1);
  Skip(ArraySize * Length);
end;

procedure TCM4FileStream.SkipIntArray(ArraySize: Integer);
var
  Length: Integer;
begin
  Read(Length, 4);
  Skip(ArraySize * Length);
end;

procedure TCM4FileStream.SkipWideString;
var
  Length: Integer;
begin
  Read(Length, 4);
  if (Length > 0) then
    Skip((Length * 2) + 2);
end;

procedure TCM4FileStream.SkipWordArray(ArraySize: Integer);
var
  Length: Word;
begin
  Read(Length, 2);
  Skip(ArraySize * Length);
end;

procedure TCM4FileStream.WriteWideString(S: WideString);
var
  Size: Integer;
begin
  Size:=Length(S);
  Write(Size, 4);
  if (Size > 0) then
  begin
    Write(Pointer(S)^, Size * 2);
    Write(STRING_TERMINATOR, 2);
  end;
end;

{ ECM4LoadError }

constructor ECM4LoadError.Create(Msg: string; Position: Int64);
begin
  inherited Create(Msg);
  FPosition:=Position;
end;

{ TCM4Tokenizer }

function TCM4Tokenizer.Serialize(Delimiter: string): string;
var
  j: Integer;
begin
  if Count > 0 then
  begin
    Result:=Strings[0];
    for j:=1 to Count - 1 do
      Result:=Result + Delimiter + Strings[j];
  end
  else
    Result:='';
end;

end.
