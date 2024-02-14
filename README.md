# AES_CTR_128
Advanced Encryption Standard Counter Mode 128 bit for FPGAs coded in Verilog.


Includes a bitstream compiled for the Nexys A7-100T.


Default settings for RealTerm UART: 57600 baud, 8 data bits, 1 stop bit, atleast 20 ms delay between bytes/characters sent.

SW15 - Reset

SW2 and SW1 - Counter block import and Key import, defaults are 0 if not imported.

SW0 - Leave on to continuously return ciphertext using the counter, key and plaintext sent via UART.
