# What is this

Windows uses a single `wintab32.dll` file typically located at `C:\Windows\System32` to handle pen tablet drivers, which often leads to conflicts when multiple tablets are installed. 
Typically only one of the tablets can use the Windows ink features while the other tends to have issues with pressure sensitivity.

The solution to the problem is either:
- uninstalling the unwanted tablet driver and reinstalling the driver for the tablet you want to switch to
- saving the `wintab32.dll` files corresponding to each tablet driver installation to a safe location and swapping the files in the Windows directory to switch between tablets

These scripts automate the latter solution.
Use at your discretion - administrator privileges are required to run this

This script requires a little bit of manual setup but once it's done, you can switch between tablets with a single click

# How to use
1. Download this repository (Green `Code` button at the top --> Download ZIP)
2. Unpack the zip folder. You should end up with a folder named `windows-tablet-toggler`.
3. Uninstall all tablet drivers currently installed on your computer (*remember to backup your preferences & settings so that you can easily restore them later*)
4. Install the tablet drivers to **one** of your tablets
5. Go to `[path_to_your_windows_installation_folder]\System32` - usually `C:\Windows\System32`
6. Search for a file called `wintab32.dll` and **copy it** into `windows-tablet-toggler\TABLET_1_DLL_FILE\`
7. Install the driver to your **other** tablet  
8. Once again go to `[path_to_your_windows_installation_folder]\System32` - usually `C:\Windows\System32`
9. Search for a file called `wintab32.dll` and *this time* copy it into `windows-tablet-toggler\TABLET_2_DLL_FILE\`
10. open the `windows-tablet-toggler\config.txt` file and make sure that `windowsFolderPath` is set to the correct path to your Windows folder
11. Make sure you don't have any unsaved works opened up in any art software, bc the next step might forcibly close those programs and you might lose your progress which would be pretty sad :((((
12. Double-click on `windows-tablet-toggler\toggle_tablets.bat` whenever you want to switch between your tablets
13. Depending on the brand of your tablet, you might need to restart your tablet software (at least that's the case with my huion and the huion desktop app)


After completing the setup, all you need to do to switch between tablets is to run the `toggle_tablets` script

Works for me and my Huion and XPPen babies
