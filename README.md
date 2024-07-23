# Cytopacq Docker version
This is a version of [`cytopacq`](https://cbia.fi.muni.cz/research/simulations/cytopacq.html) developed by the CBIA in Brno, Czech Republic, that has been containerized to be run with `docker` or `apptainer`.

It contains all the defaults modules and can be run in the following way:

```
docker run -it --rm -v LOCAL_FOLDER:/data ghcr.io/tp81/cytopacq:master 
```

You can also clone this repository and build&run it locally

```
git clone https://github.com/tp81/cytopacq.git
cd cytopacq
docker build -t cytopacq .

docker run cytopacq -v LOCAL_FOLDER:/data
```

Mapping the `LOCAL_FOLDER` is optional but recommended. It avoids cluttering the container and with the `--rm` option, all traces created by `cytopacq` will be erased upon exit.

You can also run it using `apptainer` if you are in an HPC environment.

```
apptainer run docker://ghcr.io/tp81/cytopacq
```

## Using the software

To use one of the defaults configurations, assuming you have an empty directory at "C:\tmp" (you can change it to whatever you please), you can launch cytopack with : 

```
docker run -it -v "C:\tmp:/data" ghcr.io/tp81/cytopacq:master -c /usr/local/config/hl60-release.ini -f /data/im.ics -l /data/lb.ics -e /data/error.log
```

or with `apptainer`:

```
apptainer pull docker://ghcr.io/tp81/cytopacq:master 
apptainer run --bind ".:/data" ./cytopacq_master.sif -c /usr/local/config/hl60-release.ini -f /data/im.ics -l /data/lb.ics -e /data/error.log
```

It'll take a few minutes to process. You should see ywo new images in `C:\tmp`, `im.ics` and `lb.ics`. These will be the image and label component of the simulated output.

The list of available INI files is here:

```
docker run -it --rm --entrypoint /bin/bash ghcr.io/tp81/cytopacq:master -c "ls /usr/local/config"
```

or

```
apptainer  exec ./cytopacq_master.sif ls /usr/local/config
```

You can also create your own by modifying the ones in that directory.

## Authors
David Svoboda and the CBIA created Cytopacq.
Thomas Pengo dockerized it.
