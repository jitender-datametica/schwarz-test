/* --------------------------------------------------------------------------------
   DDL for table: t_ref_ident_type_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_IDENT_TYPE_2 (
   context_name                        VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Different context names like customer,supplier_2,store_manager,account_2 manager',
   ident_type_cd                       VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Code for identity provided by the context',
   ident_type_descr                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Description of identity provided by context ex: digital card, phone number, null if its not known',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_IDENT_TYPE PRIMARY KEY (context_name, ident_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 10062 $. Provides indentity type for diffrent context';

