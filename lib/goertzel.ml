type t = { coeff : float }

let create ~sample_rate ~block_size ~freq = 
    let bin = Float.round ( (float block_size) *. freq /. sample_rate) in
    let x = 2. *. Float.pi *. bin /. (float block_size) in
    { coeff = 2. *. cos x }

let power { coeff } block = 
    let s1, s2 = Array.fold_left (fun (s1, s2) x -> (x +. coeff *. s1 -. s2, s1)) (0., 0.) block 
    in
    (s1 *. s1) +. (s2 *. s2) -. (coeff *. s1 *. s2)
