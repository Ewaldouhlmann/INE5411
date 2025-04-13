.data
    a: .word 0      
    b: .word 0
    c: .word 0
    d: .word 0       
    e: .word 0 
    res: .word 0
    msg_b: .asciiz "Digite o valor de b: "
    msg_d: .asciiz "Digite o valor de d: "
    msg_e: .asciiz "Digite o valor de e: "
    msg_c: .asciiz "O valor de c é: "
.text
        # ---- Entrada dos dados ----
        li $v0, 4 # código para imprimir uma string
        la $a0, msg_b # endereço da string a ser impressa
        syscall # Chamada do sistema para imprimir a mensagem na tela

        li $v0, 5 # código para ler um inteiro
        syscall # Chamada do sistema para ler o valor do usuário
        sw $v0, b # salva o valor lido no endereço b

        li $v0, 4 # código para imprimir uma string
        la $a0, msg_d # endereço da string a ser impressa
        syscall # Chamada do sistema para imprimir a mensagem na tela

        li $v0, 5 # código para ler um valor inteiro
        syscall # Chamada do sistema para ler o valor do usuário
        sw $v0, d # salva o valor lido no endereço d

        li $v0, 4 # código para imprimir uma string 
        la $a0, msg_e # endereço da string a ser impressa
        syscall # Chamada do sistema para imprimir a mensagem na tela

        li $v0, 5 # código para ler um inteiro
        syscall # Chamada do sistema para ler o valor informado pelo usuário
        sw $v0, e # salva o valor lido no endereço e

        # ---- Cálculos ----

        # Calcular a = b + 35
        lw   $t0, b # carrega b
        addi $t1, $t0, 35 # calcula a
        sw   $t1, a # guarda a

        # Carregando "e" e somando com o valor de "a"
        lw $t0, e
        add $t2, $t0, $t1      # t2 = a + e

        # --- Calculando d² ---
        lw   $t0, d            # $t0 = d
        move $t1, $t0          # contador = d
        li   $t3, 0            # acumulador = 0

eleva_quadrado:
        beq  $t1, $zero, quadrado_pronto # se contador = 0, sair do loop
        add  $t3, $t3, $t0 # acumulador = acumulador + d
        subi $t1, $t1, 1 # contador = contador - 1
        j    eleva_quadrado # pula para o início do loop

quadrado_pronto:
        li   $t4, 0            # t4 = acumulador para d³

        # Usamos t5 para manter o valor original de d
        lw $t5, d

eleva_cubo:
        beq  $t5, $zero, cubo_pronto # se contador = 0, sair do loop
        add  $t4, $t4, $t3 # acumulador = acumulador + d²
        subi $t5, $t5, 1 # contador = contador - 1
        j    eleva_cubo # pula para o início do loop

cubo_pronto:
        sub $t0, $t4, $t2      # t0 = d³ - (a+e)
        sw  $t0, c             # salva c na memória

        # ---- Imprimir resultado ----
        li $v0, 4 # código para imprimir uma string
        la $a0, msg_c # endereço da string a ser impressa
        syscall # Chamada do sistema para imprimir a mensagem na tela

        li $v0, 1 # código para imprimir um inteiro
        lw $a0, c # carrega o valor de c
        syscall # Chamada do sistema para imprimir o valor de c

        # Finaliza o programa 
        li $v0, 10 # código para finalizar o programa
        syscall # Chamada do sistema para finalizar o programa
