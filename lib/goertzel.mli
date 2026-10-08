(** A detector tuned to a single frequency. **)
type t

(** Work out which frequency bin is closest to freq, and convert that bin into the coefficient. **)
val create : sample_rate:float -> block_size:int -> freq:float -> t

(** Run the Goertzel recurrence over every sample in block, then combine the final two state values into a single number. **)
val power : t -> float array -> float
