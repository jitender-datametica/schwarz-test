/* --------------------------------------------------------------------------------
   DDL for table: t_ref_store_group_relation_type
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_STORE_GROUP_RELATION_TYPE (
   store_grp_rel_type_cd               VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'The discriminator code for store group relations.',
   store_grp_rel_type_descr            VARCHAR(100)     COLLATE 'en-ci' COMMENT 'A textual description for the discriminator for store group relations.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_STORE_GROUP_RELATION_TYPE PRIMARY KEY (store_grp_rel_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the way how / the reason why two store groups are related to each other.';

