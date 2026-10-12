/* --------------------------------------------------------------------------------
   DDL for table: t_ref_store_group_relation_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_store_group_relation_type_1 (
store_grp_rel_type_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='The discriminator code for store group relations.'),
store_grp_rel_type_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='A textual description for the discriminator for store group relations.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
)
OPTIONS(description='This minor entity defines the way how / the reason why two store groups are related to each other.');