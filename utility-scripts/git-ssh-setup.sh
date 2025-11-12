#!/bin/bash

echo "=========================================="
echo "===== GIT SSH SETUP SCRIPT BY vs-123 ====="
echo "=========================================="

read -p "Do you wish to continue? (y/n) " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
   echo "Exiting..."
   exit 1
fi

ssh-keygen -t ed25519 -C "" -f ~/.ssh/gh && echo "[SCRIPT INFO] Generated SSH key."   && \
eval "$(ssh-agent -s)" && echo "[SCRIPT INFO] Ran ssh-agent."                         && \
ssh-add ~/.ssh/gh      && echo "[SCRIPT INFO] Added SSH."

public_key_response=""


while [[ "$(echo "$public_key_response" | tr '[:upper:]' '[:lower:]')" != "y" ]]; do
   
echo "======================"
echo "===== PUBLIC KEY ====="
echo "======================"

echo "* This is your public key."
echo "* Copy the following and then put it at: https://github.com/settings/keys."
echo ""
echo "$(cat ~/.ssh/gh.pub)"
echo ""
echo "* Once you're done, respond with 'y' or 'Y'."
echo "* Any other response will repeat this."
read -p "Are you done? (y/n) " public_key_response

done

echo "===================="
echo "===== SSH TEST ====="
echo "===================="
echo "Testing your ssh, please wait..."
ssh -T git@github.com && echo "GitHub ssh was successfully setup!"

echo "THE END"

