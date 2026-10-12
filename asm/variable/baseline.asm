; Assembly listing for method Utf8VariableBenchmarks:Setup():this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 1 single block inlinees; 0 inlinees without PGO data

G_M000_IG01:                ;; offset=0x0000
       push     rbx
       sub      rsp, 32
       mov      rbx, rcx
 
G_M000_IG02:                ;; offset=0x0008
       mov      ecx, dword ptr [rbx+0x10]
       cmp      ecx, 4
       ja       SHORT G_M000_IG11
 
G_M000_IG03:                ;; offset=0x0010
       mov      ecx, ecx
       lea      rdx, [reloc @RWD00]
       mov      edx, dword ptr [rdx+4*rcx]
       lea      rax, G_M000_IG02
       add      rdx, rax
       jmp      rdx
 
G_M000_IG04:                ;; offset=0x0028
       mov      rdx, 0x15AA4C04BE0
       jmp      SHORT G_M000_IG09
 
G_M000_IG05:                ;; offset=0x0034
       mov      rdx, 0x15AA4C04C00
       jmp      SHORT G_M000_IG09
 
G_M000_IG06:                ;; offset=0x0040
       mov      ecx, 97
       mov      edx, 0x400
       call     System.String:.ctor(char,int):this
       mov      rdx, rax
       jmp      SHORT G_M000_IG09
 
G_M000_IG07:                ;; offset=0x0054
       mov      ecx, 97
       mov      edx, 64
       call     System.String:.ctor(char,int):this
       mov      rdx, rax
       jmp      SHORT G_M000_IG09
 
G_M000_IG08:                ;; offset=0x0068
       mov      ecx, 97
       mov      edx, 5
       call     System.String:.ctor(char,int):this
       mov      rdx, rax
 
G_M000_IG09:                ;; offset=0x007A
       lea      rcx, bword ptr [rbx+0x08]
       call     CORINFO_HELP_ASSIGN_REF
       nop      
 
G_M000_IG10:                ;; offset=0x0084
       add      rsp, 32
       pop      rbx
       ret      
 
G_M000_IG11:                ;; offset=0x008A
       mov      rcx, 0x7FFC57A12B48
       call     CORINFO_HELP_NEWSFAST
       mov      rbx, rax
       mov      rcx, rbx
       call     [System.ArgumentOutOfRangeException:.ctor():this]
       mov      rcx, rbx
       call     CORINFO_HELP_THROW
       int3     
 
RWD00  	dd	00000060h ; case G_M000_IG08
       	dd	0000004Ch ; case G_M000_IG07
       	dd	00000038h ; case G_M000_IG06
       	dd	0000002Ch ; case G_M000_IG05
       	dd	00000020h ; case G_M000_IG04

; Total bytes of code 174 for method Utf8VariableBenchmarks:Setup():this (FullOpts)

; Assembly listing for method Utf8VariableBenchmarks:String():int:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 2 single block inlinees; 3 inlinees without PGO data

G_M000_IG01:                ;; offset=0x0000
       push     rdi
       push     rsi
       push     rbp
       push     rbx
       sub      rsp, 56
       xor      eax, eax
       mov      qword ptr [rsp+0x30], rax
 
G_M000_IG02:                ;; offset=0x000F
       mov      r8, 0x15ACA400220
       mov      rbx, gword ptr [r8]
       mov      r8, gword ptr [rcx+0x08]
       test     r8, r8
       je       SHORT G_M000_IG06
       lea      r9, bword ptr [r8+0x0C]
       mov      bword ptr [rsp+0x30], r9
       mov      rsi, bword ptr [rsp+0x30]
       mov      edi, dword ptr [r8+0x08]
       lea      r8, [rsp+0x28]
       lea      r9, [rsp+0x20]
       mov      rcx, rsi
       mov      edx, edi
       call     [System.Text.Unicode.Utf16Utility:GetPointerToFirstInvalidChar(ptr,int,byref,byref):ptr]
       sub      rax, rsi
       mov      r9, rax
       shr      r9, 63
       add      r9, rax
       sar      r9, 1
       movsxd   rbp, r9d
       add      rbp, qword ptr [rsp+0x28]
       cmp      rbp, 0x7FFFFFFF
       ja       SHORT G_M000_IG07
       cmp      r9d, edi
       je       SHORT G_M000_IG04
 
