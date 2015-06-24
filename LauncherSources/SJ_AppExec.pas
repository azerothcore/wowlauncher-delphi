unit SJ_AppExec;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms, Dialogs;

type
  EAppExec = class(Exception);
  EAppExecChDir = class(EAppExec);
  EAppExecWinExec = class(EAppExec);

  TPriorClass = (pcHigh, pcIdle, pcNormal, pcRealtime);
  TLangType   = (ltFrench, ltEnglish, ltItalian);

  TAppExec = class(TComponent)
  private
    FChangeDir: boolean;
    FErrNo:     DWORD;
    FExeName:   string;
    FExePath:   string;
    FExeParams: TStringList;
    FHide:      boolean;
    FLangType:  TLangType;
    FMode:      word;
    FOutput:    TStringList;
    FPriorClass: TPriorClass;
    FRedirectOutput: boolean;
    FWait:      boolean;
    FWaitCursor: TCursor;
    FWindowState: TWindowState;
    procedure SetWindowState(AWindowState: TWindowState);
    procedure SetExeParams(AExeParams: TStringList);
    procedure SetExePath(AExePath: string);
    procedure SetLangType(ALangType: TLangType);
    procedure SetPriorClass(Value: TPriorClass);
  protected
  public
    phandle: Thandle;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    procedure Clear;
    property ErrNo: DWORD Read FErrNo;
    property Output: TStringList Read FOutput;
    function GetCommandLine: string;
    function GetErrorString: string;
  published
    property ChangeDir: boolean Read FChangeDir Write FChangeDir default True;
    property ExeName: string Read FExeName Write FExeName;
    property ExeParams: TStringList Read FExeParams Write SetExeParams;
    property ExePath: string Read FExePath Write SetExePath;
    property Hide: boolean Read FHide Write FHide default False;
    property LangType: TLangType Read FLangType Write SetLangType default ltEnglish;
    property PriorityClass: TPriorClass
      Read FPriorClass Write SetPriorClass default pcNormal;
    property RedirectOutput: boolean Read FRedirectOutput Write FRedirectOutput;
    property Wait: boolean Read FWait Write FWait default False;
    property WaitCursor: TCursor Read FWaitCursor Write FWaitCursor default crAppStart;
    property WindowState: TWindowState Read FWindowState Write SetWindowState;
  end;

var
  // Messages
  MSG_ERROR_0, MSG_ERROR_2, MSG_ERROR_3, MSG_ERROR_5: string;
  MSG_ERROR_6, MSG_ERROR_8, MSG_ERROR_10, MSG_ERROR_11, MSG_ERROR_12: string;
  MSG_ERROR_13, MSG_ERROR_14, MSG_ERROR_15, MSG_ERROR_16, MSG_ERROR_19: string;
  MSG_ERROR_20, MSG_ERROR_21, MSG_ERROR_32_AND_MORE:  string;

const
  MAX_BUFFER_SIZE = 260; // MAX_PATH = 260
  MAX_DOS_COMMAND_LENGTH = 127; // MS-DOS limitation

procedure Register;

implementation

 {*********************************************************************}
 { FUNCTION PathAddSeparator                                           }
 {*********************************************************************}

