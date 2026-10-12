--==============================================================
-- Table: geku_ticket_text_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_ticket_text_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_TICKET_TEXT_2 (
   geku_ticket_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID eines GEKU Tickets aus case_nr',
   textart_id                          INTEGER     NOT NULL COMMENT 'ID für die Art_2 des Textes, z.Bsp. Kommentar, Kommentar übersetzt.',
   TEXT                                VARCHAR(10000)   COLLATE 'en-ci' COMMENT 'zu dem Ticket gehörender Text, z.Bsp. Beschwerde, Antworttext etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_TICKET_TEXT PRIMARY KEY (geku_ticket_id, textart_id) NOT ENFORCED
)  COMMENT = 'GEKU - die Texte zu den Tickets sind in diese separate Tabelle ausgelagert';
