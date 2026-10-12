--==============================================================
-- Table: ginfo_flaeche_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_flaeche_typ_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ginfo_flaeche_typ_spr_zu_2 (
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ der Flaeche'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.'),
flaeche_quelle_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flaechendaten kommen aus drei Quellen. 1 = Grundstuecks-, 2 = Immobilien-, 3 = Handelsflaechen'),
ginfo_flaeche_typ_bez STRING(100) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Flächentyps'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, flaeche_quelle_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnung der Flächentypen');