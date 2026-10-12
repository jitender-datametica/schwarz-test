--==============================================================
-- Table: geku_gebiets_betreuer_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_gebiets_betreuer_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_gebiets_betreuer_2 (
gebiets_betreuer_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Gebietsbetreuers'),
fv_fg BIGNUMERIC(38,0) OPTIONS(description='Flag für Eigen/Fremdverteilung. Wert = 1 ist FV'),
fv_gb_id STRING(60) COLLATE 'und:ci' OPTIONS(description='ID FV / GB aus NILS aus fv_gb_id'),
gbb_name STRING(60) COLLATE 'und:ci' OPTIONS(description='(Nach)name des Gebietsbetreuers aus fv_gb_id'),
gbb_vorname STRING(60) COLLATE 'und:ci' OPTIONS(description='Vorname des Gebietsbetreuers aus vorname'),
gbb_anrede STRING(60) COLLATE 'und:ci' OPTIONS(description='Anrede des Gebietsbetreuers aus text_out.salutation_uid'),
gbb_strasse STRING(60) COLLATE 'und:ci' OPTIONS(description='Strasse des Gebietsbetreuers aus street'),
gbb_plz STRING(60) COLLATE 'und:ci' OPTIONS(description='Postleitzahl des Gebietsbetreuers plz'),
gbb_ort STRING(60) COLLATE 'und:ci' OPTIONS(description='Standort des Gebietsbetreuers aus stadt'),
gbb_land_id STRING(2) COLLATE 'und:ci' OPTIONS(description='Land_2 des Gebietsbetreuers'),
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant_2 im DWH'),
gbb_email STRING(250) COLLATE 'und:ci' OPTIONS(description='email_Adresse des Gebietsbetreuers aus email'),
gbb_tel_mobil STRING(60) COLLATE 'und:ci' OPTIONS(description='Mobilnummer des Gebietsbetreuers aus tel_mobil'),
gbb_telefon STRING(60) COLLATE 'und:ci' OPTIONS(description='Telefonnummer des Gebietsbetreuers  aus telefon'),
gbb_fax STRING(60) COLLATE 'und:ci' OPTIONS(description='Faxnummer des Gebietsbetreuers aus fax'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gebiets_betreuer_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Gebietsbetreuer-Stammdaten aus der Tabelle wmd_area_responsibles');