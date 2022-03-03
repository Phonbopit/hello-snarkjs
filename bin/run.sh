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