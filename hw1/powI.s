	.file	"powI.c"
	.text
	.globl	powI
	.type	powI, @function
powI:
.LFB0:
	.cfi_startproc
	pushq	%rbp  //1. stack frame
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp  //1.  stack frame 
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)  //2.  argument storage
	movl	%esi, -24(%rbp)	 //2. argument storage
	movl	$1, -4(%rbp)  //3.  acc & p are assigned 1,0 respectively
	movl	$0, -8(%rbp)  
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax  //4.  code executed inside loop
	imull	-24(%rbp), %eax
	movl	%eax, -4(%rbp)
	addl	$1, -8(%rbp)  //4.  p is incremented (p++)
.L2:
	movl	-8(%rbp), %eax  //4.
	cmpl	-20(%rbp), %eax //4.  comparison for loop re-execution
	jl	.L3
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	powI, .-powI
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
