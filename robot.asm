; Codigo pra controlar o robo do emu8086
; 
; By leonardosnt
; At 2016-11-28

name "robot control"

org 100h

jmp main

main:       
   ; espera o usuario apertar uma tecla
   mov ah, 0
   int 16h
             
   ; esc - termina        
   cmp al, 27
   je stop
   
   ; a - move o robo para esquerda
   cmp al, 97       
   je move_left  
   
   ; w - move o robo para frente
   cmp al, 119      
   je move_forward

   ; d - move o robo para direita
   cmp al, 100      
   je move_right
           
   ; caso nao caia em nenhuma das opcoes anteriores
   ; o fluxo vai voltar pro inicio
   jmp main

; Os dados de entrada do robo podem ser encontrados na pagina
; 'I/O ports and Hardware Interrupts' da documentacao do emu8086
move_forward:
  mov ax, 1
  jmp send_to_device

move_left:
  mov ax, 2
  jmp send_to_device

move_right:
  mov ax, 3
  jmp send_to_device


send_to_device:
  ; Envia o conteudo do registrador AX para o robo
  out 9, ax
  
  ; Espera um pouco antes de resetar
  ; o byte de informacao do movimento do robo
  mov cx, 100
  nothing: 
  loop nothing   
  
  ; Reseta o byte de informacao do movimento do robo
  mov ax, 0
  out 9, ax 

  ; volta pro loop
  jmp main

stop:
    ret
