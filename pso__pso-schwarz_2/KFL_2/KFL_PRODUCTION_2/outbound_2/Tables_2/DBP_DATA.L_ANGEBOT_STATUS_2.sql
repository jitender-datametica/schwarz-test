--==============================================================
-- Table: l_angebot_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_angebot_status_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:49:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_angebot_status_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
angebot_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Angebotstatus'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_status_id) NOT ENFORCED
) OPTIONS(description='Lookuptabelle der möglichen Status_2 des Angebots.');