G_M000_IG03:                ;; offset=0x0072
       mov      rcx, rbx
       mov      rdx, rsi
       mov      r8d, edi
       call     [System.Text.Encoding:GetByteCountWithFallback(ptr,int,int):int:this]
       add      ebp, eax
       js       SHORT G_M000_IG07
 
G_M000_IG04:                ;; offset=0x0085
       xor      rax, rax
       mov      bword ptr [rsp+0x30], rax
       mov      eax, ebp
 
G_M000_IG05:                ;; offset=0x008E
       add      rsp, 56
       pop      rbx
       pop      rbp
       pop      rsi
       pop      rdi
       ret      
 
G_M000_IG06:                ;; offset=0x0097
       mov      ecx, 14
       call     [System.ThrowHelper:ThrowArgumentNullException(int)]
       int3     
 
G_M000_IG07:                ;; offset=0x00A3
       call     [System.Text.Encoding:ThrowConversionOverflow()]
       int3     
 
; Total bytes of code 170 for method Utf8VariableBenchmarks:String():int:this (FullOpts)

; Assembly listing for method Utf8VariableBenchmarks:Span():int:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 5 single block inlinees; 3 inlinees without PGO data

G_M000_IG01:                ;; offset=0x0000
       push     rdi
       push     rsi
       push     rbp
       push     rbx
       sub      rsp, 56
       xor      eax, eax
       mov      qword ptr [rsp+0x30], rax
 
G_M000_IG02:                ;; offset=0x000F
       mov      r8, 0x15ACA400220
       mov      rbx, gword ptr [r8]
       mov      r8, gword ptr [rcx+0x08]
       test     r8, r8
       je       SHORT G_M000_IG04
 
G_M000_IG03:                ;; offset=0x0025
       lea      rsi, bword ptr [r8+0x0C]
       mov      edi, dword ptr [r8+0x08]
       jmp      SHORT G_M000_IG05
 
G_M000_IG04:                ;; offset=0x002F
       xor      rsi, rsi
       xor      edi, edi
 
G_M000_IG05:                ;; offset=0x0033
       mov      bword ptr [rsp+0x30], rsi
       lea      r8, [rsp+0x28]
       lea      r9, [rsp+0x20]
       mov      rcx, rsi
       mov      edx, edi
       call     [System.Text.Unicode.Utf16Utility:GetPointerToFirstInvalidChar(ptr,int,byref,byref):ptr]
       sub      rax, rsi
       mov      r9, rax
       shr      r9, 63
       add      r9, rax
       sar      r9, 1
       movsxd   rbp, r9d
       add      rbp, qword ptr [rsp+0x28]
       cmp      rbp, 0x7FFFFFFF
       ja       SHORT G_M000_IG09
       cmp      r9d, edi
       je       SHORT G_M000_IG07
 
G_M000_IG06:                ;; offset=0x0073
       mov      rcx, rbx
       mov      rdx, rsi
       mov      r8d, edi
       call     [System.Text.Encoding:GetByteCountWithFallback(ptr,int,int):int:this]
       add      ebp, eax
       js       SHORT G_M000_IG09
 
G_M000_IG07:                ;; offset=0x0086
       xor      rax, rax
       mov      bword ptr [rsp+0x30], rax
       mov      eax, ebp
 
G_M000_IG08:                ;; offset=0x008F
       add      rsp, 56
       pop      rbx
       pop      rbp
       pop      rsi
       pop      rdi
       ret      
 
G_M000_IG09:                ;; offset=0x0098
       call     [System.Text.Encoding:ThrowConversionOverflow()]
       int3     
 
; Total bytes of code 159 for method Utf8VariableBenchmarks:Span():int:this (FullOpts)

; Assembly listing for method Utf8VariableBenchmarks:FitsString():bool:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 2 single block inlinees; 3 inlinees without PGO data

G_M000_IG01:                ;; offset=0x0000
       push     rdi
       push     rsi
       push     rbp
       push     rbx
       sub      rsp, 56
       xor      eax, eax
       mov      qword ptr [rsp+0x30], rax
 
