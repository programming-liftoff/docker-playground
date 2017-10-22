# docker-playground
A Docker Image with multiple languages installed.  Useful as an alternative to creating a bunch of `temp` or `test` files when experimenting with a language.  Simply book up the container and do your code experiments inside it.  Exit the container when done, leaving no files for you to go and clean up later :)

## Getting Started
1) Clone the repository with `git clone https://github.com/programming-liftoff/docker-playground.git`
2) cd into the directory by typing `cd docker-playground/`
3) Build the image by typing `docker build -t playground:latest .`
4) Start a bash shell in the container by typing `docker run --rm -it playground`

## Additional Notes
At the beginning of the Dockerfile, some enviroment variable are set with the following lines:
```
ENV username andrew
ENV password pass
ENV rootpassword toor
```

When the container loads a shell, it will load to user `andrew`, with the password set to `pass`.  The password for the root user is set to `toor`.
If you wish to change these values, simply change them in this one place and rebuild the image with `docker-compose build` to update the container's settings.
