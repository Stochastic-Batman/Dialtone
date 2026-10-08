let sample_rate = 8000.
let block_size = 205
let on_bin = 20. *. sample_rate /. float block_size

let tone freq phase =
    Array.init block_size (fun n ->
        sin (2. *. Float.pi *. freq *. float n /. sample_rate +. phase))

let power freq block =
    Dialtone.Goertzel.power
        (Dialtone.Goertzel.create ~sample_rate ~block_size ~freq) block

let () =
    let signal = tone 770. 0. in
    let p770 = power 770. signal in
    let p1000 = power 1000. signal in
    assert (p770 > 10. *. p1000);
    print_endline "goertzel: detects target frequency over others"

let () =
    let p0 = power on_bin (tone on_bin 0.) in
    let p1 = power on_bin (tone on_bin 1.3) in
    assert (abs_float (p0 -. p1) < 0.01 *. p0);
    print_endline "goertzel: power is independent of phase"

let () =
    assert (Dialtone.Dtmf.low_freqs = [| 697.; 770.; 852.; 941. |]);
    assert (Dialtone.Dtmf.high_freqs = [| 1209.; 1336.; 1477.; 1633. |]);
    print_endline "dtmf: frequency tables are correct"

let () =
    assert (Dialtone.Dtmf.key ~low:0 ~high:0 = '1');
    assert (Dialtone.Dtmf.key ~low:0 ~high:3 = 'A');
    assert (Dialtone.Dtmf.key ~low:3 ~high:0 = '*');
    assert (Dialtone.Dtmf.key ~low:3 ~high:3 = 'D');
    assert (Dialtone.Dtmf.key ~low:1 ~high:1 = '5');
    print_endline "dtmf: corners and center are correct"

let () =
    let keys =
        String.concat ""
            (List.init 4 (fun low ->
                 String.init 4 (fun high -> Dialtone.Dtmf.key ~low ~high)))
    in
    assert (keys = "123A456B789C*0#D");
    print_endline "dtmf: full keypad matches"
