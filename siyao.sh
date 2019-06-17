#!/usr/bin/env bash
createkey() {
expect <<EOF
spawn ssh-keygen
expect ":" { send "\r" }
expect ":" { send "\r" }
expect ":" { send "\r" }
expect eof
EOF
}
thransferkey() {
passwd="chen"
expect <<-EOF
spawn ssh-copy-id root@192.168.220.129
expect "*yes/no*" { send "yes\r" }
exoect "*password*" { send "$passwd/r"}
EOF
}

if [ -f /usr/bin/expect];then
 if [ ! -f $HOME/.ssh/id_rsa ];then
	createkey
	thransferkey
else
        thransferkey
fi
else
	yum -y install expect
	if [ ! -f $HOME/.ssh/id_rsa ];then
        createkey
        thransferkey
	fi
fi
                      
