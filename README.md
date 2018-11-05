# docker_container_ssh-server
To build the image: 

    $ docker build -t ssh-server .

To run the image:

    $ docker run -d -P --name server ssh-server

To find the port:

    $ docker port server 22

To connect using ssh:

    $ ssh root@192.168.1.2 -p [port]

