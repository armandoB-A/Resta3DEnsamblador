.model Small ; INDICA TAMA?O DE MEMORIA A USAR

.stack ; Tipo de pila

.data ; Inicio del segmento de datos
    
    mensaje db   "  INTRODUCE EL NUMERO: " , "$"
    
    men1 db  10, 13, 7, "   " , "$"
    men2 db  "  hola master" , "$"
    txt db  "  -" , "$"
    men3 db  "  Resultado: " , "$"
    
    numeroU db ?
    numeroD db ?
    
    result  db 0
    resultD db 0
    resultUni db 0
    resultDece db 0
    
    cenU     db 0
    deceU     db 0
    uniU     db 0
    
    cenD     db 0
    deceD     db 0
    uniD     db 0
    
    cenT     db 0
    deceT     db 0
    uniT     db 0
    
    aux     db 0
     cen     db 0
    dece     db 0
    uni     db 0
    
    uno     db 1
    diez        db 10
.code ; Inicio segmento de c?digo
         
    main proc ; Inicio del proceso
        mov ax, SEG @data 
        mov ds,ax 
        
        PedirLeerNum1:
            mov ah,09
            lea dx,mensaje 
            int 21h 
            
            mov ah,01
            int 21h
            sub al, 30h
            mov cenU,al
            
            mov ah,01
            int 21h
            sub al, 30h
            mul diez
            mov numeroU,al
            
            mov ah,01
            int 21h
            sub al, 30h
            add numeroU,al
            
        
        PedirLeerNum2:
            mov ah,09
            lea dx,mensaje 
            int 21h 
            
            mov ah,01
            int 21h
            sub al, 30h
            mov cenD,al
            
            mov ah,01
            int 21h
            sub al, 30h
            mul diez
            mov numeroD,al
            
            mov ah,01
            int 21h
            sub al, 30h
            add numeroD,al
        
        mov ah,09
        lea dx,men1
        int 21h
        
            
        Res:
            mov ah,09
            lea dx,men3
            int 21h
            ;
            mov al, numeroU
            aam 

            mov uniU,al 
            mov al,ah 
            mov deceU,ah  
            
            ;;;;;;;;;;;;;;;;;;
            mov al, numeroD
            aam ;ajusta el valor en AL por: AH=23 Y AL=4

            mov uniD,al ; Respaldo 4 en unidades
            mov al,ah ;muevo lo que tengo en AH a AL para poder volver a separar los n?meros
            mov deceD,ah ;respaldo las decenas en dec, en este caso 
            ;;;;;;;;;;;;;;;;;;
            mov al, cenU
            cmp al, cenD

            ;en caso de que sea mayor jge mayor o igual
            jne continuar
            je restanormal
            
            restanormal:
                jmp RestaNormal1
                ret
            
            continuar:
                ;;;;;;;;;;;;;;;;;;
                mov al, deceU
                cmp al, deceD

                ;en caso de que sea mayor jge mayor o igual
                
                jg llamadaADece1mayor ;en caso de que sea mayor va a la etiqueta
                llamadaADece1mayor:
                    jmp Dece1mayor
                    jmp fin
                    
                jl llamadaADece1menor ;va a la etiqueta menor, si es menor el num 18
                llamadaADece1menor:
                    jmp Dece1menor
                    jmp fin
                 je DeceIgual
                DeceIgual:
                    mov al, cenU
                    cmp al, cenD
                    
                    jg CentenaMayor_ ;en caso de que sea mayor va a la etiqueta
                    jl CentenaMenor_
                
                        
                    CentenaMayor_:
                        mov al, uniU
                        cmp al, uniD

                        ;en caso de que sea mayor jge mayor o igual
                        jg UniMayorU_ ;en caso de que sea mayor va a la etiqueta
                        jl UniMenorU_ ;va a la etiqueta menor, si es menor el num 18
                        
                        UniMayorU_:
                        
                            mov al,numeroU
                            sub al,numeroD
                            aam 
                            mov resultUni,al  
                            mov resultDece,ah
                            jmp ImprimirResultadosFinales
                            UniMenorU_:
                            mov al,numeroU
                            sub al,numeroD
                            aam 
                            mov resultUni,al  
                            mov resultDece,ah
                            jmp ImprimirResultadosFinales
                            jmp fin
                     CentenaMenor_:
                        mov ah,09
                        lea dx,txt
                        int 21h
                        
                        mov al, uniU
                        cmp al, uniD

                        ;en caso de que sea mayor jge mayor o igual
                        jge UniMayorD_ ;en caso de que sea mayor va a la etiqueta
                        jl UniMenorD_ ;va a la etiqueta menor, si es menor el num 18
                        
                        UniMayorD_:
                            mov al,cenD
                            sub al,cenU
                            sub al, uno
                            mov resultD,al
                           ;Resta de las uni
                            mov al, uniD
                            add al, diez
                            sub al, uniU 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceD
                            add al, diez
                            sub al, uno
                            sub al, deceU 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales

                        UniMenorD_:
                            
                            mov al,cenD
                            sub al,cenU
                            mov resultD,al
                            ;Resta de las uni
                            mov al, uniD
                            sub al, uniU 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceD
                            sub al, deceU 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales
                        jmp fin
                    jmp fin
                Dece1mayor:
                    mov al, cenU
                    cmp al, cenD
                    
                    jg CentenaMayor ;en caso de que sea mayor va a la etiqueta
                    jl CentenaMenor
                    
                        
                    CentenaMayor:
                        mov al, uniU
                        cmp al, uniD

                        ;en caso de que sea mayor jge mayor o igual
                        jge UniMayor_D ;en caso de que sea mayor va a la etiqueta
                        jl UniMenor_D ;va a la etiqueta menor, si es menor el num 18
                        
                        UniMayor_D:
                        mov al,cenU
                        sub al,cenD
                            mov resultD,al
                           ;Resta de las uni
                           mov al, uniU
                           sub al, uniD 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceU
                            sub al, deceD 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales

                            UniMenor_D:
                            mov al,cenU
                            sub al,cenD
                            mov resultD,al
                            ;Resta de las uni
                            mov al, uniU
                            add al, diez
                            sub al, uniD 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceU
                            sub al, uno
                            sub al, deceD 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales
                        jmp fin
                        jmp ImprimirResultadosFinales
                    CentenaMenor:
                        mov ah,09
                        lea dx,txt
                        int 21h
                        
                        mov al, uniU
                        cmp al, uniD

                        ;en caso de que sea mayor jge mayor o igual
                        jge UniMayorD ;en caso de que sea mayor va a la etiqueta
                        jl UniMenorD ;va a la etiqueta menor, si es menor el num 18
                        
                        UniMayorD:
                            mov al,cenD
                            sub al,cenU
                            sub al, uno
                            mov resultD,al
                           ;Resta de las uni
                            mov al, uniD
                            add al, diez
                            sub al, uniU 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceD
                            add al, diez
                            sub al, uno
                            sub al, deceU 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales

                        UniMenorD:
                            mov ah,09
                            lea dx,men2
                            int 21h
                            mov al,cenD
                            sub al,cenU
                            mov resultD,al
                            ;Resta de las uni
                            mov al, uniD
                            add al, diez
                            sub al, uniU 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceD
                            add al, diez
                            sub al, uno
                            sub al, deceU 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales
                        jmp fin
                    jmp fin

                Dece1menor:
                    mov ah,09
                    lea dx,men2
                    int 21h
                    mov al, cenU
                    cmp al, cenD
                    
                    jge CentenaMayor__ ;en caso de que sea mayor va a la etiqueta
                    jl CentenaMenor__
                
                        
                    CentenaMayor__:
                    
                        mov al, uniU
                        cmp al, uniD

                        ;en caso de que sea mayor jge mayor o igual
                        jge UniMayor_D_ ;en caso de que sea mayor va a la etiqueta
                        jl UniMenor_D_ ;va a la etiqueta menor, si es menor el num 18
                        
                        UniMayor_D_:
                            mov al,cenU
                            sub al,cenD
                            mov resultD,al
                            ;Resta de las uni
                            mov al, uniU
                            sub al, uniD 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceU
                            sub al, deceD 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales

                        UniMenor_D_:
                            mov ah,09
                            lea dx,men2
                            int 21h
                            mov al,cenU
                            sub al,cenD
                            mov resultD,al
                            ;Resta de las uni
                            mov al, uniU
                            add al, diez
                            sub al, uniD 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceU
                            sub al, uno
                            sub al, deceD 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales
                        jmp fin
                        
                    CentenaMenor__:
                        mov ah,09
                        lea dx,txt
                        int 21h
                        
                        mov al, uniU
                        cmp al, uniD

                        ;en caso de que sea mayor jge mayor o igual
                        jge UniMayorD__ ;en caso de que sea mayor va a la etiqueta
                        jl UniMenorD__ ;va a la etiqueta menor, si es menor el num 18
                        
                        UniMayorD__:
                            mov al,cenD
                            sub al,cenU
                            sub al, uno
                            mov resultD,al
                           ;Resta de las uni
                            mov al, uniD
                            add al, diez
                            sub al, uniU 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceD
                            add al, diez
                            sub al, uno
                            sub al, deceU 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales

                            UniMenorD__:
                            mov ah,09
                            lea dx,men2
                            int 21h
                            mov al,cenD
                            sub al,cenU
                            mov resultD,al
                            ;Resta de las uni
                            mov al, uniD
                            add al, diez
                            sub al, uniU 
                            aam
                            mov resultUni, al 
                            ;Resta de las dece
                            mov al, deceD
                            add al, diez
                            sub al, uno
                            sub al, deceU 
                            aam
                            mov resultDece, al 
                            jmp ImprimirResultadosFinales
                        jmp fin

                jmp fin
            
            RestaNormal1:
            
                ;Resta de las uni
                mov al, numeroU
                cmp al, numeroD ; compara si en el registro al es 18    
                ;en caso de que sea mayor jge mayor o igual
                jg Num1mayor ;en caso de que sea mayor va a la etiqueta
                jl Num1menor ;va a la etiqueta menor, si es menor el num 18
                
                Num1mayor:
                    neg numeroU
                    mov al,numeroU
                    neg numeroD
                    sub al,numeroD
                    mov result,al
                Num1menor:
                    mov ah,09
                    lea dx,txt
                    int 21h
                    neg numeroU
                    mov al,numeroU
                    neg numeroD
                    sub al,numeroD
                    mov result,al
                    
                mov al,result
                aam 
                mov resultUni,al 
                mov resultDece,ah 
                mov al, cenD
                sub al, cenU 
                aam
                mov resultD, al
                jmp ImprimirResultadosFinales

        ImprimirResultadosFinales:
            ;Imprimos los tres valores empezando por centenas, decenas y unidades.
            mov ah,02h
            mov dl,resultD
            add dl,30h 
            int 21h

            mov dl,resultDece
            add dl,30h
            int 21h

            mov dl,resultUni
            add dl,30h
            int 21h
            
            jmp fin
        fin:
            mov ax, 4c00h
            int 21h 
     
    main endp ; Fin de proceso
     
end main;  Salir del metodo principa