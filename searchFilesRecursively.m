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