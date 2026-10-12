/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_telegram_temp_1
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_sapewm_telegram_temp_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
mandt STRING(3) OPTIONS(description='Client'),
lgnum STRING(4) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
plc STRING(8) OPTIONS(description='Programmable Logic Controller'),
channel STRING(1) OPTIONS(description='Communication_1 Channel for PLC'),
ts_date DATE OPTIONS(description='Date of Telegram'),
ts_time TIME OPTIONS(description='Time of Telegram'),
ts_time_ms BIGNUMERIC(38,0) OPTIONS(description='Milliseconds of Telegram'),
timestamp DATETIME NOT NULL OPTIONS(description='UTC Time Stamp in Long Form (YYYYMMDDhhmmssmmmuuun)'),
sender STRING(8) OPTIONS(description='Sender'),
receiver STRING(8) OPTIONS(description='Recipient(s)'),
cp STRING(18) OPTIONS(description='Communication_1 Point for Conveyor Technique'),
handshake STRING(2) OPTIONS(description='Telegram Handshake (Request or Confirmation)'),
sequ_no BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Telegram Sequence Number'),
comm_error STRING(4) OPTIONS(description='Error During Telegram Communication_1'),
teletype STRING(4) NOT NULL OPTIONS(description='Telegram Type'),
action STRING(2) OPTIONS(description='Action'),
huident STRING(20) NOT NULL OPTIONS(description='Handling Unit_1 Identification'),
source STRING(18) OPTIONS(description='Source Location_1 for Movements in MFS Environment'),
dest STRING(18) OPTIONS(description='Destination Location_1 for Movements in MFS Environment'),
direction STRING(1) OPTIONS(description='Displays the Telegram Flow Direction'),
msg STRING(1000) OPTIONS(description='Telegram'),
msg1 STRING(100) OPTIONS(description='Telegram Only 100 Characters (UI)'),
msg2 STRING(100) OPTIONS(description='Telegram Only 100 Characters (UI)'),
msg3 STRING(55) OPTIONS(description='Telegram Only 55 Characters (UI)'),
msg_len BIGNUMERIC(38,0) OPTIONS(description='Telegram Character Length'),
mfs_error STRING(4) OPTIONS(description='Error in Telegram'),
tanum BIGNUMERIC(38,0) OPTIONS(description='Warehouse Task'),
who BIGNUMERIC(38,0) OPTIONS(description='Warehouse Order Number'),
hndshk_perf BIGNUMERIC(38,0) OPTIONS(description='Handshake Performance (Milliseconds)'),
ewm_follup_perf BIGNUMERIC(38,0) OPTIONS(description='SAP EWM Follow-Up Telegram Performance (Milliseconds)'),
plc_follup_perf BIGNUMERIC(38,0) OPTIONS(description='PLC Follow-Up Telegram Performance (Milliseconds)'),
dummy_mfstelelog STRING(1) OPTIONS(description='Dummy_1 function in length 1'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, timestamp, teletype, huident, sequ_no) NOT ENFORCED
) OPTIONS(description='SAP EWM - Logging of Telegram Flow & Convert Timestamp');