; -----------------------------------------------------------
; PROJECT: SORT 25 STUDENTS BY GRADES (DESCENDING)
; SUBJECT: COMPUTER ORGANISATION AND ARCHITECTURE
; -----------------------------------------------------------

data segment
    ; 25 STUDENT NUMBERS
    students db  1,2,3,4,5,6,7,8,9,10
             db  11,12,13,14,15,16,17,18,19,20
             db  21,22,23,24,25

    ; 25 GRADES (out of 100)
    grades   db  88,92,75,69,85,91,73,95,60,84
             db  77,66,82,94,58,90,87,72,80,89
             db  65,70,83,93,78
    
    sorted   db 0      ; flag: 0=not sorted, 1=sorted
    
    ; Menu
    menu1    db 0Dh,0Ah,'=====================================$'
    menu2    db 0Dh,0Ah,'   STUDENT GRADE MANAGEMENT SYSTEM   $'
    menu3    db 0Dh,0Ah,'=====================================$'
    menu4    db 0Dh,0Ah,'  1. Sort Students by Grade$'
    menu5    db 0Dh,0Ah,'  2. Display Sorted Table$'
    menu6    db 0Dh,0Ah,'  3. Search by Roll Number$'
    menu7    db 0Dh,0Ah,'  4. Exit$'
    menu8    db 0Dh,0Ah,'=====================================$'
    menu9    db 0Dh,0Ah,'Enter choice (1-4): $'
    
    ; Messages
    sorting_msg  db 0Dh,0Ah,'Sorting students... Please wait...$'
    sorted_done  db 0Dh,0Ah,'Sorting completed successfully!$'
    not_sorted_msg db 0Dh,0Ah,'Error: Please sort the data first (Option 1)!$'
    invalid_msg  db 0Dh,0Ah,'Invalid choice! Please enter 1-4.$'
    
    ; Table formatting
    header1  db 0Dh,0Ah,0Dh,0Ah,'=====================================$'
    header2  db 0Dh,0Ah,'  SORTED STUDENT GRADES TABLE       $'
    header3  db 0Dh,0Ah,'=====================================$'
    header4  db 0Dh,0Ah,' Rank | Student | Grade | Category $'
    header5  db 0Dh,0Ah,'-------------------------------------$'
    footer   db 0Dh,0Ah,'=====================================$'
    
    ; Search prompts
    search_hdr   db 0Dh,0Ah,0Dh,0Ah,'=====================================$'
    search_title db 0Dh,0Ah,'      SEARCH STUDENT BY ROLL NO      $'
    search_line  db 0Dh,0Ah,'=====================================$'
    prompt_msg   db 0Dh,0Ah,'Enter student number (1-25): $'
    result_msg   db 0Dh,0Ah,0Dh,0Ah,'Student #$'
    grade_msg    db ' has Grade: $'
    category_msg db ' [Category: $'
    not_found    db 0Dh,0Ah,'Student not found!$'
    
    press_key    db 0Dh,0Ah,0Dh,0Ah,'Press any key to continue...$'
    exit_msg     db 0Dh,0Ah,'Thank you for using the system!$'
    
    rank_num db 1
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    ; Set segment registers
    mov ax, data
    mov ds, ax
    mov es, ax

; -----------------------------------------------------------
; MAIN MENU LOOP
; -----------------------------------------------------------
main_menu:
    ; Display menu
    lea dx, menu1
    mov ah, 09h
    int 21h
    
    lea dx, menu2
    mov ah, 09h
    int 21h
    
    lea dx, menu3
    mov ah, 09h
    int 21h
    
    lea dx, menu4
    mov ah, 09h
    int 21h
    
    lea dx, menu5
    mov ah, 09h
    int 21h
    
    lea dx, menu6
    mov ah, 09h
    int 21h
    
    lea dx, menu7
    mov ah, 09h
    int 21h
    
    lea dx, menu8
    mov ah, 09h
    int 21h
    
    lea dx, menu9
    mov ah, 09h
    int 21h
    
    ; Get user choice
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je option_sort
    cmp al, '2'
    je option_display
    cmp al, '3'
    je option_search
    cmp al, '4'
    je option_exit
    
    ; Invalid choice
    lea dx, invalid_msg
    mov ah, 09h
    int 21h
    
    call wait_key
    jmp main_menu

; -----------------------------------------------------------
; OPTION 1: SORT STUDENTS
; -----------------------------------------------------------
option_sort:
    lea dx, sorting_msg
    mov ah, 09h
    int 21h
    
    ; Bubble sort
    mov cx, 24

outer_loop:
    push cx
    mov bx, 0
    mov si, cx

inner_loop:
    mov al, grades[bx]
    mov dl, grades[bx+1]

    cmp al, dl         
    jae no_swap

    ; SWAP GRADES
    mov grades[bx], dl
    mov grades[bx+1], al

    ; SWAP STUDENT NUMBERS
    mov al, students[bx]
    mov dl, students[bx+1]
    mov students[bx], dl
    mov students[bx+1], al

no_swap:
    inc bx
    dec si
    jnz inner_loop

    pop cx
    loop outer_loop
    
    ; Mark as sorted
    mov sorted, 1
    
    lea dx, sorted_done
    mov ah, 09h
    int 21h
    
    call wait_key
    jmp main_menu

