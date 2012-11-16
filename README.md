gtype.vim
=========

Practice touch typing real code ... your code. 
Gtype is a Vim plugin that allows you to source a text selection as a [Gypist Drill excercice](http://www.gnu.org/software/gtypist/doc/#Script-file-commands).
Once the excercice is finished or cancelled, you get back to your normal untouched Vim session.


Dependencies
---

* This plugin depends on [GNU Typist(also called gtypist)](http://www.gnu.org/software/gtypist) a free software universal typing tutor
   * on MacOS it can be installed via brew's  gtypist formula
* It requires Vim compiled with the **+ruby** feature.


Installation
---

Use [pathogene](https://github.com/tpope/vim-pathogen) or [vundle](https://github.com/gmarik/vundle)

Usage
---

select a range and call Gtypist() function
*example*
```:1,4 call Gtypist```