G_M000_IG02:                ;; offset=0x000F
       mov      r8, 0x15ACA400220
       mov      rbx, gword ptr [r8]
       mov      r8, gword ptr [rcx+0x08]
       test     r8, r8
       je       G_M000_IG06
       lea      r9, bword ptr [r8+0x0C]
       mov      bword ptr [rsp+0x30], r9
       mov      rsi, bword ptr [rsp+0x30]
       mov      edi, dword ptr [r8+0x08]
       lea      r8, [rsp+0x28]
       lea      r9, [rsp+0x20]
       mov      rcx, rsi
       mov      edx, edi
       call     [System.Text.Unicode.Utf16Utility:GetPointerToFirstInvalidChar(ptr,int,byref,byref):ptr]
       sub      rax, rsi
       mov      r9, rax
       shr      r9, 63
       add      r9, rax
       sar      r9, 1
       movsxd   rbp, r9d
       add      rbp, qword ptr [rsp+0x28]
       cmp      rbp, 0x7FFFFFFF
       ja       SHORT G_M000_IG07
       cmp      r9d, edi
       je       SHORT G_M000_IG04
 
G_M000_IG03:                ;; offset=0x0076
       mov      rcx, rbx
       mov      rdx, rsi
       mov      r8d, edi
       call     [System.Text.Encoding:GetByteCountWithFallback(ptr,int,int):int:this]
       add      ebp, eax
       js       SHORT G_M000_IG07
 
G_M000_IG04:                ;; offset=0x0089
       xor      rax, rax
       mov      bword ptr [rsp+0x30], rax
       cmp      ebp, 128
       setle    al
       movzx    rax, al
 
G_M000_IG05:                ;; offset=0x009C
       add      rsp, 56
       pop      rbx
       pop      rbp
       pop      rsi
       pop      rdi
       ret      
 
G_M000_IG06:                ;; offset=0x00A5
       mov      ecx, 14
       call     [System.ThrowHelper:ThrowArgumentNullException(int)]
       int3     
 
G_M000_IG07:                ;; offset=0x00B1
       call     [System.Text.Encoding:ThrowConversionOverflow()]
       int3     
 
; Total bytes of code 184 for method Utf8VariableBenchmarks:FitsString():bool:this (FullOpts)

; Assembly listing for method Utf8VariableBenchmarks:FitsSpan():bool:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 5 single block inlinees; 3 inlinees without PGO data

G_M000_IG01:                ;; offset=0x0000
       push     rdi
       push     rsi
       push     rbp
       push     rbx
       sub      rsp, 56
       xor      eax, eax
       mov      qword ptr [rsp+0x30], rax
 
G_M000_IG02:                ;; offset=0x000F
       mov      r8, 0x15ACA400220
       mov      rbx, gword ptr [r8]
       mov      r8, gword ptr [rcx+0x08]
       test     r8, r8
       je       SHORT G_M000_IG04
 
G_M000_IG03:                ;; offset=0x0025
       lea      rsi, bword ptr [r8+0x0C]
       mov      edi, dword ptr [r8+0x08]
       jmp      SHORT G_M000_IG05
 
G_M000_IG04:                ;; offset=0x002F
       xor      rsi, rsi
       xor      edi, edi
 
G_M000_IG05:                ;; offset=0x0033
       mov      bword ptr [rsp+0x30], rsi
       lea      r8, [rsp+0x28]
       lea      r9, [rsp+0x20]
       mov      rcx, rsi
       mov      edx, edi
       call     [System.Text.Unicode.Utf16Utility:GetPointerToFirstInvalidChar(ptr,int,byref,byref):ptr]
       sub      rax, rsi
       mov      r9, rax
       shr      r9, 63
       add      r9, rax
       sar      r9, 1
       movsxd   rbp, r9d
       add      rbp, qword ptr [rsp+0x28]
       cmp      rbp, 0x7FFFFFFF
       ja       SHORT G_M000_IG09
       cmp      r9d, edi
       je       SHORT G_M000_IG07
 
G_M000_IG06:                ;; offset=0x0073
       mov      rcx, rbx
       mov      rdx, rsi
       mov      r8d, edi
       call     [System.Text.Encoding:GetByteCountWithFallback(ptr,int,int):int:this]
       add      ebp, eax
       js       SHORT G_M000_IG09
 
G_M000_IG07:                ;; offset=0x0086
       xor      rax, rax
       mov      bword ptr [rsp+0x30], rax
       cmp      ebp, 128
       setle    al
       movzx    rax, al
 
G_M000_IG08:                ;; offset=0x0099
       add      rsp, 56
       pop      rbx
       pop      rbp
       pop      rsi
       pop      rdi
       ret      
 
G_M000_IG09:                ;; offset=0x00A2
       call     [System.Text.Encoding:ThrowConversionOverflow()]
       int3     
 
; Total bytes of code 169 for method Utf8VariableBenchmarks:FitsSpan():bool:this (FullOpts)

