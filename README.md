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

![Capture1](https://user-images.githubusercontent.com/69786817/115140799-6dc2e000-a039-11eb-885d-79578d1fee4d.PNG)
![Capture2](https://user-images.githubusercontent.com/69786817/115140806-79aea200-a039-11eb-8374-055ca52765e5.PNG)
