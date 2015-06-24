unit SJ_OneInstance;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms;

type
  TOneInstance=class(TComponent)
  private
    FTerminate: boolean;
    FSwitchToPrevious: boolean;
    Mutex: hWnd;
    MutexCreated: boolean;
    FOnInstanceExists: TNotifyEvent;
  public
    procedure Loaded; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property SwitchToPrevious: boolean read FSwitchToPrevious write FSwitchToPrevious;
    property Terminate: boolean read FTerminate write FTerminate;
    property OnInstanceExists: TNotifyEvent read FOnInstanceExists write FOnInstanceExists;
  end;

implementation

constructor TOneInstance.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTerminate:=True;
  FSwitchToPrevious:=True;
end;

destructor TOneInstance.Destroy;
begin
  if MutexCreated then CloseHandle(Mutex);
  inherited Destroy;
end;

procedure TOneInstance.Loaded;
var
  Title: array[0..$100] of char;
  PreviousHandle: THandle;
begin
  inherited Loaded;
  StrPCopy(Title, Application.Title);
  MutexCreated:=False;
  Mutex:=CreateMutex(nil, False, Title);
  if (GetLastError=ERROR_ALREADY_EXISTS)or(Mutex=0) then
  begin
    if Assigned(FOnInstanceExists) then FOnInstanceExists(Self);
    if FSwitchToPrevious then
    begin
      PreviousHandle:=FindWindow(nil, Title);
      SetWindowText(PreviousHandle, '');
      PreviousHandle:=FindWindow(nil, Title);
      if PreviousHandle<>0 then
      begin
        if IsIconic(PreviousHandle) then
          ShowWindow(PreviousHandle, SW_RESTORE)
        else
          BringWindowToTop(PreviousHandle);
      end;
    end;
    if FTerminate then Application.Terminate;
  end;
  MutexCreated:=True;
end;

end.

