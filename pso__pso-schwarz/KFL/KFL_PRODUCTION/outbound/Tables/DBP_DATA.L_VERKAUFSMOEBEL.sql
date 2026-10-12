--==============================================================
-- Table: l_verkaufsmoebel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verkaufsmoebel
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:52:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_verkaufsmoebel (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
verkaufsmoebel_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Verkaufsmöbels - Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel in der Filiale verkauft werden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, verkaufsmoebel_id) NOT ENFORCED
)
OPTIONS(description='Beinhaltet alle möglichen Verkaufsmöbel die eine Filiale nutzen kann. Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel in der Filiale verkauft werden.');