--==============================================================
-- Table: belos_tourstatus_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_tourstatus_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_tourstatus_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
belos_tourstatus_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Tourstatus. Unterscheidet, ob im System angelegt, gesendet oder abgerechnet'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.            '),
belos_tourstatus_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, belos_tourstatus_id, spr_id) NOT ENFORCED
) OPTIONS(description='LIS - Sprachabhängige Bezeichnung der Tourstati. Initial befüllt - keine Versorgung vorgesehen.');