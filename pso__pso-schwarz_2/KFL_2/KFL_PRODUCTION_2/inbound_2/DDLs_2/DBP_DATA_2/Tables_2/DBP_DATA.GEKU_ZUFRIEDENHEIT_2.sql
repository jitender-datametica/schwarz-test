--==============================================================
-- Table: geku_zufriedenheit_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_zufriedenheit_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_ZUFRIEDENHEIT_2 (
   geku_ticket_id                      NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID eines GEKU Tickets aus case_nr',
   geku_notenvergabe_durch_id          NUMBER(18,0)     NOT NULL COMMENT 'ID der Notenvergeber',
   note_problem_geloest                NUMBER(38,0)     COMMENT 'Note für die Lösung des Problems',
   note_bearbeitungszeit               NUMBER(38,0)     COMMENT 'Note für die Bearbeitungszeit (Schulnote) aus performance_rate',
   note_freundlichkeit                 NUMBER(38,0)     COMMENT 'Note für die Freundlichkeit (Schulnote) aus response_rate',
   note_inhalt                         NUMBER(38,0)     COMMENT 'Note für den Inhalt (Schulnote) aus explain_rate',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_ZUFRIEDENHEIT PRIMARY KEY (geku_ticket_id, geku_notenvergabe_durch_id) NOT ENFORCED
)  COMMENT = 'GEKU - Zufriedenheitsergebnisse aus satisfaction_out - MULTISET';
