FROM ubuntu:20.04


# From https://dev.to/setevoy/docker-configure-tzdata-and-timezone-during-build-20bk
# Feel free to change the timezone... Use tzselect command to find out what to put here.
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y wget

RUN apt-get install -y cmake build-essential unzip 

#### INSTALL I3DLIBS
RUN wget --no-check-certificate https://cbia.fi.muni.cz/files/software/i3dlib/i3dcore_and_i3dalgo-20190409.zip
RUN unzip i3dcore_and_i3dalgo-20190409.zip
RUN apt-get install -y libfftw3-dev zlib1g-dev libtiff-dev libpng-dev libics-dev libhdf5-dev 
RUN cd /i3dlibs && cmake -D ALGO_WITH_FFTW=ON -D CORE_HDF5_HEADERS_REL=/usr/include/hdf5/serial -D CORE_HDF5_HL_LIB_REL=/usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_hl.so -D CORE_HDF5_LIB_REL=/usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5.so .
RUN cd /i3dlibs && make install

RUN wget https://cbia.fi.muni.cz/files/software/CytoPacq/sim-app-2015-03-04-r82.tgz

RUN tar xzvf sim-app-2015-03-04-r82.tgz

#### INSTALL SIM-APP
RUN apt-get install -y libqhull-dev libgsl-dev flex bison 
RUN cd /sim-app && cmake . -D INC_QHULL=/usr/include/qhull
RUN cd /sim-app && LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu make install

COPY zmenseny.ics /usr/local/psf/zmenseny.ics

ENV LD_LIBRARY_PATH=/usr/local/lib

ENTRYPOINT [ "/usr/local/bin/cytopacq","-d","/usr/local/plugins" ]
#ENTRYPOINT [ "/bin/bash"]
