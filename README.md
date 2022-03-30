# Cytopacq Docker version
This is a version of `cytopacq` developed by the CBIA in Brno, Czech Republic, that has been containerized to be run with `docker` or `singularity`.

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

You can also run it using `singularity` if you are in an HPC environment.

```
singularity run docker://tp81/cytopacq
```

## Using the software

To use one of the defaults configurations, assuming you have an empty directory at "C:\tmp" (you can change it to whatever you please), you can launch cytopack with : 

```bash
docker run -it -v "C:\tmp:/data" ghcr.io/tp81/cytopacq:master -c /usr/local/config/microsphere.ini -f /data/im.ics -l /data/lb.ics -e /data/error.log
```

It'll take a few minutes to process. You should see ywo new images in `C:\tmp`, `im.ics` and `lb.ics`. These will be the image and label component of the simulated output. 


