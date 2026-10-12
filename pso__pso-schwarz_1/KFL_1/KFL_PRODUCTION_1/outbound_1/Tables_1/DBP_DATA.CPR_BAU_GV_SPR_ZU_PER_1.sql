--==============================================================
-- Table: cpr_bau_gv_spr_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_bau_gv_spr_zu_per_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_bau_gv_spr_zu_per_1 (
projekt_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID des Projekts'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
bau_gv_dok_id STRING(32) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige GUID des Dokuments aus der Quelle zz_dpr_document.dpr_tv_guid'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
dokument_bez STRING(255) COLLATE 'und:ci' OPTIONS(description='Dokumententext aus document_text'),
dokument_bez_lang STRING(255) COLLATE 'und:ci' OPTIONS(description='Dokumentenbeschreibung aus document_descr'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von, spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnungen zu den Baugenehmigungen aus dpr_document_t');