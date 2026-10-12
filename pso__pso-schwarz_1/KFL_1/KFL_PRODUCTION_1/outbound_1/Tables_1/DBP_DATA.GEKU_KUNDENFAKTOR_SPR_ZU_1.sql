--==============================================================
-- Table: geku_kundenfaktor_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_kundenfaktor_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_kundenfaktor_spr_zu_1 (
kundenfaktor_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID des Kundenfaktors, aktuell zwischen 1 und 27'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
kf_kommentar STRING(255) COLLATE 'und:ci'
OPTIONS(description='Kommentar zum Kundenfaktor, z.Bsp. "Gebäude, Flächen, Betriebssicherheit"'),
kf_bez STRING(255) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Kundenfaktors, z.Bsp. "Sicherheit"'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kundenfaktor_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der Kundenfaktoren aus dem GeKu-Plakat - "manuelle SST"');