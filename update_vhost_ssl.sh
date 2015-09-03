for i in $(cat dominios.txt); do sed -i "s/#</</g" $i.conf; done
for i in $(cat dominios.txt); do sed -i "s/# //g" $i.conf; done
for i in $(cat dominios.txt); do sed -i "s/Possible/#Possible/g" $i.conf; done
for i in $(cat dominios.txt); do sed -i "s/alert/#alert/g" $i.conf; done
