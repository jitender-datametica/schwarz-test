--==============================================================
-- Table: avq_aktualisierung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: avq_aktualisierung
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AVQ_AKTUALISIERUNG (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   kjwo                                NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   dat_letzte_aktualisierung           TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten AVQ Aktualisierung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AVQ_AKTUALISIERUNG PRIMARY KEY (mandant_id, kjwo) NOT ENFORCED
)  COMMENT = 'SCM - enthält den Zeitstempel der letzten AVQ Aktualisierung';

