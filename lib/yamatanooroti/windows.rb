require 'test-unit'
require 'fiddle/import'
require 'fiddle/types'

module Yamatanooroti::WindowsDefinition
  extend Fiddle::Importer
  dlload 'kernel32.dll', 'psapi.dll', 'user32.dll'
  include Fiddle::Win32Types

  FREE = Fiddle::Function.new(Fiddle::RUBY_FREE, [Fiddle::TYPE_VOIDP], Fiddle::TYPE_VOID)

  typealias 'SHORT', 'short'
  typealias 'HPCON', 'HANDLE'
  typealias 'HPCON', 'HANDLE'
  typealias 'HRESULT', 'HANDLE'
  typealias 'LPVOID', 'void*'
  typealias 'SIZE_T', 'size_t'
  typealias 'LPWSTR', 'void*'
  typealias 'LPBYTE', 'void*'
  typealias 'LPCWSTR', 'void*'
  typealias 'LPPROC_THREAD_ATTRIBUTE_LIST', 'void*'
  typealias 'PSIZE_T', 'void*'
  typealias 'DWORD_PTR', 'void*'
  typealias 'LPCVOID', 'void*'
  typealias 'LPDWORD', 'void*'
  typealias 'LPOVERLAPPED', 'void*'
  typealias 'WCHAR', 'SHORT'
  typealias 'LPCWCH', 'void*'
  typealias 'LPSTR', 'void*'
  typealias 'LPCCH', 'void*'
  typealias 'LPBOOL', 'void*'
  typealias 'LPWORD', 'void*'
  typealias 'ULONG_PTR', 'ULONG*'
  typealias 'LONG', 'int'

  Fiddle::SIZEOF_HANDLE = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_HPCON = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_HRESULT = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_DWORD = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_WORD = Fiddle::SIZEOF_SHORT

  COORD = struct [
    'SHORT X',
    'SHORT Y'
  ]
  typealias 'COORD', 'DWORD32'

  SMALL_RECT = struct [
    'SHORT Left',
    'SHORT Top',
    'SHORT Right',
    'SHORT Bottom'
  ]
  typealias 'SMALL_RECT*', 'DWORD64*'
  typealias 'PSMALL_RECT', 'SMALL_RECT*'

  SECURITY_ATTRIBUTES = struct [
    'DWORD nLength',
    'LPVOID lpSecurityDescriptor',
    'BOOL bInheritHandle'
  ]
  typealias 'PSECURITY_ATTRIBUTES', 'SECURITY_ATTRIBUTES*'
  typealias 'LPSECURITY_ATTRIBUTES', 'SECURITY_ATTRIBUTES*'

  STARTUPINFOW = struct [
    'DWORD cb',
    'LPWSTR lpReserved',
    'LPWSTR lpDesktop',
    'LPWSTR lpTitle',
    'DWORD dwX',
    'DWORD dwY',
    'DWORD dwXSize',
    'DWORD dwYSize',
    'DWORD dwXCountChars',
    'DWORD dwYCountChars',
    'DWORD dwFillAttribute',
    'DWORD dwFlags',
    'WORD wShowWindow',
    'WORD cbReserved2',
    'LPBYTE lpReserved2',
    'HANDLE hStdInput',
    'HANDLE hStdOutput',
    'HANDLE hStdError'
  ]
  typealias 'LPSTARTUPINFOW', 'STARTUPINFOW*'

  PROCESS_INFORMATION = struct [
    'HANDLE hProcess',
    'HANDLE hThread',
    'DWORD  dwProcessId',
    'DWORD  dwThreadId'
  ]
  typealias 'PPROCESS_INFORMATION', 'PROCESS_INFORMATION*'
  typealias 'LPPROCESS_INFORMATION', 'PROCESS_INFORMATION*'

  INPUT_RECORD_WITH_KEY_EVENT = struct [
    'WORD EventType',
    'BOOL bKeyDown',
    'WORD wRepeatCount',
    'WORD wVirtualKeyCode',
    'WORD wVirtualScanCode',
    'WCHAR UnicodeChar',
    ## union 'CHAR  AsciiChar',
    'DWORD dwControlKeyState'
  ]

  CHAR_INFO = struct [
    'WCHAR UnicodeChar',
    'WORD Attributes'
  ]
  typealias 'PCHAR_INFO', 'CHAR_INFO*'

  PROCESSENTRY32W = struct [
    'DWORD dwSize',
    'DWORD cntUsage',
    'DWORD th32ProcessID',
    'ULONG_PTR th32DefaultHeapID',
    'DWORD th32ModuleID',
    'DWORD cntThreads',
    'DWORD th32ParentProcessID',
    'LONG pcPriClassBase',
    'DWORD dwFlags',
    'WCHAR szExeFile[260]'
  ]
  typealias 'LPPROCESSENTRY32W', 'PROCESSENTRY32W*'

  CONSOLE_FONT_INFOEX = struct [
    'ULONG cbSize',
    'DWORD nFont',
    'DWORD32 dwFontSize',
    'UINT FontFamily',
    'UINT FontWeight',
    'WCHAR FaceName[32]'
  ]
  typealias 'PCONSOLE_FONT_INFOEX', 'CONSOLE_FONT_INFOEX*'

  STD_INPUT_HANDLE = -10
  STD_OUTPUT_HANDLE = -11
  STD_ERROR_HANDLE = -12
  ATTACH_PARENT_PROCESS = -1
  KEY_EVENT = 0x0001
  CT_CTYPE3 = 0x04
  C3_HIRAGANA = 0x0020
  C3_HALFWIDTH = 0x0040
  C3_FULLWIDTH = 0x0080
  C3_IDEOGRAPH = 0x0100
  TH32CS_SNAPPROCESS = 0x00000002
  PROCESS_ALL_ACCESS = 0x001FFFFF

  # HANDLE GetStdHandle(DWORD nStdHandle);
  extern 'HANDLE GetStdHandle(DWORD);', :stdcall
  # BOOL CloseHandle(HANDLE hObject);
  extern 'BOOL CloseHandle(HANDLE);', :stdcall

  # BOOL FreeConsole(void);
  extern 'BOOL FreeConsole(void);', :stdcall
  # BOOL AllocConsole(void);
  extern 'BOOL AllocConsole(void);', :stdcall
  # BOOL AttachConsole(DWORD dwProcessId);
  extern 'BOOL AttachConsole(DWORD);', :stdcall
  # BOOL WINAPI SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);
  extern 'BOOL SetConsoleScreenBufferSize(HANDLE, COORD);', :stdcall
  # BOOL WINAPI SetConsoleWindowInfo(HANDLE hConsoleOutput, BOOL bAbsolute, const SMALL_RECT *lpConsoleWindow);
  extern 'BOOL SetConsoleWindowInfo(HANDLE, BOOL, PSMALL_RECT);', :stdcall
  # BOOL WriteConsoleInputW(HANDLE hConsoleInput, const INPUT_RECORD *lpBuffer, DWORD nLength, LPDWORD lpNumberOfEventsWritten);
  extern 'BOOL WriteConsoleInputW(HANDLE, const INPUT_RECORD*, DWORD, LPDWORD);', :stdcall
  # BOOL ReadConsoleOutputW(HANDLE hConsoleOutput, PCHAR_INFO lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, PSMALL_RECT lpReadRegion);
  extern 'BOOL ReadConsoleOutputW(HANDLE, PCHAR_INFO, COORD, COORD, PSMALL_RECT);', :stdcall
  # BOOL WINAPI SetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, PCONSOLE_FONT_INFOEX lpConsoleCurrentFontEx);
  extern 'BOOL SetCurrentConsoleFontEx(HANDLE, BOOL, PCONSOLE_FONT_INFOEX);', :stdcall

  # BOOL CreateProcessW(LPCWSTR lpApplicationName, LPWSTR lpCommandLine, LPSECURITY_ATTRIBUTES lpProcessAttributes, LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles, DWORD dwCreationFlags, LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo, LPPROCESS_INFORMATION lpProcessInformation);
  extern 'BOOL CreateProcessW(LPCWSTR lpApplicationName, LPWSTR lpCommandLine, LPSECURITY_ATTRIBUTES lpProcessAttributes, LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles, DWORD dwCreationFlags, LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo, LPPROCESS_INFORMATION lpProcessInformation);', :stdcall
  # void GetStartupInfoW(LPSTARTUPINFOW lpStartupInfo);
  extern 'void GetStartupInfoW(LPSTARTUPINFOW);', :stdcall
  # HANDLE CreateToolhelp32Snapshot(DWORD dwFlags, DWORD th32ProcessID);
  extern 'HANDLE CreateToolhelp32Snapshot(DWORD, DWORD);', :stdcall
  # BOOL Process32First(HANDLE hSnapshot, LPPROCESSENTRY32W lppe);
  extern 'BOOL Process32FirstW(HANDLE, LPPROCESSENTRY32W);', :stdcall
  # BOOL Process32Next(HANDLE hSnapshot, LPPROCESSENTRY32 lppe);
  extern 'BOOL Process32NextW(HANDLE, LPPROCESSENTRY32W);', :stdcall
  # DWORD GetCurrentProcessId();
  extern 'DWORD GetCurrentProcessId();', :stdcall
  # HANDLE OpenProcess(DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwProcessId);
  extern 'HANDLE OpenProcess(DWORD, BOOL, DWORD);', :stdcall
  # BOOL TerminateProcess(HANDLE hProcess, UINT uExitCode);
  extern 'BOOL TerminateProcess(HANDLE, UINT);', :stdcall
  #BOOL TerminateThread(HANDLE hThread, DWORD dwExitCode);
  extern 'BOOL TerminateThread(HANDLE, DWORD);', :stdcall

  # int MultiByteToWideChar(UINT CodePage, DWORD dwFlags, LPCSTR lpMultiByteStr, int cbMultiByte, LPWSTR lpWideCharStr, int cchWideChar);
  extern 'int MultiByteToWideChar(UINT, DWORD, LPCSTR, int, LPWSTR, int);', :stdcall
  # int WideCharToMultiByte(UINT CodePage, DWORD dwFlags, _In_NLS_string_(cchWideChar)LPCWCH lpWideCharStr, int cchWideChar, LPSTR lpMultiByteStr, int cbMultiByte, LPCCH lpDefaultChar, LPBOOL lpUsedDefaultChar);
  extern 'int WideCharToMultiByte(UINT, DWORD, LPCWCH, int, LPSTR, int, LPCCH, LPBOOL);', :stdcall
  #BOOL GetStringTypeW(DWORD dwInfoType, LPCWCH lpSrcStr, int cchSrc, LPWORD lpCharType);
  extern 'BOOL GetStringTypeW(DWORD, LPCWCH, int, LPWORD);', :stdcall

  typealias 'LPTSTR', 'void*'
  typealias 'HLOCAL', 'HANDLE'
  extern 'DWORD FormatMessage(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId, DWORD dwLanguageId, LPTSTR lpBuffer, DWORD nSize, va_list *Arguments);', :stdcall
  extern 'HLOCAL LocalFree(HLOCAL hMem);', :stdcall
  extern 'DWORD GetLastError();', :stdcall
  FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x00000100
  FORMAT_MESSAGE_FROM_SYSTEM = 0x00001000
  LANG_NEUTRAL = 0x00
  SUBLANG_DEFAULT = 0x01
  extern 'int GetSystemMetrics(int);', :stdcall
  SM_CXMIN = 28
  SM_CYMIN = 29
