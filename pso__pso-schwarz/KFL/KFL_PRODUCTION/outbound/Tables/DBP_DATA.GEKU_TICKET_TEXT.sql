--==============================================================
-- Table: geku_ticket_text
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_ticket_text
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_ticket_text (
geku_ticket_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines GEKU Tickets aus case_nr'),
textart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID für die Art des Textes, z.Bsp. Kommentar, Kommentar übersetzt.'),
text STRING(10000) COLLATE 'und:ci'
OPTIONS(description='zu dem Ticket gehörender Text, z.Bsp. Beschwerde, Antworttext etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_ticket_id, textart_id) NOT ENFORCED
) OPTIONS(description='GEKU - die Texte zu den Tickets sind in diese separate Tabelle ausgelagert');