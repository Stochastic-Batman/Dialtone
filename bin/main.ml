let default_sample_rate = 8000.
let default_block_size = 205
let default_keys = "0123456789"

let rec parse args (sample_rate, block_size, keys) = match args with
    | [] -> (sample_rate, block_size, keys)
    | "--sample-rate" :: v :: rest -> parse rest (float_of_string v, block_size, keys)
    | "--block-size" :: v :: rest -> parse rest (sample_rate, int_of_string v, keys)
    | k :: rest -> parse rest (sample_rate, block_size, k)

let () =
    let args = List.tl (Array.to_list Sys.argv) in
    let sample_rate, block_size, keys =
        parse args (default_sample_rate, default_block_size, default_keys)
    in
    let signal = Dialtone.Encoder.encode ~sample_rate ~block_size keys in
    let d = Dialtone.Decoder.create ~sample_rate ~block_size in
    Printf.printf "encoded: %s\ndecoded: %s\n" keys (Dialtone.Decoder.decode d signal)
