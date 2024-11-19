% First Check Admin Rights    
        [~, result] = system('net session');
        if contains(result, 'Access is denied')
            error('MATLAB is not running with administrative privileges. The script can not continue. Please restart MATLAB With Admin rights');
        else
            disp('MATLAB is running with administrative privileges. The script will continue');
        end

% Run the function
Shortcuts = findMATLABShortcuts();
flag = 0;
Win_c = 1;
for L = 1:length(Shortcuts)
    version_n = char(Shortcuts(L));
 
    % Regular expression pattern to match "MATLAB R20" followed by three characters
    pattern = 'MATLAB R20(\w{3})';
    % Extract the three characters after "MATLAB R20"
    version_new = regexp(Shortcuts(L), pattern, 'tokens');
    version_new =  (version_new{end});
    version_new =  (version_new{end});
    version_new =  char(version_new{end,end});
    
    % version_new = version_n(end-6:end-4);
 version_new = strjoin(["matlab_", version_new, ".ico" ],'');

 New_Icon = fullfile(pwd, 'matlab.icons',version_new);

 % Create a COM server for the Windows Script Host Shell
    shell = actxserver('WScript.Shell');
    
    % Load the shortcut
    shortcut = shell.CreateShortcut(version_n);

    % Get the target path of the shortcut
    targetPath = shortcut.TargetPath;
    if contains(targetPath,'MATLABWindow','IgnoreCase',1)
      disp('You have a shortcut pinned that uses the New Desktop - this may cause issues with the icons')
        % 
        NewShort = insertBefore(Shortcuts(L),'.lnk','Window');
        NewShort = NewShort{1};
        OldShort = Shortcuts(L);
        OldShort = OldShort{1};
        copyfile(string(OldShort),string(NewShort))
        shortcut.TargetPath = erase(targetPath,'Window');
        flag = 1;
        version_new_window(Win_c) = version_new;
        version_n_window(Win_c) = string(version_n);
        Win_c = Win_c+1;

    end 
    % Change the icon
    shortcut.IconLocation = New_Icon;
    
    % Save the changes
    shortcut.Save();
    
    % Clean up
    delete(shell);
end

if flag == 1
    for Count = 1:length(version_new_window)    
        New_Icon = fullfile(pwd, 'matlab.icons',version_new_window(Count));
        % Create a COM server for the Windows Script Host Shell
        shell = actxserver('WScript.Shell');
        
        % Load the shortcut
        shortcut = shell.CreateShortcut(version_n_window(Count));
    
        % Get the target path of the shortcut
        targetPath = shortcut.TargetPath;  
    
        % Change the icon
        shortcut.IconLocation = New_Icon;
        
        % Save the changes
        shortcut.Save();
        
        % Clean up
        delete(shell);
    end
end


