set -euo pipefail

g++ -std=c++17 -Wall -Wextra -pedantic encrypt.cpp -o encrypt
g++ -std=c++17 -Wall -Wextra -pedantic decrypt.cpp -o decrypt

[[ -x ./encrypt ]] || { echo "[FAIL] Missing encrypt executable"; exit 1; }
[[ -x ./decrypt ]] || { echo "[FAIL] Missing decrypt executable"; exit 1; }
echo "[PASS] AES programs compile successfully."

echo "Testing with message: 'hocdethaydoi'..."

echo "hocdethaydoi" | ./encrypt > /dev/null


RESULT=$(./decrypt | tail -n 1 | sed 's/Decrypted message: //')


CLEAN_RESULT=$(echo $RESULT | xargs)

if [ "$CLEAN_RESULT" == "hocdethaydoi" ]; then
    echo "[PASS] Roundtrip: hocdethaydoi -> encrypt -> decrypt -> hocdethaydoi"
else
    echo "[FAIL] Expected 'hocdethaydoi' but got '$CLEAN_RESULT'"
    exit 1
fi
