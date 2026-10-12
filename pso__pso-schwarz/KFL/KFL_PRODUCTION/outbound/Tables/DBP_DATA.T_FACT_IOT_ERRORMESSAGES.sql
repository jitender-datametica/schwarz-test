--==============================================================
-- Table: t_fact_iot_errormessages
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_iot_errormessages
   generated from Powerdesigner on Mittwoch, 2. November 2022 16:57:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.t_fact_iot_errormessages (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant ID'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer 4-stellig'),
device_id STRING(50) NOT NULL OPTIONS(description='Geraetenummer des Sensors'),
fault_nr STRING(30) NOT NULL OPTIONS(description='Fehlernummer der Stoermeldung'),
cal_dt DATE NOT NULL OPTIONS(description='Datum der Stoermeldung'),
measurement_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of measurement'),
device_type_id STRING(10) OPTIONS(description='Geraetetyp'),
alarm_priority_cd BIGNUMERIC(38,0)
OPTIONS(description='Prioritaet der Stoermeldung von 0 bis 4. 0 = Systemmeldung; 1 = höchste Prioritaet; 4 = niedrigste Prioritaet'),
error_source STRING(50) OPTIONS(description='Name der Quelle, in der ein Fehler aufgetreten ist'),
error_message STRING(100) OPTIONS(description='Art der aufgetretenen Stoerung'),
value_cycling BIGNUMERIC(38,0) OPTIONS(description='Anzahl aufgetretene Stoerung. 0 = 1 Stoerung. N = n+1 Stoerungen'),
active_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag, welcher aussagt, ob eine Fehlermeldung aktiv ist oder nicht: 0 = existing error active, 1 = error not active (anymore)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, device_id, fault_nr, cal_dt, measurement_tmsp) NOT ENFORCED
) OPTIONS(description='Tabelle für Stoermeldungen von IOT-Geraeten');