--==============================================================
-- Table: flw_art_marktpreis_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_marktpreis_per_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_marktpreis_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeit aus gtvon'),
flw_version_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='myMEAT Version zur Marktpreisermittlung aus versi'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeit aus gtbis'),
bruttopreis NUMERIC(18,4) NOT NULL OPTIONS(description='Preis aus brprs'),
menge NUMERIC(18,3) NOT NULL OPTIONS(description='Menge aus menge'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
dat_aenderung DATE NOT NULL
OPTIONS(description='Datum der Änderung aus updat. Dient als Bezugsdatum der Kursumrechnung'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
nettopreis NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Nettopreis aus ntprs'),
nicht_relevant_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag legt fest, ob der Datensatz für die Auswertung relevant ist. Der Input kommt aus den SAP Tabellen spmeat_mpe_mozk und spmeat_mpe_zmop, die selbst nicht ins Datenmodell integriert werden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, werk_id, dat_von, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - myMEAT MPE: Marktpreis aus spmeat_mpe_mprs');