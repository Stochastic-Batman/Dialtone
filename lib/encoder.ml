let aux ~sample_rate ~block_size c =
    let l, h = Dtmf.find c in
    let f_l = Dtmf.low_freqs.(l) in
    let f_h = Dtmf.high_freqs.(h) in
    Array.init block_size (fun n ->
        let t = 2. *. Float.pi *. (float n) /. sample_rate in
        0.5 *. (sin (f_l *. t) +. sin (f_h *. t) ) )

let encode ~sample_rate ~block_size s =
    let silence = Array.make block_size 0. in
    let blocks =
        List.init (String.length s) (fun i ->
            [ aux ~sample_rate ~block_size s.[i]; silence ])
        |> List.concat
    in
    Array.concat blocks
