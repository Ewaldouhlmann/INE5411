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

    # Carregando "e" e somando com o valor de "a"
    lw $t0, e # Carregando e
    add $t2, $t0, $t1      # $t2 = a + e

    # --- Calculando d² ---
    lw   $t0, d            # $t0 = d (valor base)
    move $t1, $t0          # $t1 = contador para multiplicação (d vezes)
    li   $t3, 0            # $t3 = acumulador (onde estará o resultado de d²)

eleva_quadrado:
    # Elevando o valor de d ao quadrado

    # Quando o contador for igual a 0, sair da repetição (quadrado calculado)
    beq  $t1, $zero, quadrado_pronto

    # Adicionando o valor de d ao acumulador
    add  $t3, $t3, $t0

    # Decrementando o contador
    subi $t1, $t1, 1

    # Retorna para o início da repetição
    j    eleva_quadrado

quadrado_pronto:
    # Agora $t3 tem o valor de d² e t0 tem o valor de d
    # Calculando d³, utilizando d² e d (d³ = d² * d)
    li   $t4, 0   # $t4 = acumulador para d³

eleva_cubo:
	# Agora, como temos o valor de d², somamos d vezes d² e 
	# salvamos em um registrador temporario (T5)

    # Verifica se o cubo foi calculado (t0 = 0)
    beq  $t0, $zero, cubo_pronto
    # Adicionando d² na variavel temporaria t4
    add  $t4, $t4, $t3
    #  Substraindo 1 de t1
    subi $t0, $t0, 1
    j    eleva_cubo

cubo_pronto:
    # Cubo de d calculado e salvo em t4, e a soma de a com e em  t2
    # Agora calculamos (c = d³ - (a+e))

    # Subtraindo (a+e) de d³
    sub $t0, $t4, $t2
    # Salvando c na memoria de dados
    sw   $t0, c


    
    # Imprime o resultado
    li $v0, 1
    move $a0, $t0
    syscall

    # Finaliza o programa
    li $v0, 10
    syscall
