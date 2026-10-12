--==============================================================
-- Table: l_hydra_zeitart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_zeitart
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:15:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_hydra_zeitart (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
zeitart_id STRING(3) NOT NULL OPTIONS(description='Zeitart, z.B. GRP , ZL'),
zeitart_bez STRING(30) OPTIONS(description='Bezeichnung der Zeitart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zeitart_id) NOT ENFORCED
)
OPTIONS(description='Work Performance measurement type -  group, individual             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table');