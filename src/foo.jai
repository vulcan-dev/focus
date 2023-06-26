foo : int;

Foo : struct {
    foo : string;
}

baz : Foo;

bar :: () {
    print("%\n", foo);

    foo := "hi";
    baz = .{foo=foo};

    print("%\n", foo);
}
