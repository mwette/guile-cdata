# guile-cdata

guile modules for handling C data structures

The _cdata_ module (‘(foreign cdata)’ and its partner _arch-info_
(‘(foreign arch-info)’ provide a way to work with data originating from
C libraries.  Size and alignment is tracked for all types.  The procedures
‘cbase’, ‘cstruct’, ‘cunion’, ‘cpointer’, ‘carray’, ‘cenum’ and ‘cfunction’
 generate _ctype_ objects, and the procedure ‘make-cdata’ will generate data
 objects based on these.  The underlying bits of data are stored in Scheme
 bytevectors.  Access to component data is provided by the ‘cdata-ref’
procedure and mutation is accomplished via the ‘cdata-set!’ procedure.
The modules support non-native machine architectures via the global
parameter ‘*arch*’.