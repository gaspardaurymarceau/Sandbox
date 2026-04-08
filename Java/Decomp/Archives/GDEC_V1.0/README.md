# PERSONAL NOTE :
This program is very bad, please do not use it anywhere serious.
I made that as a project in year one of CS.
Perhaps I will improve it in the future ?

# Documentation :

### Usage :
GDec (Goldrev's Decomposer) is a tool allowing the Decomposition of an item's recipe following given recipes.

Its config file (currently named test.gdec) is formatted as follows :

```
:BASE
FOO
BAR
:RECIPE
BAZ=2FOO+3BAR
BAZPRIME=BAZ+4FOO+6BAR
```

IMPORTANT : An item's name MUST be consistent, or two different items will be created
    ex : Foo and FOO will be interpreted as different items !

The file MUST start with the (case-sensitive!) :BASE beacon : its absence will raise an error.
Following this beacon, all base items should be named, one per line.
A base item is an item which does not have a recipe.

After listing all bases, the (case-sensitive!) :RECIPE beacon should be written.
Following this beacon, new items can be created from the ones listed in the :BASES section, or in this section.
The syntax behaves as follows :
    A=xB+yC
means that the (new) item A is composed of x times the item B, as well as y times the item C.
The only symbols allowed are :
    - = and +
    - Uppercase and lowercase letters for item names
    - Numbers before an item's name to indicate its quantity
This exact syntax should be respected, or the program will likely break. Spaces are not allowed.
If an item's quantity is 1, the number can be removed (ex : A=B+2C+D)

### Edge cases :
- Item being both in the base and recipe sections :
    The item will be treated as a recipe.
- Item being listed in a recipe without either being a base or having its own recipe
    The program will break. Please do not do that.
- Item having two recipes
    TODO : the first one will probably override the second, the latter being further in the catalog array