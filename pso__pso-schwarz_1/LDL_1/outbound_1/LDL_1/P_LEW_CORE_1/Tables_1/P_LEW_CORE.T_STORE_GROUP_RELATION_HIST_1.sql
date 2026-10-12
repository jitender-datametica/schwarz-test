/* --------------------------------------------------------------------------------
   DDL for table: t_store_group_relation_hist_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_store_group_relation_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
store_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key that uniquely identifies a store group'),
store_grp_sid_rel BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key that uniquely identifies a store group that is related to the other store group'),
store_grp_rel_type_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='The discriminator code for store group relations.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (store_grp_sid, store_grp_sid_rel, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='dummy_1 comment to avoid sonarcube error');