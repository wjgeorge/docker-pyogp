FROM ubuntu:18.04
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends libterm-readline-gnu-perl apt-utils
RUN apt-get install -y --no-install-recommends python2.7 virtualenv mercurial
RUN apt-get install -y --no-install-recommends mlocate vim # gcc python2.7-dev curl
RUN mkdir hg && cd hg; \
	hg clone https://enus_linden@bitbucket.org/lindenlab/pyogp.apps/; \
	hg clone https://enus_linden@bitbucket.org/lindenlab/pyogp.lib.base/; \
	hg clone https://enus_linden@bitbucket.org/lindenlab/pyogp.lib.client-maint/;
RUN cd ~; mkdir sandbox ; cd sandbox; virtualenv . --no-site-packages
RUN cd /hg/pyogp.lib.base; sed "s/'elem/# 'elem/g" setup.py > foo; mv foo setup.py
RUN cd /hg/pyogp.lib.base; ~/sandbox/bin/python setup.py install
RUN cd /hg/pyogp.lib.client-maint; ~/sandbox/bin/python setup.py install
RUN cd /hg/pyogp.apps; ~/sandbox/bin/python setup.py install
RUN updatedb
ENV PYTHONHTTPSVERIFY 0
