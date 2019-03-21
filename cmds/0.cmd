################################################################################
# Startup command for QPG4 Vacuum Controller Module
# Common parameters 
# Mauro Giacchini - 2018-04-18
#
# Macro:
#
# DEVICENAME    - Device name, should be the same as the name in CCDB
# IPADDR        - Device IP address (QPC4 IP address)
# PORT          - Comms port to tcp-ip communication to QPC4
# ASYNPORT      - Asyn PORT
# AREASTRUCTURE - Areastructure (as defined on ESS CCDB)
# PUMP          - 1...4
#
################################################################################

require stream
#require iocStats
#require autosave

epicsEnvSet("TOP","/home/maurogiacchini/e3-dtl/siteApps/e3-qpcMod")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/qpcMod-loc/qpcModApp/Db")

epicsEnvSet("DEVICENAME", "VAC-QPG4")
epicsEnvSet("IPADDR", "10.6.0.88")
epicsEnvSet("PORT", "23")

epicsEnvSet("AREASTRUCTURE", "LNL-DTL-010")

drvAsynIPPortConfigure(${DEVICENAME}-asyn-port,${IPADDR}:${PORT},0,0,0)
 
#Load your database defining the EPICS records

dbLoadRecords("$(TOP)/qpcMod-loc/qpcModApp/Db/qpcMod.db", "DEVICENAME = $(DEVICENAME), ASYNPORT = $(DEVICENAME)-asyn-port, PUMP = 1 , AREASTRUCTURE = $(AREASTRUCTURE)")

dbLoadRecords("$(TOP)/qpcMod-loc/qpcModApp/Db/qpcMod.db", "DEVICENAME = $(DEVICENAME), ASYNPORT = $(DEVICENAME)-asyn-port, PUMP = 2 , AREASTRUCTURE = $(AREASTRUCTURE)")

#dbLoadRecords("iocAdminSoft.db","IOC=$(IOCNAME):IocStat")

#loadIocsh("iocStats.iocsh", "IOCNAME=$(IOCNAME)")
#loadIocsh("recsync.iocsh",  "IOCNAME=$(IOCNAME)")
#loadIocsh("autosave.iocsh", "IOCNAME=autosave, AS_TOP=$(TOP)")

iocInit()

dbl > "$(TOP)/$(DEVICENAME)_PVs.list"
