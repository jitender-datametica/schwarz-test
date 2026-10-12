/* --------------------------------------------------------------------------------
   DDL for table: t_store_group_relation_hist_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_STORE_GROUP_RELATION_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   store_grp_sid                       NUMBER(38,0)     NOT NULL COMMENT 'surrogate key that uniquely identifies a store group',
   store_grp_sid_rel                   NUMBER(38,0)     NOT NULL COMMENT 'surrogate key that uniquely identifies a store group that is related to the other store group',
   store_grp_rel_type_cd               VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'The discriminator code for store group relations.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_STORE_GROUP_RELATION_HIST PRIMARY KEY (store_grp_sid, store_grp_sid_rel, store_grp_rel_type_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'dummy_2 comment to avoid sonarcube error';

