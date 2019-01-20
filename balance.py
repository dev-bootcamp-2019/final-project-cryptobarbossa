import subprocess
with open('balance.txt', 'r') as myfile:
    data=myfile.read().replace('\n', '')
vdata = int(data)
if vdata > 0:
	subprocess.Popen(["./cfollow.sh"])
