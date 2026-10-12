--==============================================================
-- Table: l_angebot_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_angebot_status_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:49:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_angebot_status_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
angebot_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Angebotstatus'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_status_id) NOT ENFORCED
) OPTIONS(description='Lookuptabelle der möglichen Status_1 des Angebots.');