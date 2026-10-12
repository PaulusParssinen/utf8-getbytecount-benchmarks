; Assembly listing for method Utf8BufferBenchmarks:EncodeLiteralHeader():int:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rbp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 10 single block inlinees; 5 inlinees without PGO data

G_M000_IG01:
       push     rbp
       push     r15
       push     r14
       push     rdi
       push     rsi
       push     rbx
       sub      rsp, 104
       lea      rbp, [rsp+0x40]
       vxorps   xmm4, xmm4, xmm4
       vmovdqu  ymmword ptr [rbp], ymm4
       mov      rax, 0xRELOC
       mov      qword ptr [rbp+0x20], rax
 
G_M000_IG02:
       mov      rbx, 0xRELOC
       mov      esi, 32
       cmp      esi, 64
       jle      SHORT G_M000_IG04
 
G_M000_IG03:
       mov      edx, esi
       mov      rcx, 0xRELOC
       call     CORINFO_HELP_NEWARR_1_VC
       lea      rdi, bword ptr [rax+0x10]
       mov      esi, dword ptr [rax+0x08]
       jmp      SHORT G_M000_IG07
 
G_M000_IG04:
       mov      ecx, esi
       mov      rdi, rcx
       test     rdi, rdi
       je       SHORT G_M000_IG06
       add      rdi, 15
       shr      rdi, 4
       add      rsp, 64
 
G_M000_IG05:
       push     0
       push     0
       dec      rdi
       jne      SHORT G_M000_IG05
       sub      rsp, 64
       lea      rdi, [rsp+0x40]
 
G_M000_IG06:
       test     esi, esi
       jl       G_M000_IG13
 
G_M000_IG07:
       mov      rcx, 0xRELOC
       mov      r14, gword ptr [rcx]
       mov      bword ptr [rbp+0x18], rbx
       mov      bword ptr [rbp+0x10], rdi
       mov      r15, rdi
       lea      rcx, [rbp+0x08]
       mov      qword ptr [rsp+0x20], rcx
       lea      rcx, [rbp]
       mov      qword ptr [rsp+0x28], rcx
       mov      rcx, rbx
       mov      r8, r15
       mov      r9d, esi
       mov      edx, 32
       call     [System.Text.Unicode.Utf8Utility:TranscodeToUtf8(ptr,int,ptr,int,byref,byref):int]
       mov      rcx, qword ptr [rbp+0x08]
       sub      rcx, rbx
       mov      rdx, rcx
       shr      rdx, 63
       add      rcx, rdx
       sar      rcx, 1
       mov      eax, dword ptr [rbp]
       sub      eax, r15d
       cmp      ecx, 32
       je       SHORT G_M000_IG09
 
G_M000_IG08:
       mov      dword ptr [rsp+0x20], esi
       mov      dword ptr [rsp+0x28], ecx
       mov      dword ptr [rsp+0x30], eax
       mov      dword ptr [rsp+0x38], 1
       mov      rcx, r14
       mov      rdx, rbx
       mov      r9, r15
       mov      r8d, 32
       call     [System.Text.Encoding:GetBytesWithFallback(ptr,int,ptr,int,int,int,bool):int:this]
 
G_M000_IG09:
       xor      r9, r9
       mov      bword ptr [rbp+0x18], r9
 
G_M000_IG10:
       mov      bword ptr [rbp+0x10], r9
       test     esi, esi
       je       SHORT G_M000_IG14
       movzx    r9, byte  ptr [rdi]
       add      r9d, eax
       dec      eax
       cmp      eax, esi
       jae      SHORT G_M000_IG14
       movzx    rax, byte  ptr [rdi+rax]
       add      eax, r9d
       mov      r9, 0xRELOC
       cmp      qword ptr [rbp+0x20], r9
       je       SHORT G_M000_IG11
       call     CORINFO_HELP_FAIL_FAST
 
G_M000_IG11:
       nop      
 
G_M000_IG12:
       lea      rsp, [rbp+0x28]
       pop      rbx
       pop      rsi
       pop      rdi
       pop      r14
       pop      r15
       pop      rbp
       ret      
 
G_M000_IG13:
       call     [System.ThrowHelper:ThrowArgumentOutOfRangeException()]
       int3     
 
G_M000_IG14:
       call     CORINFO_HELP_RNGCHKFAIL
       int3     
 
; Total bytes of code 351 for method Utf8BufferBenchmarks:EncodeLiteralHeader():int:this (FullOpts)


