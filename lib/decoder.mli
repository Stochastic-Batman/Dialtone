type t

val create : sample_rate:float -> block_size:int -> t

val decode_block : t -> float array -> char option

val decode : t -> float array -> string
