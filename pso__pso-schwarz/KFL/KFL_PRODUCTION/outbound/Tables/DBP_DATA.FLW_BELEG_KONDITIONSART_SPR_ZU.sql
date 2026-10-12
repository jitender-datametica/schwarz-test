--==============================================================
-- Table: flw_beleg_konditionsart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_beleg_konditionsart_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_beleg_konditionsart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
beleg_konditionsart_id STRING(4) NOT NULL OPTIONS(description='Konditionsart aus kschl'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
beleg_konditionsart_bez STRING(20) DEFAULT ' ' NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, beleg_konditionsart_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Belegkalkulationsart - SAP P21 T685T');