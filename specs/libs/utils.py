import os

def Change_Directory(dir):
    os.chdir(dir)
    print "DST: ", os.getcwd()
