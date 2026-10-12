--==============================================================
-- Table: annahmeverweigerung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: annahmeverweigerung_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.annahmeverweigerung_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
annahmeverweigerung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen für den Annahmeverweigerungsgrund            '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
annahmeverweigerung_bez STRING(30) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Grundes aus der Quelle text, z.Bsp. EAN_1 fehlt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, annahmeverweigerung_id, spr_id) NOT ENFORCED
) OPTIONS(description='LIS -Sprachabhängige Bezeichnungen der Gründe für die Annahmeverweigerung aus SAP PRL ZLV_AVG');