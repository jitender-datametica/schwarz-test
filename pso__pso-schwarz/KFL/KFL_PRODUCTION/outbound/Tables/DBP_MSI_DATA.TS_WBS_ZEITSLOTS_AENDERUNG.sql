--==============================================================
-- Table: ts_wbs_zeitslots_aenderung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_zeitslots_aenderung
   generated from Powerdesigner on Wednesday, August 24, 2022 12:57:02 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wbs_zeitslots_aenderung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
auslieferungsgruppe_id STRING(4) NOT NULL
OPTIONS(description='ID der Auslieferungsgruppe. Eine Auslieferungsgruppe (manchmal auch Ausliefergruppe) ist eine Buendelung von Artikeln mit gleichen Eigenschaften Aufgrund welchen sie zusammen ausgeliefert werden koennen, VZ in Richtung Filiale. Z.B.: Food Trocken (Mehl, Konserven, Nudeln), Tiefkuehlware (Fisch, Pizza, Eis, Tiefkuehlgemuese), etc.'),
dat DATE NOT NULL OPTIONS(description='Datum fuer das die Aenderung im Processboard gilt.'),
zeitslot_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Zeitslots fuer die Kalkulation und Bestellung von zusaetzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zeitslot_id, auslieferungsgruppe_id, dat) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - This table saves the changes made by users in MSI processboard to the standard time slots (zeitslot_id) in table wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu. Changes are for a date (dat), client (mandant_id) and delivery group (auslieferungsgruppe_id). Users can only pick from the list of available options that are stored in table wbs_l_mandant_zeitslots. Each subsequent time slot change overwrites the last setting while choosing the standard again deletes the entry.');