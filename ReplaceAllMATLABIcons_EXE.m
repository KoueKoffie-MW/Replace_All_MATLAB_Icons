% First Check Admin Rights    
        [~, result] = system('net session');
        if contains(result, 'Access is denied')
            error('MATLAB is not running with administrative privileges. The script can not continue. Please restart MATLAB With Admin rights');
        else
            disp('MATLAB is running with administrative privileges. The script will continue');
        end

function fileList = findMATLABShortcuts()
    
    [~, username] = system('echo %USERNAME%'); 
    username = strtrim(username);
    % Define the root directory to search
    rootDir_1 = ('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\');
    rootDir_2 = ('C:\Users\Public\Desktop');
    rootDir_3 = char("C:\Users\" + username + "\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned");

    

    % Define the search pattern
    searchPattern = 'MATLAB ?????*.lnk';

    % Find all matching files
    fileList_1 = searchFilesRecursively(rootDir_1, searchPattern);
    fileList_2 = searchFilesRecursively(rootDir_2, searchPattern);
    fileList_3 = searchFilesRecursively(rootDir_3, searchPattern);

    fileList = [fileList_1 fileList_2 fileList_3];

    % Display the results
    if isempty(fileList)
        disp('No matching files found.');
    else
        disp('Matching files:');
        disp(fileList);
    end
end

function fileList = searchFilesRecursively(directory, pattern)
    % Initialize an empty cell array to store file paths
    fileList = {};

    % Search for files matching the pattern in the current directory
    files = dir(fullfile(directory, pattern));
    for k = 1:length(files)
        fileList{end+1} = fullfile(directory, files(k).name); %#ok<AGROW>
    end

    % Get a list of all subdirectories
    subDirs = dir(directory);
    for k = 1:length(subDirs)
        % Skip '.' and '..'
        if subDirs(k).isdir && ~strcmp(subDirs(k).name, '.') && ~strcmp(subDirs(k).name, '..')
            % Recursively search each subdirectory
            subDirPath = fullfile(directory, subDirs(k).name);
            fileList = [fileList, searchFilesRecursively(subDirPath, pattern)]; %#ok<AGROW>
        end
    end
end

% Run the function
Shortcuts = findMATLABShortcuts();

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
    if contains(targetPath,'MATLABwindow')
      
        % shortcut.TargetPath = 
    end 
    % Change the icon
    shortcut.IconLocation = New_Icon;
    
    % Save the changes
    shortcut.Save();
    
    % Clean up
    delete(shell);
end


