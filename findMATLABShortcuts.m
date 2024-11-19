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
        disp('Matching files Found');
        % disp(fileList);
    end
end