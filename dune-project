(lang dune 3.24)
(name dialtone)
(generate_opam_files true)
(license GPL-3.0-only)
(authors "Stochastic Batman <StochasticBatman@proton.me>")
(maintainers "Stochastic Batman <StochasticBatman@proton.me>")
(source (github Stochastic-Batman/Dialtone))
(homepage "https://github.com/Stochastic-Batman/Dialtone")
(bug_reports "https://github.com/Stochastic-Batman/Dialtone/issues")

(package
 (name dialtone)
 (synopsis "Decode Dual-Tone Multi-Frequency (DTMF) phone keypad tones into keys")
 (description "Dialtone decodes Dual-Tone Multi-Frequency (DTMF) telephone keypad tones back into the keys they represent.")
 (license GPL-3.0-only)
 (tags ("dtmf" "signal processing" "goertzel algorithm" "telephony"))
 (depends
  ocaml
  dune))
