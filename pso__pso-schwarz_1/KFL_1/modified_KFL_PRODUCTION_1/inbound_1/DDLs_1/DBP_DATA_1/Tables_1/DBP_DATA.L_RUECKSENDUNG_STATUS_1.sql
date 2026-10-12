--==============================================================
-- Table: l_ruecksendung_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ruecksendung_status_1
   generated from Powerdesigner on Freitag, 22. November 2024 11:03:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_RUECKSENDUNG_STATUS_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   ruecksendung_status_id              INTEGER     NOT NULL COMMENT 'Status_1 der Rücklieferung: 0 = vom System angelegt, 1 = in Bearbeitung, 2 = abgeschlossen (erfasst und freigegeben), 3 = RL-Datum kritisch, 4 = Zwangsabschluss.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_RUECKSENDUNG_STATUS PRIMARY KEY (mandant_id, ruecksendung_status_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für den Status_1 der Rücksendung.';
