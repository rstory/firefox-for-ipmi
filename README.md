# firefox-for-ipmi
Firefox 52.9.0 ESR with Java 8 and Javaplugin

**NOTE** For this to work your local user on your linux host need to have uid 1000 gid 1000 

**WARNING** This web browser is very  insecure with very lax security permission + java, so you should not run it for any generic web site. 

## To run 
docker run --net=host -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix opentokix/firefox-for-ipmi 
