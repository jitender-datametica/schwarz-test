--==============================================================
-- Table: ruecksendung_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ruecksendung_typ_spr_zu_1
   generated from Powerdesigner on Mittwoch, 26. Juni 2024 13:53:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ruecksendung_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ruecksendung_typ_kz STRING(4) NOT NULL OPTIONS(description='Code für die Art_1 der Rücksendung.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
ruecksendung_typ_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Retourenart eines von der Filiale zurückgegebenen Artikels in unterschiedlichen Sprachen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ruecksendung_typ_kz, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnung des Rücksendungstypen');