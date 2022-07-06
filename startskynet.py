# -*- coding=utf8 -*-

import subprocess

def syscmd(cmd):
    # subprocess.Popen(["cat","test.py"])
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, close_fds=True)
    # 响应码及内容
    stdout, stderr = p.communicate()
    print(stdout)
    print(stderr)
    print(p.returncode)

syscmd("cd skynet && ./skynet examples/config")
