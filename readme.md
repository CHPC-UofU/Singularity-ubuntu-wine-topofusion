Wine container with TopoFusion

- to demonstrate how to incorporate Wine into Fedora or Ubuntu based Singularity containers. Following http://dolmades.org/, we first install Wine in the `%post` section, and then install the user application when first executing the container, and then run the application when subsequently running it, in the `%runscript` section.

- turns out Ubuntu works better in this case, with Fedora was getting occasional TopoFusion crashes

- TopoFusion requires DirectX 9 and Visual Basic runtime, installed via winetricks
