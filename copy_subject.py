import os
import sys
import shutil


def duplicate_folder(src_folder, n_copies):
    for i in range(2, n_copies+2):
        out_folder = src_folder[0:-1] + str(i)
        try:
            shutil.copytree(src_folder, out_folder)
        except Exception as e:
            print(e) 
    return

if __name__ == '__main__':
    orig_subject = sys.argv[1]
    n_copies = int(sys.argv[2])
    duplicate_folder(orig_subject, n_copies)
