/* --------------------------------------------------------------------------------
   DDL for table: t_ref_building_purchase_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_BUILDING_PURCHASE_TYPE_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   purchase_type_id                    NUMBER(38,0)     NOT NULL COMMENT 'purchase type code',
   purchase_type_descr                 VARCHAR(100)     COLLATE 'en-ci' COMMENT 'purchase type description;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_BUILDING_PURCHASE_TYPE PRIMARY KEY (client_id, purchase_type_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Description of how the rigth of owning the building is purchased (buying, renting, leasing)';

