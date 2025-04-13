.data
    a: .word 0      
    b: .word 80
    c: .word 0
    d: .word 4
    e: .word 2
    t: .word 2
    res: .word 0
.text
    # Calcular a = b + 35
    lw   $t0, b            # Carregando b
    addi $t1, $t0, 35      # a = b + 35

    # Carregando e e somando com o valor de a
    lw $t0, e              
    add $t2, $t0, $t1      # $t2 = a + e

    # --- PRIMEIRO: calcular d² ---
    lw   $t0, d            # $t0 = d (valor base)
    move $t1, $t0          # $t1 = contador para multiplicação (d vezes)
    li   $t3, 0            # $t3 = acumulador (resultado de d²)

eleva_quadrado:
    beq  $t1, $zero, quadrado_pronto
    add  $t3, $t3, $t0     # acumulando d + d + d + ...
    subi $t1, $t1, 1
    j    eleva_quadrado

quadrado_pronto:
    # Agora $t3 tem d²
    # Calculando d³ ou (d² * d)
    li   $t4, 0   # $t4 = acumulador para d³

eleva_cubo:
	# Agora, como temos o valor de d², somamos d vezes d² e 
	# salvamos em um registrador temporario (T5)
    	beq  $t0, $zero, cubo_pronto
    	add  $t4, $t4, $t3     # somando d² vezes
    	subi $t0, $t0, 1 # Substituindo 1 de t1
    	j    eleva_cubo

cubo_pronto:
    # Cubo pronto esta em t4 e (a+e) em t2, fazer subtracao de t4 - t2
    sub $t0, $t4, $t2
    
    # Imprime o resultado
    li $v0, 1
    move $a0, $t0
    syscall

    # Finaliza o programa
    li $v0, 10
    syscall
