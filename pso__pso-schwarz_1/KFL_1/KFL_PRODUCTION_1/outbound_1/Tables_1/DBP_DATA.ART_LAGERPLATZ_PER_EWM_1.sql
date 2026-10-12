--==============================================================
-- Table: art_lagerplatz_per_ewm_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_lagerplatz_per_ewm_1
   generated from Powerdesigner on Mittwoch, 23. März 2022 10:04:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_lagerplatz_per_ewm_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
art_guid STRING(32) NOT NULL OPTIONS(description='Product'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
lagerplatz_id STRING(18) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie (hier abweichend UTF9 aufgrund von evtl. fehlerhafter Pflege in SAP)'),
dat_von DATE NOT NULL OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gültig (von)'),
art_id BIGNUMERIC(38,0) OPTIONS(description='Artikelnummer       '),
dat_bis DATE OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gültig (bis)'),
lagertyp_id STRING(4) COLLATE 'und:ci' OPTIONS(description='ID des Lagertyps. Zweite Ebene der Lagerhierarchie'),
menge_max NUMERIC(15,3) OPTIONS(description='Maximalmenge'),
menge_max_einh_id STRING(3) OPTIONS(description='Anzeige Mengeneinheit für Maximalmenge'),
menge_min NUMERIC(15,3) OPTIONS(description='Maximalmenge'),
menge_min_einh_id STRING(3) OPTIONS(description='Anzeige Mengeneinheit für Minimalmenge'),
menge_fixiert_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Minimal-/Maximal-/Nachschubmenge fixiert flag'),
menge_min_direkt NUMERIC(15,3) OPTIONS(description='Mindestmenge für die Direkteinlagerung'),
menge_min_direkt_einh_id STRING(3) OPTIONS(description='Mengeneinheit der Mindestmenge für die Einlagerung'),
datzeit_aenderung TIMESTAMP OPTIONS(description='LSTC = last change?'),
tr_fg BIGNUMERIC(38,0) OPTIONS(description='Tagesrenner Griffzone'),
tkl_fg BIGNUMERIC(38,0) OPTIONS(description='TKL Prozess'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_guid, wup_id, nb_id, dat_von) NOT ENFORCED
) OPTIONS(description='Materialdaten pro Lagertyp');