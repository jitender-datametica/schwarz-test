--==============================================================
-- Table: geku_zufriedenheit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_zufriedenheit
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_zufriedenheit (
geku_ticket_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines GEKU Tickets aus case_nr'),
geku_notenvergabe_durch_id INTEGER NOT NULL OPTIONS(description='ID der Notenvergeber'),
note_problem_geloest BIGNUMERIC(38,0) OPTIONS(description='Note für die Lösung des Problems'),
note_bearbeitungszeit BIGNUMERIC(38,0)
OPTIONS(description='Note für die Bearbeitungszeit (Schulnote) aus performance_rate'),
note_freundlichkeit BIGNUMERIC(38,0) OPTIONS(description='Note für die Freundlichkeit (Schulnote) aus response_rate'),
note_inhalt BIGNUMERIC(38,0) OPTIONS(description='Note für den Inhalt (Schulnote) aus explain_rate'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_ticket_id, geku_notenvergabe_durch_id) NOT ENFORCED
) OPTIONS(description='GEKU - Zufriedenheitsergebnisse aus satisfaction_out - MULTISET');