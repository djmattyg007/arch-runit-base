.PHONY: docker
docker: runsvinit
	docker build -t djmattyg007/arch-base .

runsvinit: ${GOPATH}/bin/runsvinit
	cp $< $@

$GOPATH/bin/runsvinit:
	go get -u github.com/djmattyg007/runsvinit

