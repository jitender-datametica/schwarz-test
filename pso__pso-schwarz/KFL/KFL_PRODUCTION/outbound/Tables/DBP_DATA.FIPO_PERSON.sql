--==============================================================
-- Table: fipo_person
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_person
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_person (
fipo_person_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID der Person aus prs_id'),
mandant_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL OPTIONS(description='Mandant im DWH'),
fipo_pos_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID einer FIPO-Position aus dem Quellfeld pos_id'),
rev_fb_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Revisions-Fachbereichs aus rfb_id'),
fipo_person_name STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Nachname der Person aus prs_name'),
fipo_person_vorname STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Vorname der Person aus prs_vorname'),
fipo_person_anrede STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Anrede der Person z.Bsp. Herr aus prs_anrede'),
dat_bis DATE NOT NULL
OPTIONS(description='Austrittsdatum der Perso aus prs_endedatum. Bei aktiven Personen der 31.12.9999'),
fipo_person_organisation STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='ORGANISATION - Zuordnung der Person zu einer Gruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_person_id) NOT ENFORCED
) OPTIONS(description='FIPO - Tabelle der FIPO-Personen aus der Quelle personen');