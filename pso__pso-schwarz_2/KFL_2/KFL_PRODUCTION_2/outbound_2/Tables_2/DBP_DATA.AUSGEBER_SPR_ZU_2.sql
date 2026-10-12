--==============================================================
-- Table: ausgeber_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausgeber_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ausgeber_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Ausgebers, es gibt KDC, TIP und Filiale'),
ausgeber_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichnung des Gutschein_2-Ausgebers (Seller), z.Bsp. TIP001'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Sprache'),
ausgeber_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Gutschein_2-Ausgebers, z.Bsp. Kulanz. Bei einer Filiale die Filialbezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Bezeichnung der Gutscheinausgeber (Seller)');