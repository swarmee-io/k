VERSION=$(cat $HOME/docker-ce/VERSION)
NAME=$(cat $HOME/docker-ce/VERSION | sed -e s/-/~/g)
FILENAME=$(find .. -name "*$NAME*.deb")

rm -rf tmp
dpkg-deb -R $FILENAME tmp

sed -i 's/Package: docker-ce/Package: kengine/' tmp/DEBIAN/control
sed -i 's/Conflicts:/Conflicts: docker-ce,/' tmp/DEBIAN/control
sed -i 's/Replaces:/Replaces: docker-ce, docker-ee,/' tmp/DEBIAN/control

dpkg-deb -b tmp/ kengine_${NAME}-0~ubuntu_amd64.deb

rm -rf tmp