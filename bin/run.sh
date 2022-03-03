# Compile the circuit
circom circuit.circom --r1cs --wasm --sym

# View info about the circuit
snarkjs r1cs info circuit.r1cs

# Print constraints
# snarkjs r1cs print circuit.r1cs circuit.sym

# Calculate the witness
cd circuit_js
node generate_witness.js circuit.wasm ../input.json ../witness.wtns
cd ../

# Export r1cs to json
snarkjs r1cs export json circuit.r1cs circuit.r1cs.json

# Export wtns to json
snarkjs wtns export json witness.wtns witness.wtns.json

# ================
# Power of tau
# ================
# start new Powers of tau ceremony
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
# contribute to the ceremony
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
# 2nd contribution
snarkjs powersoftau contribute pot12_0001.ptau pot12_0002.ptau --name="Second contribution" -v -e="some random text"
# verify protocol
snarkjs powersoftau verify pot12_0002.ptau
# apply a random beacon
snarkjs powersoftau beacon pot12_0002.ptau pot12_beacon.ptau 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"
# Prepare phrase 2
snarkjs powersoftau prepare phase2 pot12_beacon.ptau pot12_final.ptau -v

# Verify the final ptau
snarkjs powersoftau verify pot12_final.ptau

# =============
# Setup Proving systems (groth16 & plonk)
# =============

# # Setup plonk & groth16
# snarkjs plonk setup circuit.r1cs pot12_final.ptau circuit_final.zkey
# snarkjs groth16 setup circuit.r1cs pot12_final.ptau circuit_0000.zkey

# # Contribute to phrase 2 ceremony
# # 1st contribution
# snarkjs zkey contribute circuit_0000.zkey circuit_0001.zkey --name="1st John Doe" -v
# # 2nd contribution
# snarkjs zkey contribute circuit_0001.zkey circuit_0002.zkey --name="Second Chuck Norris" -v -e="random"

# # Verify the latest zkey
# snarkjs zkey verify circuit.r1cs pot12_final.ptau circuit_0002.zkey