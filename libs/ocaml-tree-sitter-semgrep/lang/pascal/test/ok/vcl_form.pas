unit RackViewForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Generics.Collections, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, FireDAC.Comp.Client
  {$IFDEF USE_GRID}, Vcl.Grids{$ENDIF};

const
  MaxRackUnits = 48;
  DefaultCaption: string = 'Rack view';
  crOldCursor = crHandPoint deprecated 'use crHandPoint';

type
  TRackUnit = 1..MaxRackUnits;
  TDeviceState = (dsUnknown, dsPlanned = 10, dsInstalled, dsRemoved);
  TDeviceStates = set of TDeviceState;
  TRackUnits = array[TRackUnit] of Integer;

  TDeviceInfo = packed record
    Id: Int64;
    Name: string;
    Height: Byte;
    case Boolean of
      True: (Weight: Double);
      False: (Raw: array[0..7] of Byte);
  end;

  TDeviceEvent = procedure(Sender: TObject; const Info: TDeviceInfo) of object;
  TDeviceFilter = reference to function(const D: TDeviceInfo): Boolean;

  IRackService = interface
    ['{7B8A1E2C-8D4F-4C1A-9E3B-2A6C5D4E3F21}']
    function FindDevice(const Name: string): TDeviceInfo;
    procedure Refresh;
  end;

  [ComponentPlatforms(pidWin32 or pidWin64)]
  TRackViewForm = class(TForm, IRackService)
    btnRefresh: TButton;
    lblTitle: TLabel;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
    FDevices: TObjectList<TDeviceInfoHolder>;
    FOnDevice: TDeviceEvent;
    FQuery: TFDQuery;
    class var FInstanceCount: Integer;
    function GetDeviceCount: Integer;
  protected
    procedure DoDevice(const Info: TDeviceInfo); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindDevice(const Name: string): TDeviceInfo;
    procedure Refresh;
    class function InstanceCount: Integer; static;
    property DeviceCount: Integer read GetDeviceCount;
    property OnDevice: TDeviceEvent read FOnDevice write FOnDevice;
  end;

  TDeviceInfoHolder = class
  public
    Info: TDeviceInfo;
  end;

var
  RackViewForm: TRackViewForm;

implementation

{$R *.dfm}

uses
  System.StrUtils, System.Math;

constructor TRackViewForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDevices := TObjectList<TDeviceInfoHolder>.Create(True);
  Inc(FInstanceCount);
end;

destructor TRackViewForm.Destroy;
begin
  FreeAndNil(FDevices);
  Dec(FInstanceCount);
  inherited;
end;

class function TRackViewForm.InstanceCount: Integer;
begin
  Result := FInstanceCount;
end;

function TRackViewForm.GetDeviceCount: Integer;
begin
  Result := FDevices.Count;
end;

procedure TRackViewForm.DoDevice(const Info: TDeviceInfo);
begin
  if Assigned(FOnDevice) then
    FOnDevice(Self, Info);
end;

function TRackViewForm.FindDevice(const Name: string): TDeviceInfo;
var
  Holder: TDeviceInfoHolder;
begin
  for Holder in FDevices do
    if SameText(Holder.Info.Name, Name) then
      Exit(Holder.Info);
  raise EArgumentException.CreateFmt('Device %s not found', [Name]);
end;

procedure TRackViewForm.Refresh;
var
  I: Integer;
  Units: TRackUnits;
  Filter: TDeviceFilter;
begin
  FillChar(Units, SizeOf(Units), 0);
  Filter :=
    function(const D: TDeviceInfo): Boolean
    begin
      Result := D.Height > 0;
    end;
  FQuery.SQL.Text := 'SELECT ID, NAME, HEIGHT FROM DEVICE WHERE RACK = :RACK';
  FQuery.ParamByName('RACK').AsInteger := 42;
  FQuery.Open;
  try
    while not FQuery.Eof do
    begin
      var Holder := TDeviceInfoHolder.Create;
      Holder.Info.Id := FQuery.FieldByName('ID').AsLargeInt;
      Holder.Info.Name := FQuery.FieldByName('NAME').AsString;
      Holder.Info.Height := FQuery.FieldByName('HEIGHT').AsInteger;
      if Filter(Holder.Info) then
        FDevices.Add(Holder)
      else
        Holder.Free;
      FQuery.Next;
    end;
  finally
    FQuery.Close;
  end;
  for I := Low(Units) to High(Units) do
    case Units[I] of
      0: Continue;
      1..9: Units[I] := Units[I] * 2;
    else
      Break;
    end;
  lblTitle.Caption := Format('%s (%d)', [DefaultCaption, FDevices.Count]);
end;

procedure TRackViewForm.btnRefreshClick(Sender: TObject);
begin
  try
    Refresh;
  except
    on E: EDatabaseError do
      ShowMessage('Database error: ' + E.Message);
    on E: Exception do
    begin
      Application.HandleException(E);
      raise;
    end;
  end;
end;

procedure TRackViewForm.FormCreate(Sender: TObject);
begin
  Caption := IfThen(FInstanceCount > 1, DefaultCaption + ' *', DefaultCaption);
  with btnRefresh do
    Enabled := True;
  repeat
    Application.ProcessMessages;
  until not Visible or (Tag <> 0);
end;

initialization
  RegisterClass(TRackViewForm);

finalization
  UnRegisterClass(TRackViewForm);

end.
