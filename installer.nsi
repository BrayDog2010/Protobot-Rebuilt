!include "MUI2.nsh"

; ── App Info ────────────────────────────────────────────────────────────────
Name "Protobot Rebuilt"
OutFile "ProtobotRebuilt-Installer.exe"
InstallDir "$PROGRAMFILES64\Protobot Rebuilt"
InstallDirRegKey HKLM "Software\Protobot Rebuilt" "InstallDir"
RequestExecutionLevel admin

; ── UI ──────────────────────────────────────────────────────────────────────
!define MUI_ABORTWARNING
!define MUI_ICON "Assets\Sprites\Logos\AppIcon.ico"           ; your game icon
!define MUI_UNICON "Assets\Sprites\Logos\AppIcon.ico"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

; ── Install ──────────────────────────────────────────────────────────────────
Section "Install"
  SetOutPath "$INSTDIR"
  File /r "build\StandaloneWindows64\*"

  ; Start menu shortcut
  CreateDirectory "$SMPROGRAMS\Protobot Rebuilt"
  CreateShortcut "$SMPROGRAMS\Protobot Rebuilt\Protobot Rebuilt.lnk" "$INSTDIR\Protobot Rebuilt.exe"

  ; Desktop shortcut
  CreateShortcut "$DESKTOP\Protobot Rebuilt.lnk" "$INSTDIR\Protobot Rebuilt.exe"

  ; Write uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ; Add to Windows Add/Remove Programs
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Protobot Rebuilt" "DisplayName" "Protobot Rebuilt"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Protobot Rebuilt" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Protobot Rebuilt" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Protobot Rebuilt" "DisplayIcon" "$INSTDIR\Protobot Rebuilt.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Protobot Rebuilt" "Publisher" "YourName"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Protobot Rebuilt" "DisplayVersion" "1.0.0"
SectionEnd

; ── Uninstall ────────────────────────────────────────────────────────────────
Section "Uninstall"
  RMDir /r "$INSTDIR"

  Delete "$DESKTOP\Protobot Rebuilt.lnk"
  RMDir /r "$SMPROGRAMS\Protobot Rebuilt"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Protobot Rebuilt"
  DeleteRegKey HKLM "Software\Protobot Rebuilt"
SectionEnd