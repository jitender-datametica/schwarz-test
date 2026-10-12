--==============================================================
-- Table: platzierungswg_vs_sm_verkaufsmoebel_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: platzierungswg_vs_sm_verkaufsmoebel_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:47:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.platzierungswg_vs_sm_verkaufsmoebel_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
platzierungswg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'),
vs_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Vertriebsschiene'),
sm_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sortimentsmodul ID. Gibt die Sortimentsgröße an.'),
verkaufsmoebel_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Verkaufsmöbels - Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel in der Filiale verkauft werden.'),
menge_soll_flaeche BIGNUMERIC(38,3) OPTIONS(description='Gibt die Soll-Größe der Verkaufsfläche an.'),
flaeche_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Einheit der Soll-Größe der Verkaufsfläche.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, platzierungswg_id, verkaufsmoebel_id, sm_id, vs_id) NOT ENFORCED
)
OPTIONS(description='Zuordnung von Platzierungswarengruppe zu den Sortimentsgrößen, Verkaufsmöbel und den einzelnen Vertriebsregionen.');