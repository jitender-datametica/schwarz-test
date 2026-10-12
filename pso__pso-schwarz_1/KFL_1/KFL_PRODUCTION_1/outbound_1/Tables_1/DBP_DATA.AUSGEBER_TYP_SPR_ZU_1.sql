--==============================================================
-- Table: ausgeber_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausgeber_typ_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ausgeber_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Ausgebers, es gibt z. Bsp. KDC, TIP und Filiale'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Sprache'),
ausgeber_typ_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Ausgebertypen, z.Bsp. TIP'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - sprachabhängige Bezeichnungen der Ausgebertypen');