; -----------------------------------------------------------
; OPTION 2: DISPLAY TABLE
; -----------------------------------------------------------
option_display:
    ; Check if sorted
    cmp sorted, 0
    je not_sorted_error
    
    ; Print headers
    lea dx, header1
    mov ah, 09h
    int 21h
    
    lea dx, header2
    mov ah, 09h
    int 21h
    
    lea dx, header3
    mov ah, 09h
    int 21h
    
    lea dx, header4
    mov ah, 09h
    int 21h
    
    lea dx, header5
    mov ah, 09h
    int 21h

    ; Print rows
    mov cx, 25
    xor si, si
    mov byte ptr rank_num, 1

print_rows:
    ; New line
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h
    
    ; Rank
    mov dl, ' '
    mov ah, 02h
    int 21h
    
    mov al, rank_num
    call print_num_fixed
    inc rank_num
    
    ; Separator
    mov dl, ' '
    mov ah, 02h
    int 21h
    int 21h
    mov dl, '|'
    int 21h
    mov dl, ' '
    int 21h
    int 21h
    
    ; Student number
    mov al, students[si]
    call print_num_fixed
    
    ; Separator
    mov dl, ' '
    mov ah, 02h
    int 21h
    int 21h
    int 21h
    mov dl, '|'
    int 21h
    mov dl, ' '
    int 21h
    int 21h
    
    ; Grade
    mov al, grades[si]
    push si
    call print_num_fixed
    
    ; Separator
    mov dl, ' '
    mov ah, 02h
    int 21h
    int 21h
    mov dl, '|'
    int 21h
    mov dl, ' '
    int 21h
    int 21h
    
    ; Category
    pop si
    mov al, grades[si]
    call print_category
    
    inc si
    loop print_rows

    ; Footer
    lea dx, footer
    mov ah, 09h
    int 21h
    
    call wait_key
    jmp main_menu

not_sorted_error:
    lea dx, not_sorted_msg
    mov ah, 09h
    int 21h
    call wait_key
    jmp main_menu

; -----------------------------------------------------------
; OPTION 3: SEARCH STUDENT
; -----------------------------------------------------------
option_search:
    ; Check if sorted
    cmp sorted, 0
    je not_sorted_error
    
    lea dx, search_hdr
    mov ah, 09h
    int 21h
    
    lea dx, search_title
    mov ah, 09h
    int 21h
    
    lea dx, search_line
    mov ah, 09h
    int 21h
    
    lea dx, prompt_msg
    mov ah, 09h
    int 21h
    
    ; Get input
    call get_number
    mov bl, al
    
    ; Search
    mov cx, 25
    xor si, si
    
search_loop:
    mov al, students[si]
    cmp al, bl
    je found_student
    inc si
    loop search_loop
    
    ; Not found
    lea dx, not_found
    mov ah, 09h
    int 21h
    jmp search_done
    
found_student:
    ; Display result
    lea dx, result_msg
    mov ah, 09h
    int 21h
    
    mov al, bl
    call print_num_fixed
    
    lea dx, grade_msg
    mov ah, 09h
    int 21h
    
    mov al, grades[si]
    call print_num_fixed
    
    lea dx, category_msg
    mov ah, 09h
    int 21h
    
    mov al, grades[si]
    call print_category
    
    mov dl, ']'
    mov ah, 02h
    int 21h
    
search_done:
    call wait_key
    jmp main_menu

; -----------------------------------------------------------
; OPTION 4: EXIT
; -----------------------------------------------------------
option_exit:
    lea dx, exit_msg
    mov ah, 09h
    int 21h
    
    mov ax, 4c00h
    int 21h

; -----------------------------------------------------------
; WAIT FOR KEY PRESS
; -----------------------------------------------------------
wait_key:
    lea dx, press_key
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    ret

; -----------------------------------------------------------
; GET NUMBER INPUT
; -----------------------------------------------------------
get_number:
    push bx
    push cx
    push dx
    
    mov ah, 01h
    int 21h
    
    cmp al, 0Dh
    je input_done
    
    sub al, '0'
    mov bl, al
    
    mov ah, 01h
    int 21h
    
    cmp al, 0Dh
    je single_digit
    
    sub al, '0'
    mov bh, al
    mov al, bl
    mov cl, 10
    mul cl
    add al, bh
    jmp input_done
    
single_digit:
    mov al, bl
    
input_done:
    pop dx
    pop cx
    pop bx
    ret

; -----------------------------------------------------------
; PRINT CATEGORY
; -----------------------------------------------------------
print_category:
    push ax
    push dx
    
    cmp al, 90
    jae grade_A
    cmp al, 80
    jae grade_B
    cmp al, 70
    jae grade_C
    cmp al, 60
    jae grade_D
    jmp grade_F
    
grade_A:
    mov dl, 'A'
    jmp print_cat
grade_B:
    mov dl, 'B'
    jmp print_cat
grade_C:
    mov dl, 'C'
    jmp print_cat
grade_D:
    mov dl, 'D'
    jmp print_cat
grade_F:
    mov dl, 'F'
    
print_cat:
    mov ah, 02h
    int 21h
    
    pop dx
    pop ax
    ret

; -----------------------------------------------------------
; PRINT NUMBER FIXED WIDTH
; -----------------------------------------------------------
print_num_fixed:
    push ax
    push dx
    push bx
    
    xor ah, ah
    mov bl, 100
    div bl
    
    push ax
    
    cmp al, 0
    je print_space_h
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    jmp after_h
    
print_space_h:
    mov dl, ' '
    mov ah, 02h
    int 21h
    
after_h:
    pop ax
    mov al, ah
    xor ah, ah
    mov bl, 10
    div bl
    
    push ax
    
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    
    pop ax
    mov dl, ah
    add dl, '0'
    mov ah, 02h
    int 21h
    
    pop bx
    pop dx
    pop ax
    ret

ends
end start