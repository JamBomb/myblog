
# debug trace

## set output buffer size
```bash
ytnd set output_buffer_size 8388608
```

## switch hwa debug trace

```bash
cd /isam/slot_default/switch_hwa_app/run
calamares -nct  tty1_ext
------------------------------------
log set output max_entries 0 1000000
log set output max_files 0 10

mh gpb_record enable all
mh gpb_record max_size 300000

log set output loglevel CONSOLE YLOG_DEBUG
log set output loglevel LOGFILE YLOG_DEBUG

log set module loglevel yproto YLOG_DEBUG

log set module loglevel switch_hwa YLOG_DEBUG
log set module loglevel switch_hal YLOG_DEBUG
log set module loglevel switch_adapter YLOG_DEBUG

log set module loglevel ph_comm YLOG_DEBUG
log set module loglevel ph_adapter YLOG_DEBUG

log set module loglevel dot1x_common YLOG_DEBUG
log set module loglevel dot1x_adapter YLOG_DEBUG
```

## qos debug trace
```bash
log set module loglevel policy_mh  YLOG_DEBUG
log set module loglevel policy_common  YLOG_DEBUG
log set module loglevel tm_mh YLOG_DEBUG
log set module loglevel tm_common YLOG_DEBUG
log set module loglevel switch_adapter  YLOG_DEBUG
log set module loglevel switch_hal  YLOG_DEBUG
```
## dot.1x debug trace

```bash
cd /isam/slot_default/dot1x_protocol_app/run && calamares -cnt tty1_ext
-------------------------------------------------
log set module loglevel OHMLOG YLOG_DEBUG
log set module loglevel dot1x YLOG_DEBUG
log set module loglevel yproto YLOG_DEBUG
log set module loglevel DOT1X YLOG_DEBUG
log set output loglevel LOGFILE YLOG_DEBUG
log set output loglevel CONSOLE YLOG_DEBUG
log set output max_entries 0 1000000
log set output max_files 0 10
----------------------------------------------------------------
```

## eodb debug trace
```bash
cd /isam/slot_default/extodb_app/run && calamares -cnt tty1_ext
-------------------------------------------------
log set output loglevel LOGFILE YLOG_DEBUG
log set output loglevel CONSOLE YLOG_DEBUG
log set module loglevel EXTODBBBB YLOG_DEBUG
log set module loglevel extodbsys YLOG_DEBUG
log set module loglevel EXTODBSY YLOG_DEBUG
log set output max_entries 0 1000000
log set output max_files 0 10
----------------------------------------------------------------
```

## mirror debug trace
```bash
#mirror packet
log set output loglevel CONSOLE YLOG_DEBUG
log set output loglevel LOGFILE YLOG_DEBUG
log set module loglevel hh YLOG_DEBUG

hh ta deallocate all
//hh ta allocate ds egress trace iwf_id=0            //upstream egress from LT to NT
hh ta allocate us ingress trace iwf_id=0
hh ta allocateRule iwf_id=0 ta_id=2                //!!!!!ta_id used the return value of the hh ta allocate us egress trace iwf_id=0
hh ta setFilter iwf_id=0 ta_id=2 rule_id=0 vid=100 //filter rules, you can use vid or smac,dmac....  !!!!rule_id=0 used the return value of the UPPER command
hh ta setFilter iwf_id=0 ta_id=2 rule_id=0 dst-mac=00:33:00:00:00:03 //filter rules, you can use vid or smac,dmac....  !!!!rule_id=0 used the return value of the UPPER command
hh ta dumpRule iwf_id=0 ta_id=2 rule_id=0
hh ta start iwf_id=0 ta_id=2
hh trace on packet

```
## msg handler recorder
```bash
mh gpb_record enable all
mh gpb_record max_size 300000
mh gpb_record save json
```

