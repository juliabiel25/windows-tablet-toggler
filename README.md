# What is this

Windows uses a single `wintab32.dll` file typically located at `C:\Windows\System32` to handle pen tablet drivers, which often leads to conflicts when multiple tablets are installed. 
Typically only one of the tablets can use the windows ink features while the other has issues with pressure sensitivity.

The solution to the problem is either:
- uninstalling the unwanted tablet driver and reinstalling the driver for the tablet you want to switch to
- saving the `wintab32.dll` files corresponding to each tablet driver installation to a safe location and swapping the files in the windows directory to switch between tablets

This scripts automates the latter solution.
Use at your own discretion - administrator privileges are required to run this

This script requires a little bit of manual setup but once it's done, you can switch between tablets with a single click

# How to use
1. Download this repository and unpack the .zip folder. You should end up with a folder named `windows-tablet-toggler`.
2. Uninstall all tablet drivers you have currently installed on your computer (remember to backup your preferences & settings so that you can easily restore them later)
3. Install the tablet drivers to one of your tablets
4. Go to `[path_to_your_windows_installation_folder]\System32` - usually `C:\Windows\System32`
5. Search for a file called `wintab32.dll` and *copy it* into `windows-tablet-toggler\TABLET_1_DLL_FILE\`
6. Install the driver to your *other* tablet  
7. Once again go to `[path_to_your_windows_installation_folder]\System32` - usually `C:\Windows\System32`
8. Search for a file called `wintab32.dll` and this time copy it into `windows-tablet-toggler\TABLET_2_DLL_FILE\`
9. open the `windows-tablet-toggler\config.txt` file and make sure that `windowsFolderPath` is set to the correct path to your windows folder
10. Make sure you don't have any unsaved works opened up in any art software, bc the next step might forcibly close those programs and you might lose your progress :((((
11. Double-click on `windows-tablet-toggler\toggle_tablets.bat` whenever you want to switch between your tablets
12. Depending on the brand of your tablets, you might need to restart your tablet software (at least that's the case with my huion tablets and the huion app)


After completing the setup, all you need to do to switch between tablets is to run the `toggle_tablets` script