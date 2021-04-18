# CMD-Toolbase
A dynamic launcher for Windows CMD files written entirely in Batch.

This small batch script enumerates all .cmd files in the modules subfolders and presents them in
a simple menu. It uses some tools from the <a href="http://gnuwin32.sourceforge.net/packages/coreutils.htm">CoreUtils for Windows</a>
for display.

# Usage
1. Rename the Toolbase.cmd and Toolbase.cfg to whatever you like (the files need to have the same name)
and set the (hopefully self-explanatory) options in the configuration file.
2. Create some module category folders in the 'Modules' folder. They need to use the naming convention "###_Category_Name" where
"###" is a 3-digit number used for sorting.
3. Place batch scripts in the category folders, again using the naming convention "###_Module_Name.cmd".
4. Profit.
