--==============================================================
-- Table: l_nachschub_option
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_nachschub_option
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_nachschub_option (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
nachschub_option_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nachschub Option ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Nachschub Option Lookup');