end

module Yamatanooroti::WindowsTestCaseModule
  DL = Yamatanooroti::WindowsDefinition

  private def setup_console(height, width)

    result = DL.FreeConsole
    error_message(result, 'FreeConsole')
    result = DL.AllocConsole
    error_message(result, 'AllocConsole')
    @output_handle = DL.GetStdHandle(DL::STD_OUTPUT_HANDLE)

=begin
    font = DL::CONSOLE_FONT_INFOEX.malloc
    (font.to_ptr + 0)[0, DL::CONSOLE_FONT_INFOEX.size] = "\x00" * DL::CONSOLE_FONT_INFOEX.size
    font.cbSize = DL::CONSOLE_FONT_INFOEX.size
    font.nFont = 0
    font_size = 72
    font.dwFontSize = font_size * 65536 + font_size
    font.FontFamily = 0
    font.FontWeight = 0
    font.FaceName[0] = "\x00".ord
    result = DL.SetCurrentConsoleFontEx(@output_handle, 0, font)
    error_message(result, 'SetCurrentConsoleFontEx')
=end

    rect = DL::SMALL_RECT.malloc
    rect.Left = 0
    rect.Top = 0
    rect.Right = width - 1
    rect.Bottom = height - 1
    result = DL.SetConsoleWindowInfo(@output_handle, 1, rect)
    error_message(result, 'SetConsoleWindowInfo')

    size = DL.GetSystemMetrics(DL::SM_CYMIN) * 65536 + DL.GetSystemMetrics(DL::SM_CXMIN)
    result = DL.SetConsoleScreenBufferSize(@output_handle, size)
    error_message(result, 'SetConsoleScreenBufferSize')

    size = height * 65536 + width
    result = DL.SetConsoleScreenBufferSize(@output_handle, size)
    error_message(result, 'SetConsoleScreenBufferSize')
  end

  private def mb2wc(str)
    size = DL.MultiByteToWideChar(65001, 0, str, str.bytesize, '', 0)
    converted_str = String.new("\x00" * (size * 2), encoding: 'ASCII-8BIT')
    DL.MultiByteToWideChar(65001, 0, str, str.bytesize, converted_str, converted_str.bytesize)
    converted_str
  end

  private def wc2mb(str)
    size = DL.WideCharToMultiByte(65001, 0, str, str.bytesize, '', 0, 0, 0)
    converted_str = "\x00" * (size * 2)
    DL.WideCharToMultiByte(65001, 0, str, str.bytesize, converted_str, converted_str.bytesize, 0, 0)
    converted_str
  end

  private def full_width?(c)
    return false if c.nil? or c.empty?
    wc = mb2wc(c)
    type = Fiddle::Pointer.malloc(Fiddle::SIZEOF_WORD, DL::FREE)
    DL.GetStringTypeW(DL::CT_CTYPE3, wc, wc.bytesize, type)
    char_type = type[0, Fiddle::SIZEOF_WORD].unpack('S').first
    if char_type.anybits?(DL::C3_FULLWIDTH)
      true
    elsif char_type.anybits?(DL::C3_HALFWIDTH)
      false
    elsif char_type.anybits?(DL::C3_HIRAGANA)
      true
    elsif char_type.anybits?(DL::C3_IDEOGRAPH)
      true
    else
      false
    end
  end

  private def launch(command)
    command = %Q{cmd.exe /q /c "#{command.gsub('"', '\\"')}"}
    converted_command = mb2wc(command)
    @pi = DL::PROCESS_INFORMATION.malloc
    (@pi.to_ptr + 0)[0, DL::PROCESS_INFORMATION.size] = "\x00" * DL::PROCESS_INFORMATION.size
    @startup_info_ex = DL::STARTUPINFOW.malloc
    #(@startup_info_ex.to_ptr + 0)[0, DL::STARTUPINFOW.size] = "\x00" * DL::STARTUPINFOW.size
    DL.GetStartupInfoW(@startup_info_ex)
    result = DL.CreateProcessW(
      Fiddle::NULL, converted_command,
      Fiddle::NULL, Fiddle::NULL, 0, 0, Fiddle::NULL, Fiddle::NULL,
      @startup_info_ex, @pi
    )
    error_message(result, 'CreateProcessW')
    sleep @wait
  rescue => e
    pp e
  end

  private def error_message(result, method_name)
    return if not result.zero?
    err = DL.GetLastError
    string = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
    DL.FormatMessage(
      DL::FORMAT_MESSAGE_ALLOCATE_BUFFER | DL::FORMAT_MESSAGE_FROM_SYSTEM,
      Fiddle::NULL,
      err,
      0x0,
      string,
      0,
      Fiddle::NULL
    )
    log "ERROR(#{method_name}): #{err.to_s}: #{string.ptr.to_s}"
    DL.LocalFree(string)
  end

  private def log(str)
    puts str
    open('aaa', 'a') do |fp|
      fp.puts str
    end
  end

  def write(str)
    sleep @wait
    str.tr!("\n", "\r")
    records = Fiddle::Pointer.malloc(DL::INPUT_RECORD_WITH_KEY_EVENT.size * str.size * 2, DL::FREE)
    str.chars.each_with_index do |c, i|
      record_index = i * 2
      r = DL::INPUT_RECORD_WITH_KEY_EVENT.new(records + DL::INPUT_RECORD_WITH_KEY_EVENT.size * record_index)
      r.EventType = DL::KEY_EVENT
      r.bKeyDown = 1
      r.wRepeatCount = 0
      r.wVirtualKeyCode = 0
      r.wVirtualScanCode = 0
      r.UnicodeChar = c.unpack('U').first
      r.dwControlKeyState = 0
      record_index = i * 2 + 1
      r = DL::INPUT_RECORD_WITH_KEY_EVENT.new(records + DL::INPUT_RECORD_WITH_KEY_EVENT.size * record_index)
      r.EventType = DL::KEY_EVENT
      r.bKeyDown = 0
      r.wRepeatCount = 0
      r.wVirtualKeyCode = 0
      r.wVirtualScanCode = 0
      r.UnicodeChar = c.unpack('U').first
      r.dwControlKeyState = 0
    end
    written_size = Fiddle::Pointer.malloc(Fiddle::SIZEOF_DWORD, DL::FREE)
    result = DL.WriteConsoleInputW(DL.GetStdHandle(DL::STD_INPUT_HANDLE), records, str.size * 2, written_size)
    error_message(result, 'WriteConsoleInput')
  end

  private def free_resources
    h_snap = DL.CreateToolhelp32Snapshot(DL::TH32CS_SNAPPROCESS, 0)
    pe = DL::PROCESSENTRY32W.malloc
    (pe.to_ptr + 0)[0, DL::PROCESSENTRY32W.size] = "\x00" * DL::PROCESSENTRY32W.size
    pe.dwSize = DL::PROCESSENTRY32W.size
    result = DL.Process32FirstW(h_snap, pe)
    error_message(result, "Process32First")
    result = DL.FreeConsole()
    #error_message(result, "FreeConsole")
    result = DL.AttachConsole(DL::ATTACH_PARENT_PROCESS)
    error_message(result, 'AttachConsole')
    loop do
      #log "a #{pe.th32ParentProcessID.inspect} -> #{pe.th32ProcessID.inspect} #{wc2mb(pe.szExeFile.pack('S260')).unpack('Z*').pack('Z*')}"
      if pe.th32ParentProcessID == DL.GetCurrentProcessId
        h_child_proc = DL.OpenProcess(DL::PROCESS_ALL_ACCESS, 0, pe.th32ProcessID)
        if (h_child_proc)
          result = DL.TerminateProcess(h_child_proc, 0)
          error_message(result, "TerminateProcess")
          result = DL.CloseHandle(h_child_proc)
          error_message(result, "CloseHandle")
        end
      end
      break if DL.Process32NextW(h_snap, pe).zero?
    end
    result = DL.TerminateThread(@pi.hThread, 0)
    error_message(result, "TerminateThread")
  end

  def close
    sleep @wait
    # read first before kill the console process including output
    char_info_matrix = Fiddle::Pointer.to_ptr("\x00" * (DL::CHAR_INFO.size * (@height * @width)))
    region = DL::SMALL_RECT.malloc
    region.Left = 0
    region.Top = 0
    region.Right = @width
    region.Bottom = @height
    result = DL.ReadConsoleOutputW(@output_handle, char_info_matrix, @height * 65536 + @width, 0, region)
    error_message(result, "ReadConsoleOutputW")
    @result = []
    prev_c = nil
    @height.times do |y|
      line = ''
      @width.times do |x|
        index = @width * y + x
        char_info = DL::CHAR_INFO.new(char_info_matrix + DL::CHAR_INFO.size * index)
        mb = [char_info.UnicodeChar].pack('U')
        if prev_c == mb and full_width?(mb)
          prev_c = nil
        else
          line << mb
          prev_c = mb
        end
      end
      @result << line.gsub(/ *$/, '')
    end

    free_resources
  end

  def assert_screen(expected_lines)
    assert_equal(expected_lines, @result)
  end

  def setup(height, width, command, wait: 1)
    @height = height
    @width = width
    @wait = wait
    setup_console(height, width)
    launch(command.join(' '))
  end

  def teardown
  end
end

class Yamatanooroti::WindowsTestCase < Test::Unit::TestCase
  include Yamatanooroti::WindowsTestCaseModule
end
