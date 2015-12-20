# unrar_parts
unrar all parts of rar files in direcotry

Description
-----------
This is wery usefull bash script when you want to extract a lot of files splitted into parts in one directory. All succesfully extracted files will be deleted.

For example:  
`$ ls ~/HomeVideo/`
> Holidays-2014.part1.rar  
> Holidays-2014.part2.rar  
> Summer-2014.part1.rar  
> Summer-2014.part2.rar  
> Christmass-2015.part1.rar  
> Christmass-2015.part2.rar  
> Christmass-2015.part3.rar  

Dependances
------------
*unrar* - RAR archiver - extract files from rar archives  
Install dependences via:  
`sudo dnf install unrar`  
`sudo aptitude install unrar`  

Usage
-----
`unrar_parts [options] [direcotry]`  
*direcotory* - Path to directory with rar files splited into parts. If directory is not set current directory will be used.
  
Options:  
*--install* - Copy script to '/usr/bin/unrar_parts'  
*--uninstall* - Remove script '/usr/bin/unrar_parts'  
*--help, -h* - Display help text  
  
Examples:    
`$ unrar_parts ~/HomeVideo/`	 Directory *HomeVideo* contains rar files splited to parts. 

