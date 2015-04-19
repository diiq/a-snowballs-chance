rm -rf snowball
BROCCOLI_ENV=production broccoli build snowball
scp -r snowball stm31415_sam@ssh.phx.nearlyfreespeech.net:/home/public
