#!/bin/sh
echo "Enter the servername: "
read SERVER
#cat /home/sais/Sai/warDeployerInner.sh | ssh -t sais@$SERVER 'bash'
#ssh -t sais@$SERVER 'bash && sh warDeployerInner.sh'   << working but console control issue
#ssh -t sais@$SERVER screen -d -m 'bash && sh warDeployerInner.sh'
#ssh -t sais@$SERVER 'bash -s' < sh warDeployerInner.sh
#ssh -l sais $SERVER "sh /home/sais/Sai/warDeployerInner.sh"
#ssh -t sais@$SERVER "bash -s" < /home/sais/Sai/warDeployerInner.sh
ssh sais@$SERVER -t "bash --login && sh /home/sais/sai/warDeployerInner.sh"