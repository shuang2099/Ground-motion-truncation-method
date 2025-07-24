%%%%%truncation point determination
clc
clear all
main_folder=['RESULT'];
eq_folders = dir(fullfile(main_folder, '*'));
eq_folders = eq_folders([eq_folders.isdir] & ~startsWith({eq_folders.name}, '.'));

for i = 1:length(eq_folders)
    eq_name = eq_folders(i).name;
    eq_path = fullfile(main_folder, eq_name);
    R_folders = dir(fullfile(eq_path, '*'));
    R_folders = R_folders([R_folders.isdir] & ~startsWith({R_folders.name}, '.'));
    
    for j = 1:length(R_folders)
        case_name = R_folders(j).name;
        case_path = fullfile(eq_path, case_name);
        % subfolders£¨R=1-6£©
        txt_files = dir(fullfile(case_path, '*.txt'));
        
        for k = 1:length(txt_files)
            txt_path = fullfile(case_path, txt_files(k).name);
            data=load(txt_path);
            [~,rows]=max(abs(data(:,2)));
            peak_times(j,k) = data(rows,1);
        end
    end
        if ~isempty(peak_times)
            result.(eq_name) = max(max(peak_times));
        else
            result.(eq_name) = NaN;
        end
end

% output
save('truncation_points.mat', 'result');
disp('over');

