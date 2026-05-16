!include "MUI2.nsh"

; ── Compression ──────────────────────────────────────────────────────────────
SetCompressor /SOLID lzma
SetCompressorDictSize 64

; ── App Info ──────────────────────────────────────────────────────────────────
Name "ProtoBot Rebuilt"
OutFile "ProtoBotRebuilt-Installer.exe"
InstallDir "$PROGRAMFILES64\ProtoBot Rebuilt"
InstallDirRegKey HKLM "Software\ProtoBot Rebuilt" "InstallDir"
RequestExecutionLevel admin

; ── UI ──────────────────────────────────────────────────────────────────────
!define MUI_ABORTWARNING
!define MUI_ICON "Assets/Sprites/Logos/AppIcon.ico"
!define MUI_UNICON "Assets/Sprites/Logos/AppIcon.ico"

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
  CreateDirectory "$SMPROGRAMS\ProtoBot Rebuilt"
  CreateShortcut "$SMPROGRAMS\ProtoBot Rebuilt\ProtoBot Rebuilt.lnk" "$INSTDIR\ProtoBot Rebuilt.exe"

  ; Desktop shortcut
  CreateShortcut "$DESKTOP\ProtoBot Rebuilt.lnk" "$INSTDIR\ProtoBot Rebuilt.exe"

  ; Write uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ; Add to Windows Add/Remove Programs
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ProtoBot Rebuilt" "DisplayName" "ProtoBot Rebuilt"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ProtoBot Rebuilt" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ProtoBot Rebuilt" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ProtoBot Rebuilt" "DisplayIcon" "$INSTDIR\ProtoBot Rebuilt.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ProtoBot Rebuilt" "Publisher" "ProtoBot Rebuilt"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ProtoBot Rebuilt" "DisplayVersion" "1.0.0"
SectionEnd

; ── Uninstall ────────────────────────────────────────────────────────────────
Section "Uninstall"
  RMDir /r "$INSTDIR"

  Delete "$DESKTOP\ProtoBot Rebuilt.lnk"
  RMDir /r "$SMPROGRAMS\ProtoBot Rebuilt"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ProtoBot Rebuilt"
  DeleteRegKey HKLM "Software\ProtoBot Rebuilt"
SectionEnd