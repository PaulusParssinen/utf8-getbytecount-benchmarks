; Assembly listing for method Utf8VariableBenchmarks:Setup():this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 1 single block inlinees; 0 inlinees without PGO data

G_M000_IG01:
       push     rbx
       sub      rsp, 32
       mov      rbx, rcx
 
G_M000_IG02:
       mov      ecx, dword ptr [rbx+0x10]
       cmp      ecx, 4
       ja       SHORT G_M000_IG11
 
G_M000_IG03:
       mov      ecx, ecx
       lea      rdx, [reloc @RWD00]
       mov      edx, dword ptr [rdx+4*rcx]
       lea      rax, G_M000_IG02
       add      rdx, rax
       jmp      rdx
 
G_M000_IG04:
       mov      rdx, 0xRELOC
       jmp      SHORT G_M000_IG09
 
G_M000_IG05:
       mov      rdx, 0xRELOC
       jmp      SHORT G_M000_IG09
 
G_M000_IG06:
       mov      ecx, 97
       mov      edx, 0x400
       call     System.String:.ctor(char,int):this
       mov      rdx, rax
       jmp      SHORT G_M000_IG09
 
G_M000_IG07:
       mov      ecx, 97
       mov      edx, 64
       call     System.String:.ctor(char,int):this
       mov      rdx, rax
       jmp      SHORT G_M000_IG09
 
G_M000_IG08:
       mov      ecx, 97
       mov      edx, 5
       call     System.String:.ctor(char,int):this
       mov      rdx, rax
 
G_M000_IG09:
       lea      rcx, bword ptr [rbx+0x08]
       call     CORINFO_HELP_ASSIGN_REF
       nop      
 
G_M000_IG10:
       add      rsp, 32
       pop      rbx
       ret      
 
G_M000_IG11:
       mov      rcx, 0xRELOC
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
; 0 inlinees with PGO data; 2 single block inlinees; 1 inlinees without PGO data

G_M000_IG01:
       sub      rsp, 40
 
G_M000_IG02:
       mov      rdx, gword ptr [rcx+0x08]
       test     rdx, rdx
       je       SHORT G_M000_IG04
       lea      rcx, bword ptr [rdx+0x0C]
       mov      edx, dword ptr [rdx+0x08]
       call     [System.Text.UTF8Encoding+UTF8EncodingSealed:GetByteCount(byref,int):int]
       nop      
 
G_M000_IG03:
       add      rsp, 40
       ret      
 
G_M000_IG04:
       mov      ecx, 14
       call     [System.ThrowHelper:ThrowArgumentNullException(int)]
       int3     
 
; Total bytes of code 44 for method Utf8VariableBenchmarks:String():int:this (FullOpts)

; Assembly listing for method Utf8VariableBenchmarks:Span():int:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 5 single block inlinees; 1 inlinees without PGO data

G_M000_IG01:
       sub      rsp, 40
 
G_M000_IG02:
       mov      rcx, gword ptr [rcx+0x08]
       test     rcx, rcx
       je       SHORT G_M000_IG04
 
G_M000_IG03:
       lea      rdx, bword ptr [rcx+0x0C]
       mov      ecx, dword ptr [rcx+0x08]
       mov      eax, ecx
       jmp      SHORT G_M000_IG05
 
G_M000_IG04:
       xor      rdx, rdx
       xor      eax, eax
 
G_M000_IG05:
       mov      rcx, rdx
       mov      edx, eax
       call     [System.Text.UTF8Encoding+UTF8EncodingSealed:GetByteCount(byref,int):int]
       nop      
 
G_M000_IG06:
       add      rsp, 40
       ret      
 
; Total bytes of code 45 for method Utf8VariableBenchmarks:Span():int:this (FullOpts)

; Assembly listing for method Utf8VariableBenchmarks:FitsString():bool:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 2 single block inlinees; 1 inlinees without PGO data

G_M000_IG01:
       sub      rsp, 40
 
G_M000_IG02:
       mov      rdx, gword ptr [rcx+0x08]
       test     rdx, rdx
       je       SHORT G_M000_IG04
       lea      rcx, bword ptr [rdx+0x0C]
       mov      edx, dword ptr [rdx+0x08]
       call     [System.Text.UTF8Encoding+UTF8EncodingSealed:GetByteCount(byref,int):int]
       cmp      eax, 128
       setle    al
       movzx    rax, al
 
G_M000_IG03:
       add      rsp, 40
       ret      
 
G_M000_IG04:
       mov      ecx, 14
       call     [System.ThrowHelper:ThrowArgumentNullException(int)]
       int3     
 
; Total bytes of code 54 for method Utf8VariableBenchmarks:FitsString():bool:this (FullOpts)

; Assembly listing for method Utf8VariableBenchmarks:FitsSpan():bool:this (FullOpts)
; Emitting BLENDED_CODE for x64 + VEX + EVEX on Windows
; FullOpts code
; optimized code
; rsp based frame
; partially interruptible
; No PGO data
; 0 inlinees with PGO data; 5 single block inlinees; 1 inlinees without PGO data

G_M000_IG01:
       sub      rsp, 40
 
G_M000_IG02:
       mov      rcx, gword ptr [rcx+0x08]
       test     rcx, rcx
       je       SHORT G_M000_IG04
 
G_M000_IG03:
       lea      rdx, bword ptr [rcx+0x0C]
       mov      ecx, dword ptr [rcx+0x08]
       mov      eax, ecx
       jmp      SHORT G_M000_IG05
 
G_M000_IG04:
       xor      rdx, rdx
       xor      eax, eax
 
G_M000_IG05:
       mov      rcx, rdx
       mov      edx, eax
       call     [System.Text.UTF8Encoding+UTF8EncodingSealed:GetByteCount(byref,int):int]
       cmp      eax, 128
       setle    al
       movzx    rax, al
 
G_M000_IG06:
       add      rsp, 40
       ret      
 
; Total bytes of code 55 for method Utf8VariableBenchmarks:FitsSpan():bool:this (FullOpts)


