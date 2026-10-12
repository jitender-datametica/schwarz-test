--==============================================================
-- Table: flw_art_lief_mpe_plan_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_lief_mpe_plan_per
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_lief_mpe_plan_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeit aus gtvon'),
flw_version_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='myMEAT Version zur Marktpreisermittlung aus versi'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeit aus gtbis'),
bruttopreis NUMERIC(18,4) NOT NULL OPTIONS(description='Bruttopreis aus brprs'),
menge NUMERIC(18,3) NOT NULL OPTIONS(description='Menge aus menge'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
nettopreis NUMERIC(18,4) NOT NULL OPTIONS(description='Nettopreis aus ntprs'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, flw_lief_id, werk_id, dat_von, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - myMEAT MPE: Planpreise aus spmeat_mpe_plan');