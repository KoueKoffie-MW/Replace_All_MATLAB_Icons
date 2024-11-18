function iconPath = ReplaceMATLABIcon()
% First Check Admin Rights    
     [~, result] = system('net session');
        if contains(result, 'Access is denied')
            error('MATLAB is not running with administrative privileges. The script can not continue. Please restart MATLAB With Admin rights');
        else
            disp('MATLAB is running with administrative privileges. The script will continue');
        end

    % Get the current release of the running session
    CurrentVersion = version('-release');

    % Extract the last three characters
    CurrentVersion = CurrentVersion(end-2:end);
    CurrentVersion = strjoin(["matlab_", CurrentVersion, ".ico" ],'');
    

    New_Icon = fullfile(pwd, 'matlab.icons',CurrentVersion);

    % Get the root directory of the current MATLAB installation
    matlabRoot = matlabroot;
    
    % Construct the expected path to the MATLAB icon file
    % Note: This path may vary between MATLAB versions and installations
    iconPath = fullfile(matlabRoot, 'bin','win64', 'matlab.ico');
    
    % Check if the icon file exists
    if ~isfile(iconPath)
        error('Icon file not found at %s', iconPath);
    else

    end


[status, message, messageId] = copyfile(New_Icon, iconPath,"f");


if status
        disp('File copied successfully.');
    else
        error('FileCopyError:CopyFailed', 'File copy failed: %s', message);
end

shortcutPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MATLAB R2024b\MATLAB R2024b.lnk';


    % Create a COM server for the Windows Script Host Shell
    shell = actxserver('WScript.Shell');
    
    % Load the shortcut
    shortcut = shell.CreateShortcut(shortcutPath);
    
    % Change the icon
    shortcut.IconLocation = iconPath;
    
    % Save the changes
    shortcut.Save();
    
    % Clean up
    delete(shell);








end






% % Example usage
% try
%     iconPath = getCurrentMATLABIconPath();
%     disp(['MATLAB Icon Path: ', iconPath]);
% catch ME
%     disp(ME.message);
% end