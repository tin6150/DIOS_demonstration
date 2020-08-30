

used podman from centos 8 (vagrant_centos8).

Mostly worked.
But there were some error that was a bit unsettling.

at the end of podman build:
	[tin@viagra8 DIOS_demonstration]$ podman build -t tin6150/r4envids -f Dockerfile .  | tee Dockerfile.monolithic.LOG5
	[...]
	STEP 14: ENV TEST_DOCKER_ENV_REF https://vsupalov.com/docker-arg-env-variable-guide/#setting-env-values
	701f88b2eb21079f14e85f9f89e242048ab032ddab3ebb92fb0967bbf938a32e
	STEP 15: ENTRYPOINT [ "R" ]
	STEP 16: COMMIT tin6150/r4envids
	85964c39af4ad7e87481e9ca126cddf528fd0106b3e95db02d4db0a9623ce178 
	ERRO[3656] unable to close namespace: "close /proc/2901/ns/user: bad file descriptor"   **<<**
	[tin@viagra8 DIOS_demonstration]$ echo $?
	0


when doing push to registry:

	[tin@viagra8 DIOS_demonstration]$ podman push tin6150/r4envids
	Getting image source signatures
	Copying blob 7a9621ee0179 skipped: already exists
	Copying blob 27ac778f7055 skipped: already exists
	Copying blob bd0898275f20 skipped: already exists
	Copying blob d363c4db28af skipped: already exists
	Copying blob ef0982811f40 skipped: already exists
	Copying blob 785d1cb27d7b skipped: already exists
	Copying blob f2dbbd35552d done
	Copying blob a457865a21c4 done
	Copying blob 7269a7c39cc3 done
	Copying blob c9ca87d8f65f done
	Copying blob 267204440f04 done
	Copying config 85964c39af done
	Writing manifest to image destination
	Storing signatures
	ERRO[1688] unable to close namespace: "close /proc/2901/ns/user: bad file descriptor"  **<<**
	[tin@viagra8 DIOS_demonstration]$ echo $?
	0
	[tin@viagra8 DIOS_demonstration]$ 

so for container seems to work with no detrimental effect.

was able to pull it
**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run -it tin6150/r4envids

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker pull tin6150/r4envids                                                                 
Using default tag: latest
latest: Pulling from tin6150/r4envids
2dffa903b83a: Already exists 
10f3fdbe572d: Already exists 
663fe05835c5: Already exists 
7a88b43f1097: Already exists 
ff9b12da32ab: Already exists 
bd3fedd8743f: Already exists 
21678b468566: Pull complete 
cddf1ef23fd1: Pull complete 
9c4e56795e4a: Pull complete 
2b2601546dfc: Pull complete 
8466fad94300: Pull complete 
Digest: sha256:8801eee7b7767fcb17d2aaa8ff255ae9266d98549e02e6c2b6dacc8ba1232719
Status: Downloaded newer image for tin6150/r4envids:latest

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run -it tin6150/r4envids

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run -it --entrypoint="/usr/bin/Rscript" tin6150/r4envids  -e 'library()' 
cannot use | or > with the above command.  docker likely doing something funky with the I/O stream.

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run  --entrypoint="/usr/bin/Rscript" tin6150/r4envids  -e 'library()'  | wc 
	191



singularity-hub problem though

	Storing signatures
	2020/08/29 23:22:55 info unpack layer: sha256:2dffa903b83a05e8f7056f2d8f378ea21af1cbc9a30f68bb9f93f103520963cb
	[31mFATAL: [0m While performing build: packer failed to pack: while unpacking tmpfs: error unpacking rootfs: unpack layer: read next entry: archive/tar: invalid tar header   **<<**
	ERROR Build error. See above for details



So, actually end up doing a hub.docker.com cloud build based on the Dockerfile.
(sudo docker build -t tin6150/r4envids -f Dockerfile .  | tee Dockerfile.monolithic.LOG on bofh completed without error)

doing singularity build.

Note that Zink (Mint) has R 3.4.4 and many of the required packages, like cowplot, don't install in this old R.
May have to find way to install archived packages, or use this containerized R, which seems to be 4.0.2 !

