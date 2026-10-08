type t = { block_size : int; low : Goertzel.t array; high : Goertzel.t array }

let threshold = 1.0

let create ~sample_rate ~block_size =
    let detectors freqs =
        Array.map (fun freq -> Goertzel.create ~sample_rate ~block_size ~freq) freqs
    in
    { block_size; low = detectors Dtmf.low_freqs; high = detectors Dtmf.high_freqs }

let strongest detectors block =
    let rec aux i best =
        if i = Array.length detectors then best
        else
            let p = Goertzel.power detectors.(i) block in
            let best = if p > snd best then (i, p) else best in
            aux (i + 1) best
    in
    aux 0 (0, neg_infinity)

let decode_block d block =
    let l, lp = strongest d.low block in
    let h, hp = strongest d.high block in
    if lp < threshold || hp < threshold then None
    else Some (Dtmf.key ~low:l ~high:h)

let decode d signal =
    let count = Array.length signal / d.block_size in
    let rec aux i prev acc =
        if i = count then List.rev acc
        else
            let current = decode_block d (Array.sub signal (i * d.block_size) d.block_size) in
            let acc =
                match current with
                | Some c when prev <> Some c -> c :: acc
                | _ -> acc
            in
            aux (i + 1) current acc
    in
    String.of_seq (List.to_seq (aux 0 None []))
