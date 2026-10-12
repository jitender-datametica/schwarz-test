--==============================================================
-- Table: nachschub_option_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nachschub_option_spr_zu_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:59:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nachschub_option_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache SPRACHSCHLÜSSEL'),
nachschub_option_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nachschub Option ID'),
nachschub_option_bez STRING(60) OPTIONS(description='Nachschub Option Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Nachschub Option Bezeichnung');