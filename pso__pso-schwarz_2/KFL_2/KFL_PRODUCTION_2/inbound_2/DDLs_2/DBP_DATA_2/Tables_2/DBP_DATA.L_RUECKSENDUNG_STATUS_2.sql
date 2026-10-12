--==============================================================
-- Table: l_ruecksendung_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ruecksendung_status_2
   generated from Powerdesigner on Freitag, 22. November 2024 11:03:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_RUECKSENDUNG_STATUS_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   ruecksendung_status_id              NUMBER(38,0)     NOT NULL COMMENT 'Status_2 der Rücklieferung: 0 = vom System angelegt, 1 = in Bearbeitung, 2 = abgeschlossen (erfasst und freigegeben), 3 = RL-Datum kritisch, 4 = Zwangsabschluss.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_RUECKSENDUNG_STATUS PRIMARY KEY (mandant_id, ruecksendung_status_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für den Status_2 der Rücksendung.';
