; Hanoi Tower Solver
; br ShahroOz

; HELP:
;    just run the app and enter the n

data segment
    n dw 3
    arr db 'A$B$C$'
    temp dw ? 
    numstr db '$$$$$'
    lbk    db 13,10,'$'
    donoghte db ': $'
    felesh db ' -> $'
data ends

stack segment
    mystack db 100 dup(?)
stack ends

myprog segment
    main proc far
        assume cs: myprog, ds: data, ss: stack
        mov ax, data
        mov ds, ax
        lea sp, mystack+100
        
        call input
        
        xor cx, cx
        lea bx, arr
        xor si, si 
        
        ;mov ax, n
        call hanoi
        
        lea si, numstr
        mov ax, cx
        call s2n
        
        hlt
        
    main endp
    
    hanoi proc near 
        
        inc cx
        cmp ax, 1
        jne outa
        ;cout<<ax<<':'<<[bx]<<'-'<<'>'<<[bx+2]
        call print
        
        ret
  outa: push ax
        mov dl, [bx+2]
        mov dh, [bx+4]
        mov [bx+4], dl
        mov [bx+2], dh
        dec ax
        call hanoi
        pop ax
        ;cout<<ax<<':'<<[bx]<<'-'<<'>'<<[bx+2]
        
        mov dl, [bx+2]
        mov dh, [bx+4]
        mov [bx+4], dl
        mov [bx+2], dh
        call print
        push ax
        dec ax
        mov dl, [bx+2]
        mov dh, [bx]
        mov [bx], dl
        mov [bx+2], dh
        call hanoi
        pop ax
        mov dl, [bx+2]
        mov dh, [bx]
        mov [bx], dl
        mov [bx+2], dh
        ret
    hanoi endp  
    
    print proc near
        
        
        push ax
        push bx
        push cx
        push dx
        push di
        push si
        
        lea si, numstr
        mov ax,ax
        call s2n
        
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax 
        
        push ax
        push dx        
        mov ah, 9
        lea dx, donoghte
        int 21h
        pop dx
        pop ax
        
        push ax
        push dx        
        mov ah, 9
        mov dx, bx
        int 21h
        pop dx
        pop ax  
        
        push ax
        push dx        
        mov ah, 9
        lea dx, felesh
        int 21h
        pop dx
        pop ax
        
        
        push ax
        push dx        
        mov ah, 9 
        add bx, 4
        mov dx, bx
        sub bx, 4
        int 21h
        pop dx
        pop ax
        
        
        push ax
        push dx
        mov dx,13
        mov ah,2
        int 21h  
        mov dx,10
        mov ah,2
        int 21h
        int 21h
        pop dx
        pop ax
        
        
        ret
         
         
    print endp

    s2n proc near
        call dollars 
        mov  bx, 10 
        mov  cx, 0  
  loop1:       
        mov  dx, 0   
        div  bx      
        push dx      
        inc  cx      
        cmp  ax, 0   
        jne  loop1   

 loop2: pop  dx        
        add  dl, 48  
        mov  [ si ], dl
        inc  si
        loop loop2
  
        mov ah, 9
        mov dx, offset numstr
        int 21h   

        ret
    s2n endp    
    
dollars proc near                 
        mov cx, 5
        mov di, offset numstr
loopd:  mov bl, '$'
        mov [ di ], bl
        inc di
        loop loopd

        ret
dollars endp

input proc near
    
        push bx
        push cx
        push dx
        push di
        push si
        
    
loopme:
    
    
    mov ah, 1
    int 21h                    

    cmp al,'0'                 
    jb noascii                 
    cmp al,'9'                 
    ja noascii                 

    sub al,30h                 
    cbw                        
                            
    push ax
    mov ax,bx                
    mov cx,10
    mul cx                    
    mov bx,ax
    pop ax
    add bx,ax
    jmp loopme                 
    
    
    
    noascii:
    
        mov ax, bx
        pop si
        pop di
        pop dx
        pop cx
        pop bx
    ret                    
    
input endp

myprog ends

        end main