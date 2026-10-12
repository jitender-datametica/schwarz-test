--==============================================================
-- Table: t_fact_iot_errormessages_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_iot_errormessages_2
   generated from Powerdesigner on Mittwoch, 2. November 2022 16:57:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.T_FACT_IOT_ERRORMESSAGES_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 ID',
   wup_id                              INTEGER    NOT NULL COMMENT 'Marktnummer 4-stellig',
   device_id                           VARCHAR(50)     NOT NULL COMMENT 'Geraetenummer des Sensors',
   fault_nr                            VARCHAR(30)     NOT NULL COMMENT 'Fehlernummer der Stoermeldung',
   cal_dt                              DATE            NOT NULL COMMENT 'Datum der Stoermeldung',
   measurement_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of measurement',
   device_type_id                      VARCHAR(10)     COMMENT 'Geraetetyp',
   alarm_priority_cd                   INTEGER    COMMENT 'Prioritaet der Stoermeldung von 0 bis 4. 0 = Systemmeldung; 1 = höchste Prioritaet; 4 = niedrigste Prioritaet',
   error_source                        VARCHAR(50)     COMMENT 'Name der Quelle, in der ein Fehler aufgetreten ist',
   error_message                       VARCHAR(100)    COMMENT 'Art_2 der aufgetretenen Stoerung',
   value_cycling                       INTEGER    COMMENT 'Anzahl aufgetretene Stoerung. 0 = 1 Stoerung. N = n+1 Stoerungen',
   active_fg                           INTEGER    COMMENT 'Flag, welcher aussagt, ob eine_2 Fehlermeldung aktiv ist oder nicht: 0 = existing error active, 1 = error not active (anymore)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_T_FACT_IOT_ERRORMESSAGES PRIMARY KEY (mandant_id, wup_id, device_id, fault_nr, cal_dt, measurement_tmsp) NOT ENFORCED
)  COMMENT = 'Tabelle für Stoermeldungen von IOT-Geraeten';
