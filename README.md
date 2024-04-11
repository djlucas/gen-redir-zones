The txt files include a list of domains that are used for the named app.
Simply run:
    server="ns1.mydomain.com" list="facebook.txt" gen-file.sh

Optionally, you can omit the list parameter and all txt files will be processed.

Output will go to the current directory in a new subfolder named "redir" which
contains a zone file for each domain that points to 127.0.0.1 and a single
named.conf include file for each application. This entire directory should be
copied directly to /var/named/. You can then include the configuration file at
the appropriate level in your named.conf file or other include (for instance,
import these only at a particular view that includes children's PCs).
