--==============================================================
-- Table: l_hydra_taetigkeit_int_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_taetigkeit_int_2
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:12:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_hydra_taetigkeit_int_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
taetigkeit_int_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Internationale Tätigkeit ID ( International/group Activity Type code)'),
taetigkeit_int_bez STRING(30) OPTIONS(description='Internationale Bezeichnung der Tätigkeit (description of the code)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, taetigkeit_int_id) NOT ENFORCED
)
OPTIONS(description='Internetional/Group code for the Activity Type. Every warehouse has it\'s own local  Activity Types ( hydra_taetigkeit_zu_2 ),  There for every local code we have which is the corresponding group code.             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table');