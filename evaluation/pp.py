import sys
sys.setrecursionlimit(10000)
write = sys.stdout.write

# all functions take three args:
# the result value (ptr into linear memory), the memory, and the store

def load_i32(addr, memory, store):
    bs = memory.read(store, addr, addr + 4)
    return int.from_bytes(bs[::-1])

def load_i64(addr, memory, store):
    bs = memory.read(store, addr, addr + 8)
    return int.from_bytes(bs[::-1])

# the bool constructors are swapped, see https://github.com/CertiCoq/certicoq/pull/100
def print_bool(value, memory, store):
    assert (value & 1), "expected unboxed constr"
    if value >> 1 == 0:
        write("false")
    elif value >> 1 == 1:
        write("true")

def print_bool_old_dont_use(value, memory, store):
    assert (value & 1), "expected unboxed constr"
    if value >> 1 == 0:
        write("true")
    elif value >> 1 == 1:
        write("false")

def print_nat_sexp(value, memory, store):
    if value & 1:
        if value >> 1 == 0:
            write("O")
    else:
        tag = load_i32(value, memory, store)
        if tag == 0:
            arg = load_i32(value + 4, memory, store)
            write("(S ")
            print_nat_sexp(arg, memory, store)
            write(")")

def print_list_sexp(print_elem):
    def print_list_sexp_aux(value, memory, store):
        if value & 1:
            if value >> 1 == 0:
                write("nil")
        else:
            tag = load_i32(value, memory, store)
            if tag == 0:
                write("(cons ")
                head = load_i32(value + 4, memory, store)
                print_elem(head, memory, store)
                write(" ")
                tail = load_i32(value + 8, memory, store)
                print_list_sexp_aux(tail, memory, store)
                write(")")

    return print_list_sexp_aux

def print_positive_sexp(value, memory, store):
    if value & 1:
        write("xH")
    else:
        tag = load_i32(value, memory, store)
        if tag == 0:
            write("(xI ")
        elif tag == 1:
            write("(xO ")

        arg = load_i32(value + 4, memory, store)
        print_positive_sexp(arg, memory, store)
        write(")")

def print_N_sexp(value, memory, store):
    if value & 1:
        write("N0")
    else:
        write("(Npos ")
        arg = load_i32(value + 4, memory, store)
        print_positive_sexp(arg, memory, store)
        write(")")

def print_Z_sexp(value, memory, store):
    if value & 1:
        write("Z0")
    else:
        tag = load_i32(value, memory, store)
        if tag == 0:
            write("(Zpos ")
        elif tag == 1:
            write("(Zneg ")

        arg = load_i32(value + 4, memory, store)
        print_positive_sexp(arg, memory, store)
        write(")")

def print_prod(print_fst, print_snd):
    def print_prod_aux(value, memory, store):
        write("(")
        fst = load_i32(value + 4, memory, store)
        print_fst(fst, memory, store)
        write(", ")
        snd = load_i32(value + 8, memory, store)
        print_snd(snd, memory, store)
        write(")")

    return print_prod_aux

def print_compcert_byte_sexp(value, memory, store):
    write("(mkint ")
    arg = load_i32(value + 4, memory, store)
    print_Z_sexp(arg, memory, store)
    write(")")

def print_option(print_elem):
    def print_option_aux(value, memory, store):
        if value & 1:
            write("None")
        else:
            write("(Some ")
            arg = load_i32(value + 4, memory, store)
            print_elem(arg, memory, store)
            write(")")

    return print_option_aux


def print_i63(value, memory, store):
    val = load_i64(value, memory, store)
    write(str(val))
