let low_freqs = [| 697.; 770.; 852.; 941. |]

let high_freqs = [| 1209.; 1336.; 1477.; 1633. |]

let grid =
    [| [| '1'; '2'; '3'; 'A' |];
       [| '4'; '5'; '6'; 'B' |];
       [| '7'; '8'; '9'; 'C' |];
       [| '*'; '0'; '#'; 'D' |] |]

let key ~low ~high = grid.(low).(high)

let find ch =
    let rec aux1 row j =
        if j = Array.length row then None
        else if row.(j) = ch then Some j
        else aux1 row (j + 1)
    in
    let rec aux2 i =
        if i = Array.length grid then raise Not_found
        else match aux1 grid.(i) 0 with
            | None -> aux2 (i + 1)
            | Some j -> (i, j)
    in
    aux2 0
