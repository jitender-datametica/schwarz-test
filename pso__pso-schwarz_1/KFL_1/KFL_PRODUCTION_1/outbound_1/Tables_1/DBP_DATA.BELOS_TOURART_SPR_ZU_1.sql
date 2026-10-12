--==============================================================
-- Table: belos_tourart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_tourart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_tourart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
belos_tourart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Tourarten, z.Bsp. Filialbelieferung, Shuttle'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.            '),
belos_tourart_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Tourart, z.Bsp. Shuttle'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, belos_tourart_id, spr_id) NOT ENFORCED
)
OPTIONS(description='LIS - Sprachabhängige Bezeichnungen der Tourarten. Initial befüllt - keine Versorgung vorgesehen.');