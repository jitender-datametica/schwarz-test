--==============================================================
-- Table: fipo_bereich_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_bereich_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_bereich_spr_zu (
fipo_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fipo_bereich_bez STRING(60) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des FIPO-Bereichs, z.Bsp. Frische'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_bereich_id, spr_id) NOT ENFORCED
) OPTIONS(description='FIPO - Sprachabhängige Bezeichnungen der FIPO-Bereiche');