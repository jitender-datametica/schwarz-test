--==============================================================
-- Table: l_hydra_taetigkeit_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_taetigkeit_typ_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:12:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_hydra_taetigkeit_typ_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
taetigkeit_typ_id STRING(1) NOT NULL
OPTIONS(description='BDE Verarbeitung der Tätigkeit ;Z=Zeitlohn ;D=Durchschnitt (code for activity payment type'),
taetigkeit_typ_bez STRING(30)
OPTIONS(description='Bezeichnung der BDE-Verarbeitung (description of the activity payment type'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, taetigkeit_typ_id) NOT ENFORCED
)
OPTIONS(description='hydra_taetigkeit_typ describes how it is paid for a certain activity - Per hour, per piece of work done ...             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table');