--==============================================================
-- Table: l_ruecksendung_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ruecksendung_status
   generated from Powerdesigner on Freitag, 22. November 2024 11:03:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ruecksendung_status (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ruecksendung_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status der Rücklieferung: 0 = vom System angelegt, 1 = in Bearbeitung, 2 = abgeschlossen (erfasst und freigegeben), 3 = RL-Datum kritisch, 4 = Zwangsabschluss.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ruecksendung_status_id) NOT ENFORCED
) OPTIONS(description='Lookup-Tabelle für den Status der Rücksendung.');