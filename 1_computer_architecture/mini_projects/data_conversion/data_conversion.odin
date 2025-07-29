package main

import "core:fmt"
import "core:os"
import "core:strconv"


main :: proc() {
    if len(os.args) != 2{
        fmt.println("Usage: odin run data_conversion -- <number>")
        return
    }
    number, ok := strconv.parse_int(os.args[1], 10)
    if !ok {
        fmt.println("Invalid number")
        return
    }
    
    binary := convert_decimal_to_binary(number)
    hex := convert_decimal_to_hex(number)
    fmt.println("Binary:", binary)
    fmt.println("Hex:", hex)
}

convert_decimal_to_binary :: proc(number: int) -> string {
    working_number := number
    result := make([dynamic]int, 0, 32)
    for working_number > 0 {
        bit := working_number & 1
        append(&result, bit)
        working_number >>= 1
    }

    // Build the string
    binary_string := ""
    for i := len(result) - 1; i >= 0; i -= 1 {
        binary_string = fmt.tprintf("%s%d", binary_string, result[i])
    }
    
    return binary_string
}

convert_decimal_to_hex :: proc(number: int) -> string {
    working_number := number
    result := make([dynamic]int)

    for working_number > 0 {
        digit := working_number & 15
        append(&result, digit)
        working_number >>= 4
    }

    // Build the string
    hex_string := ""
    for i := len(result) - 1; i >= 0; i -= 1 {
        if result[i] < 10 {
            hex_string = fmt.tprintf("%s%d", hex_string, result[i])
        } else {
            if result[i] == 10 {
                hex_string = fmt.tprintf("%sA", hex_string)
            } else if result[i] == 11 {
                hex_string = fmt.tprintf("%sB", hex_string)
            } else if result[i] == 12 {
                hex_string = fmt.tprintf("%sC", hex_string)
            } else if result[i] == 13 {
                hex_string = fmt.tprintf("%sD", hex_string)
            } else if result[i] == 14 {
                hex_string = fmt.tprintf("%sE", hex_string)
            } else if result[i] == 15 {
                hex_string = fmt.tprintf("%sF", hex_string)
            }
        }
    }

    return hex_string
}