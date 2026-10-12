--==============================================================
-- Table: platzierungswg_wup_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: platzierungswg_wup_zu_1
   generated from Powerdesigner on Donnerstag, 8. Mai 2025 23:24:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.platzierungswg_wup_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
platzierungswg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID Warenumschlagsplatz, ID der Filiale.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
sm_id BIGNUMERIC(38,0)
OPTIONS(description='Sortimentsmodul ID. Gibt die Sortimentsgröße der Platzierungswarengruppe in der Filiale an.'),
anz_artikel BIGNUMERIC(38,0)
OPTIONS(description='Gibt die Anzahl der Artikel_1 in der Filiale für die Platzierungswarengruppe an.'),
menge_soll_flaeche_regio BIGNUMERIC(38,3)
OPTIONS(description='Gibt die SOLL-Größe der Verkaufsflächen rein regionaler Sortimente an.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, platzierungswg_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='Zuordnungen der Platzierungswarengruppe zur Filiale.');