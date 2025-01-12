import os

#set directory path
directory = '/Users/brianbaseggio/Downloads'

#set file extension to delete
file_extension = '.csv'

#Traverse directory to search for and delete defined file type
for root, dirs, files, in os.walk(directory):
    for file in files:
        if file.endswith(file_extension):
            file_path = os.path.join(root, file)
            os.remove(file_path)

