With tracked_plugins installation stays the same and new meta information
(url / installed_at / revision / plugin-locally-hacked? /...) is stored <-> used to update/list plugins.

# Install
    script/plugin install git://github.com/grosser/tracked_plugins.git

# Usage
###Install
As usual:
    script/plugin install git://github.com/grosser/parallel_specs.git

###List
With revision and installed_at date (for every newly installed plugin)
    script/plugin list
    parallel_specs git://github.com/grosser/parallel_specs.git b195927a98aa351fcefef20730a2fdad7ff3efd5 2010-01-10 15:46:44

###Update
Already most recent revision ?
    script/plugin update parallel_specs
    Plugin is up to date: parallel_specs (b195927a98aa351fcefef20730a2fdad7ff3efd5)

Do we need a update?
    script/plugin update parallel_specs
    Reinstalling plugin: parallel_specs (b195927a98aa351fcefef20730a2fdad7ff3efd5)
    Unpacking objects: 100% (21/21), done.
    From git://github.com/grosser/parallel_specs
     * branch            HEAD       -> FETCH_HEAD

###Info
 - Locally modified == you made some hacks!!
 - checksum == md5 checksum of this plugins folder

:
    script/plugin info parallel_specs
    checksum: 8a6d69d6c7fb0928ccae8b451a2914eb
    locally_modified: No
    installed_at: Sun Jan 10 15:59:27 +0100 2010
    revision: b195927a98aa351fcefef20730a2fdad7ff3efd5
    uri: git://github.com/grosser/parallel_specs.git

# TODO
 - `script/plugin diff` that shows what changed in the remote <-> review before updating
 - do a real update: checkout, copy .git over, rebase/stash <-> keep modifications
 - add `script/plugin reinstall`
 - create PLUGIN_INFO.yml for tracked_plugins after installation (install.rb)

Author
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...