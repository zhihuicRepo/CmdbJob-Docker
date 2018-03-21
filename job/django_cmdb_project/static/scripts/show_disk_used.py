#!/usr/bin/python
#-*- encoding:utf-8 -*-

import sys
import commands

#--------------------------
# 参数
#-------------------------

# 分区使用百分比默认阈值，该参数可运行时指定。
# 分区使用百分比大于该阈值则显示该分区状况。
default_pcent_threshold = 30


def more_threshold_disk(pcent_threshold):
    all_disk_use=commands.getoutput('df -h --output="target,size,pcent"')
    all_disk_use_list = all_disk_use.split("\n")
    more_threshold_disk_use_list = [all_disk_use_list[0]]

    for i in all_disk_use_list[1:]:
        used_pcent_num = int(i.split(" ")[-1].strip("%"))
        if used_pcent_num >= pcent_threshold:
            more_threshold_disk_use_list.append(i)

    print "\n".join(more_threshold_disk_use_list)


if __name__ == "__main__":

    try:
        pcent_threshold = int(sys.argv[1])
    except Exception:
        pcent_threshold = default_pcent_threshold

    more_threshold_disk(pcent_threshold)





