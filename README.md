# Dialtone

Dialtone decodes touch-tone phone sounds back into the digits they represent. Every time you press a key on an old-fashioned telephone keypad, it plays two sine tones at once. Dialtone listens to those tones and works out which keys were pressed.

It is written in OCaml, built with Dune, and is a small, self-contained exercise in digital signal processing.

## Background: what is DTMF?

DTMF stands for *Dual-Tone Multi-Frequency*, the system that replaced rotary dialing in telephone networks. Each key is assigned a pair of frequencies: one from a low group and one from a high group.

|          | 1209 Hz | 1336 Hz | 1477 Hz | 1633 Hz |
|----------|:-------:|:-------:|:-------:|:-------:|
| **697 Hz**  |    1    |    2    |    3    |    A    |
| **770 Hz**  |    4    |    5    |    6    |    B    |
| **852 Hz**  |    7    |    8    |    9    |    C    |
| **941 Hz**  |    *    |    0    |    #    |    D    |

So pressing **5** produces 770 Hz and 1336 Hz together. The receiver's job is the reverse: given a sound, find the two frequencies present and look up the key.

## What Dialtone does

1. Generates DTMF tones for any sequence of keys, so you can create test audio on demand.
2. Decodes a stream of samples back into the keys that were pressed.
3. Detects frequencies efficiently using the Goertzel algorithm, which measures the strength of a single frequency without computing a full Fourier transform.

The idea is simple enough to follow without any signal processing background: the program listens for the two loudest tones in each short slice of sound, and maps that pair to a key.

## Testing

- **Round trip:** generated tones for a sequence of keys must decode back to the same sequence.
- **Known frequencies:** a pure tone at a given frequency must be detected at exactly that frequency.

## Build system

Dialtone uses [Dune](https://dune.readthedocs.io/), the standard build system for OCaml projects.
