#### su -> change user
#### whoami -> Prints username of the current user
#### groups -> a script that prints all the groups the current user is part of.
#### touch -> creates a new empty file
#### chmod u+x file ->  gives user write permissions
#### chmod ug+x, o+r file -> gives user and groupuser permissions to execute and all read permissions
#### chmod ugo+x -> adds execution rights to all users
#### chmod 007 -> gives all users all rights
#### chmod 753
#### chmod --reference=ref_file file -> copies permissions from another filie
#### chmod -R ugo+x . -> adds execute permissions to subdirectories
#### mkdir -m 751 dir -> a script that creates a directory called my_dir with permissions 751 in the working directory.
#### chmod chgrp owner file -> change_group