function PathAddSeparator(const Path: string): string;
begin
  Result := Path;
  if (Length(Path) = 0) or (AnsiLastChar(Path) <> '\') then
    Result := Path + '\';
end;

 {***************************************************************************}
 { PROCEDURE Register                                                        }
 {***************************************************************************}

procedure Register;
begin
  RegisterComponents('SimJoy', [TAppExec]);
end;

 {***************************************************************************}
 { CONSTRUCTOR Create                                                        }
 {***************************************************************************}

constructor TAppExec.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FExeParams := TStringList.Create;
  FChangeDir := True;
  FErrNo     := 32;
  FMode      := SW_SHOWNORMAL;
  FOutput    := TStringList.Create;
  FPriorClass := pcNormal;
  FWaitCursor := crAppStart;
  SetLangType(ltEnglish);
end;

 {***************************************************************************}
 { DESTRUCTOR Destroy                                                        }
 {***************************************************************************}

destructor TAppExec.Destroy;
begin
  FExeParams.Free;
  FOutput.Free;
  inherited Destroy;
end;

 {***************************************************************************}
 { PROCEDURE Execute                                                         }
 {***************************************************************************}

{$I-}

procedure TAppExec.Execute;
var
  buffer: array[0..MAX_BUFFER_SIZE] of char;
  TmpStr: string;
  TmpCursor: TCursor;
  tslBatch: TStringList;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  PriorClass: longint;
  i: integer;
begin
  TmpCursor  := Screen.Cursor;
  PriorClass := NORMAL_PRIORITY_CLASS;
  FExePath   := PathAddSeparator(FExePath);
  FOutput.Clear;

  tslBatch := TStringList.Create;

  case FPriorClass of
    pcHigh: PriorClass     := HIGH_PRIORITY_CLASS;
    pcIdle: PriorClass     := IDLE_PRIORITY_CLASS;
    pcNormal: PriorClass   := NORMAL_PRIORITY_CLASS;
    pcRealtime: PriorClass := REALTIME_PRIORITY_CLASS;
  end;

  // Build the command line
  if (ExtractFileExt(FExeName) = '') and not
    FileExists(PathAddSeparator(FExePath) + FExeName + '.exe') and
    FileExists(PathAddSeparator(FExePath) + FExeName + '.bat') then
    TmpStr := FExeName + '.bat'
  else
    TmpStr := FExeName;

  for i := 0 to FExeParams.Count - 1 do
    TmpStr := TmpStr + ' ' + FExeParams.Strings[i];

  // Redirect output
  if (FRedirectOutput = True) then
  begin
    // Note that FWait has to be set to 'true' in order to be able to redirect the output in time
    TmpStr := TmpStr + ' > ' +
      ExtractFileName(ChangeFileExt(Application.exeName, '.out'));
    tslBatch.add(TmpStr);
    try
      tslBatch.SaveToFile(FExePath +
        ExtractFileName(ChangeFileExt(Application.exeName, '.bat')));
    except
      //on E: Exception do raise EAppExecBatch.Create(E.Message);
    end;
    TmpStr := ExtractFileName(ChangeFileExt(Application.exeName, '.bat'));
  end;

  StrPCopy(buffer, TmpStr);

  // Change directory
  if (FChangeDir) and (FExePath <> '') then
  begin
    try
      ChDir(FExePath);
    except
      on E: Exception do
        raise EAppExecChDir.Create(E.Message);
    end;
  end;

  // Execute
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb      := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  if (FHide = False) then
    StartupInfo.wShowWindow := FMode
  else
    StartupInfo.wShowWindow := SW_HIDE;
  if not CreateProcess(nil, buffer, // Pointer to command line string
    nil,   // Pointer to process security attributes
    nil,   // Pointer to thread security attributes
    False, // Handle inheritance flag
    CREATE_NEW_CONSOLE or // Creation flags
    PriorClass or CREATE_SEPARATE_WOW_VDM, nil, // Pointer to new environment block
    nil,   // Pointer to current directory name
    StartupInfo, // Pointer to STARTUPINFO
    ProcessInfo) then
  begin // Pointer to PROCESS_INF
    FErrNo := GetLastError();
    raise EAppExecWinExec.Create(GetErrorString);
  end
  else
  begin
    FErrNo := 32;
    if (FWait = True) then
    begin
      Screen.Cursor := FWaitCursor;
      Application.ProcessMessages;
      if (Win32PlatForm = 0) then
        WaitforSingleObject(ProcessInfo.hProcess, INFINITE)
      else
        GetExitCodeProcess(ProcessInfo.hProcess, FErrNo);
      Phandle := ProcessInfo.hProcess;
      Application.ProcessMessages;
      repeat
        if not GetExitCodeProcess(ProcessInfo.hProcess, FErrNo) then
        begin
          FErrNo := GetLastError();
          Application.ProcessMessages;
          raise EAppExecWinExec.Create(GetErrorString);
        end;
        Application.ProcessMessages;
      until (FErrNo <> STILL_ACTIVE);
    end;
  end;

  // Redirect output
  if (FRedirectOutput = True) then
  begin
    if FileExists(FExePath + ExtractFileName(ChangeFileExt(Application.exeName,
      '.out'))) then
    begin
      FOutput.LoadFromFile(FExePath +
        ExtractFileName(ChangeFileExt(Application.exeName, '.out')));
      SysUtils.DeleteFile(FExePath +
        ExtractFileName(ChangeFileExt(Application.exeName, '.out')));
    end;
    if FileExists(FExePath + ExtractFileName(ChangeFileExt(Application.exeName,
      '.bat'))) then
      SysUtils.DeleteFile(FExePath +
        ExtractFileName(ChangeFileExt(Application.exeName, '.bat')));
  end;

  Screen.Cursor := TmpCursor;
  tslBatch.Free;
end;

{$I+}

 {***************************************************************************}
 { PROCEDURE SetPriorClass                                                   }
 {***************************************************************************}

procedure TAppExec.SetPriorClass(Value: TPriorClass);
begin
  FPriorClass := Value;
end;

 {***************************************************************************}
 { PROCEDURE SetWindowState                                                  }
 {***************************************************************************}

procedure TAppExec.SetWindowState(AWindowState: TWindowState);
const
  Mode: array[wsNormal..wsMaximized] of word =
    (SW_SHOWNORMAL, SW_SHOWMINIMIZED, SW_SHOWMAXIMIZED);
begin
  if (FWindowState <> AWindowState) then
  begin
    FMode := Mode[AWindowState];
    FWindowState := AWindowState;
  end;
end;

 {***************************************************************************}
 { PROCEDURE SetExeParams                                                    }
 {***************************************************************************}

procedure TAppExec.SetExeParams(AExeParams: TStringList);
begin
  FExeParams.Assign(AExeParams);
end;

 {***************************************************************************}
 { PROCEDURE SetExePath                                                      }
 {***************************************************************************}

procedure TAppExec.SetExePath(AExePath: string);
begin
  if (FExePath <> AExePath) then
  begin
    FExePath := AExePath;
    if (Length(FExePath) > 3) then
      if (FExePath[Length(FExePath)] = '\') then
        FExePath := Copy(FExePath, 1, Length(FExePath) - 1);
  end;
end;

 {***************************************************************************}
 { PROCEDURE Clear                                                           }
 {***************************************************************************}

procedure TAppExec.Clear;
begin
  FErrNo   := 32;
  FExeName := '';
  FExePath := '';
  FExeParams.Clear;
  FOutput.Clear;
end;

 {***************************************************************************}
 { PROCEDURE GetCommandLine                                                  }
 {***************************************************************************}

function TAppExec.GetCommandLine: string;
var
  i: integer;
begin
  Result := FExeName;
  for i := 0 to FExeParams.Count - 1 do
    Result := Result + ' ' + FExeParams.Strings[i];
end;

 {***************************************************************************}
 { PROCEDURE GetErrorString                                                  }
 {***************************************************************************}

function TAppExec.GetErrorString: string;
begin
  case FErrNo of
    0:
      Result := MSG_ERROR_0;
    2:
      Result := MSG_ERROR_2;
    3:
      Result := MSG_ERROR_3;
    5:
      Result := MSG_ERROR_5;
    6:
      Result := MSG_ERROR_6;
    8:
      Result := MSG_ERROR_8;
    10:
      Result := MSG_ERROR_10;
    11:
      Result := MSG_ERROR_11;
    12:
      Result := MSG_ERROR_12;
    13:
      Result := MSG_ERROR_13;
    14:
      Result := MSG_ERROR_14;
    15:
      Result := MSG_ERROR_15;
    16:
      Result := MSG_ERROR_16;
    19:
      Result := MSG_ERROR_19;
    20:
      Result := MSG_ERROR_20;
    21:
      Result := MSG_ERROR_21;
    32..MaxInt:
      Result := MSG_ERROR_32_AND_MORE;
  end;
end;

 {***************************************************************************}
 { PROCEDURE SetLangType                                                     }
 {***************************************************************************}

procedure TAppExec.SetLangType(ALangType: TLangType);
begin
  FLangType := ALangType;

  if (ALangType = ltFrench) then
  begin
    MSG_ERROR_0  :=
      'Système dépassé en capacité mémoire, exécutable corrompu, ou réallocations invalides';
    MSG_ERROR_2  := 'Fichier non trouvé';
    MSG_ERROR_3  := 'Chemin non trouvé';
    MSG_ERROR_5  :=
      'Tentative de liaison dynamique à une tâche, ou erreur de partage, ou erreur de protection réseau';
    MSG_ERROR_6  :=
      'Librairie nécessitant des segments de données séparés pour chaque tâche';
    MSG_ERROR_8  := 'Mémoire insuffisante pour démarrer l''application';
    MSG_ERROR_10 := 'Version de Windows incorrecte';
    MSG_ERROR_11 :=
      'Exécutable invalide, application non Windows, ou erreur dans l''image du fichier .EXE';
    MSG_ERROR_12 := 'Application écrite pour un système d''exploitation différent';
    MSG_ERROR_13 := 'Application écrite pour MS-DOS 4.0';
    MSG_ERROR_14 := 'Type d''exécutable inconnu';
    MSG_ERROR_15 :=
      'Tentative de chargement d''une application en mode réel (développée pour une version antérieure de Windows)';
    MSG_ERROR_16 :=
      'Tentative de chargement d''une seconde instance d''un exécutable contenant plusieurs segments de données non marqués en lecture seule';
    MSG_ERROR_19 :=
      'Tentative de chargement d''un exécutable compressé. Le fichier doit être décompressé avant de pouvoir être chargé';
    MSG_ERROR_20 :=
      'Fichier Dynamic-link library (DLL) invalide. Une des DLLs requises pour exécuter cette application est corrompue';
    MSG_ERROR_21 := 'Application nécessitant des extensions 32-bit';
    MSG_ERROR_32_AND_MORE := 'Pas d''erreur';
  end;

  if (ALangType = ltEnglish) then
  begin
    MSG_ERROR_0  :=
      'System was out of memory, executable file was corrupt, or relocations were invalid';
    MSG_ERROR_2  := 'File was not found';
    MSG_ERROR_3  := 'Path was not found';
    MSG_ERROR_5  :=
      'Attempt was made to dynamically link to a task, or there was a sharing or network-protection error';
    MSG_ERROR_6  := 'Library required separate data segments for each task';
    MSG_ERROR_8  := 'There was insufficient memory to start the application';
    MSG_ERROR_10 := 'Windows version was incorrect';
    MSG_ERROR_11 :=
      'Executable file was invalid. Either it was not a Windows application or there was an error in the .EXE image';
    MSG_ERROR_12 := 'Application was designed for a different operating system';
    MSG_ERROR_13 := 'Application was designed for MS-DOS 4.0';
    MSG_ERROR_14 := 'Type of executable file was unknown';
    MSG_ERROR_15 :=
      'Attempt was made to load a real-mode application (developed for an earlier version of Windows)';
    MSG_ERROR_16 :=
      'Attempt to load second instance of an executable containing multiple data segments not marked read-only';
    MSG_ERROR_19 :=
      'Attempt was made to load a compressed executable file. The file must be decompressed before it can be loaded';
    MSG_ERROR_20 :=
      'Dynamic-link library (DLL) file was invalid. One of the DLLs required to run this application was corrupt';
    MSG_ERROR_21 := 'Application requires 32-bit extensions';
    MSG_ERROR_32_AND_MORE := 'No error';
  end;

  if (ALangType = ltItalian) then
  begin
    MSG_ERROR_0  :=
      'Il sistema non dispone di memoria sufficiente, il file eseguibile e'' danneggiato, od i riferimenti sono sbagliati';
    MSG_ERROR_2  := 'File non trovato';
    MSG_ERROR_3  := 'Path non trovato';
    MSG_ERROR_5  :=
      'E'' stato fatto un tentativo per collegarsi dinamicamente all''applicazione, o c''e'' stato un errore di condivisione o di protezione della rete';
    MSG_ERROR_6  :=
      'La libreria richiede segmenti di dati differenti per ogni copia dell''applicazione';
    MSG_ERROR_8  := 'Non c''e'' abbastanza memoria per lanciare l''applicazione';
    MSG_ERROR_10 := 'Versione errata di Windows';
    MSG_ERROR_11 :=
      'File eseguibile invalido. Potrebbe non essere un''applicazione per Windows o c''e'' un errore nell''immagine .EXE ';
    MSG_ERROR_12 := 'Applicazione destinata ad un sistema operativo differente';
    MSG_ERROR_13 := 'Applicazione per MS-DOS 4.0';
    MSG_ERROR_14 := 'File eseguibile di tipo sconosciuto';
    MSG_ERROR_15 :=
      'E'' stato fatto un tentativo per caricare l''applicazione di modalita'' reale (sviluppata per le precedenti versioni di Windows)';
    MSG_ERROR_16 :=
      'E'' stato fatto un tentativo per caricare una seconda volta un eseguibile che contiene segmenti di dati multipli non marcati Sola Lettura';
    MSG_ERROR_19 :=
      'E'' stato fatto un tentativo per caricare un file eseguibile compresso. Il file deve essere decompresso prima di poter essere caricato';
    MSG_ERROR_20 :=
      'La libreria DLL non e'' valida. Una delle librerie DLL richieste dall''applicazione per poter girare e'' danneggiata';
    MSG_ERROR_21 := 'L''Applicazione richiede l''installazione delle estensioni a 32-Bit';
    MSG_ERROR_32_AND_MORE := 'Nessun errore';
  end;
end;

end.

