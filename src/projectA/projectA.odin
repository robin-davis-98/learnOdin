package projectA

//DOCS: This is a simple calculator terminal app

import "core:fmt"
import "core:os"
import "core:strconv"

test :: proc() {
    a, b: i32;
    a = get_user_input("Enter the first number: ");
    b = get_user_input("Enter the second number: ")

    c : i32;
    c = a + b;

    fmt.printfln("%d + %d = %d", a, b, c);
}

get_user_input :: proc(message : string) -> i32 {
    //NOTE: because this is a DOD language we have to declare some set size for the buffer.
    input_buffer: [100]byte;

    fmt.print(message);

    /*
    NOTE:
        os.read returns an interger (the length of the input)
        and an error. We can ignore either by using an underscore
        as the variable.
    */
    bytes_read, err := os.read(os.stdin, input_buffer[:]);

    if err != nil {
        fmt.eprintln("Unable to open stdin: ", err);
        os.exit(-1);
    }

    s := string(input_buffer[:bytes_read-1]);
    number, ok := strconv.parse_int(s);
    if (!ok) {
        fmt.eprintfln("Not a valid number: %s", s)
        os.exit(-1);
    }

    return cast(i32)number;
}