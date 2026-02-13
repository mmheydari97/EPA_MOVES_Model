#!/bin/bash

# s3 parameters:
# --------------------------
# login accesskey <keyvalue> secretkey <keyvalue>
# logout
#
# put bucket <bucketname> nameinbucket <nameinbucket> file <filenameandpath>
#     Note: put creates the bucket if it does not exist and does not transfer
#           if <nameinbucket> already exists.
# get bucket <bucketname> nameinbucket <nameinbucket> file <filenameandpath>
#     Note: get does not transfer data if <filenameandpath> already exists.
# delete bucket <bucketname> nameinbucket <nameinbucket>
#     Note: delete reports warnings if the bucket or the named object do not exist.
# list bucket <bucketname>
#
# job parameters:
# --------------------------
# createqueue queue <queuename> timeoutminutes <defaulttimeoutminutes>
# listqueues
# addstatus queue <queuename> status <statusmessage>
# getstatus queue <queuename> command <commandtorun>
#     Execute <commandtorun> with MOVES_STATUS environment variable.
# getjob queue <queuename> command <commandtorun>
#     Execute <commandtorun> with environment variables:
#     MOVES_JOBID
#     MOVES_DATABASEBUCKET
#     MOVES_DATABASENAME
#     MOVES_CODEBUCKET
#     MOVES_CODENAME
#     MOVES_JOBBUCKET
#     MOVES_JOBNAME
# 	MOVES_STATUSQUEUE
# completejob queue <queuename> jobid <jobid>
# addjob jobqueue <jobqueuename> statusqueue <statusqueuename>
#     databasebucket <dbbucket> database <dbname>
#     codebucket <codebucket> code <codename>
#     jobbucket <jobbucket> job <jobjarname>

ant -Dcmd="login accesskey ACCESSKEY secretkey SECRETKEY" s3

ant -Dcmd="list bucket moves-experiment-1" s3
ant -Dcmd="createqueue queue epa-moves-jobs timeoutminutes 1440" job
ant -Dcmd="createqueue queue epa-moves-stats timeoutminutes 10" job

ant -Dcmd="listqueues" job

# ant -Dcmd="addstatus queue epa-moves-stats status \"This is a full message One\"" job
# ant -Dcmd="addstatus queue epa-moves-stats status \"This is a full message Two\"" job
# ant -Dcmd="addstatus queue epa-moves-stats status \"This is a full message Three\"" job
# ant -Dcmd="addstatus queue epa-moves-stats status \"This is a full message Four\"" job

# ant -Dcmd="getstatus queue epa-moves-stats command statuscallback.sh" job

# ant -Dcmd="logout" s3
