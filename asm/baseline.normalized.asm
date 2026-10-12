; Assembly listing for method Utf8BufferBenchmarks:EncodeLiteralHeader():int:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rbp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 10 single block inlinees; 7 inlinees without PGO data

G_M000_IG01:
       push     rbp
       push     r15
       push     r14
       push     rdi
       push     rsi
       push     rbx
       sub      rsp, 120
       lea      rbp, [rsp+0x40]
       vxorps   xmm4, xmm4, xmm4
       vmovdqu  ymmword ptr [rbp], ymm4
       vmovdqa  xmmword ptr [rbp+0x20], xmm4
       mov      rax, 0xRELOC
       mov      qword ptr [rbp+0x30], rax
 
G_M000_IG02:
       mov      r8, 0xRELOC
       mov      rbx, gword ptr [r8]
       mov      rsi, rbx
       mov      rdi, 0xRELOC
       mov      r14, rdi
       lea      r8, [rbp+0x28]
       lea      r9, [rbp+0x20]
       mov      rcx, r14
       mov      edx, 32
       call     [System.Text.Unicode.Utf16Utility:GetPointerToFirstInvalidChar(ptr,int,byref,byref):ptr]
       sub      rax, r14
       mov      r9, rax
       shr      r9, 63
       add      r9, rax
       sar      r9, 1
       movsxd   r15, r9d
       add      r15, qword ptr [rbp+0x28]
       cmp      r15, 0x7FFFFFFF
       ja       G_M000_IG15
       cmp      r9d, 32
       je       SHORT G_M000_IG04
 
G_M000_IG03:
       mov      rcx, rsi
       mov      rdx, r14
       mov      r8d, 32
       call     [System.Text.Encoding:GetByteCountWithFallback(ptr,int,int):int:this]
       add      r15d, eax
       js       G_M000_IG15
 
G_M000_IG04:
       cmp      r15d, 64
       jle      SHORT G_M000_IG06
 
G_M000_IG05:
       mov      edx, r15d
       mov      rcx, 0xRELOC
       call     CORINFO_HELP_NEWARR_1_VC
       lea      rsi, bword ptr [rax+0x10]
       mov      r14d, dword ptr [rax+0x08]
       jmp      SHORT G_M000_IG09
 
G_M000_IG06:
       mov      ecx, r15d
       mov      rsi, rcx
       test     rsi, rsi
       je       SHORT G_M000_IG08
       add      rsi, 15
       shr      rsi, 4
       add      rsp, 64
 
G_M000_IG07:
       push     0
       push     0
       dec      rsi
       jne      SHORT G_M000_IG07
       sub      rsp, 64
       lea      rsi, [rsp+0x40]
 
G_M000_IG08:
       test     r15d, r15d
       jl       G_M000_IG16
       mov      r14d, r15d
 
G_M000_IG09:
       mov      bword ptr [rbp+0x18], rdi
       mov      bword ptr [rbp+0x10], rsi
       mov      r15, rsi
       lea      rcx, [rbp+0x08]
       mov      qword ptr [rsp+0x20], rcx
       lea      rcx, [rbp]
       mov      qword ptr [rsp+0x28], rcx
       mov      rcx, rdi
       mov      r8, r15
       mov      r9d, r14d
       mov      edx, 32
       call     [System.Text.Unicode.Utf8Utility:TranscodeToUtf8(ptr,int,ptr,int,byref,byref):int]
       mov      rcx, qword ptr [rbp+0x08]
       sub      rcx, rdi
       mov      rdx, rcx
       shr      rdx, 63
       add      rcx, rdx
       sar      rcx, 1
       mov      eax, dword ptr [rbp]
       sub      eax, r15d
       cmp      ecx, 32
       je       SHORT G_M000_IG11
 
G_M000_IG10:
       mov      dword ptr [rsp+0x20], r14d
       mov      dword ptr [rsp+0x28], ecx
       mov      dword ptr [rsp+0x30], eax
       mov      dword ptr [rsp+0x38], 1
       mov      rcx, rbx
       mov      rdx, rdi
       mov      r9, r15
       mov      r8d, 32
       call     [System.Text.Encoding:GetBytesWithFallback(ptr,int,ptr,int,int,int,bool):int:this]
 
G_M000_IG11:
       xor      r9, r9
       mov      bword ptr [rbp+0x18], r9
 
G_M000_IG12:
       mov      bword ptr [rbp+0x10], r9
       test     r14d, r14d
       je       SHORT G_M000_IG17
       movzx    r9, byte  ptr [rsi]
       add      r9d, eax
       dec      eax
       cmp      eax, r14d
       jae      SHORT G_M000_IG17
       movzx    rax, byte  ptr [rsi+rax]
       add      eax, r9d
       mov      r9, 0xRELOC
       cmp      qword ptr [rbp+0x30], r9
       je       SHORT G_M000_IG13
       call     CORINFO_HELP_FAIL_FAST
 
G_M000_IG13:
       nop      
 
G_M000_IG14:
       lea      rsp, [rbp+0x38]
       pop      rbx
       pop      rsi
       pop      rdi
       pop      r14
       pop      r15
       pop      rbp
       ret      
 
G_M000_IG15:
       call     [System.Text.Encoding:ThrowConversionOverflow()]
       int3     
 
G_M000_IG16:
       call     [System.ThrowHelper:ThrowArgumentOutOfRangeException()]
       int3     
 
G_M000_IG17:
       call     CORINFO_HELP_RNGCHKFAIL
       int3     
 
; Total bytes of code 466 for method Utf8BufferBenchmarks:EncodeLiteralHeader():int:this (FullOpts)


