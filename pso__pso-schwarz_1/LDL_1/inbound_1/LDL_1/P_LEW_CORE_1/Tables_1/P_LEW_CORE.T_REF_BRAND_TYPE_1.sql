/* --------------------------------------------------------------------------------
   DDL for table: t_ref_brand_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_BRAND_TYPE_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'FK MDM Client;
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);',
   brand_type_cd                       VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'PK Brand_1 Type;',
   brand_type                          VARCHAR(100)     COMMENT 'Brand_1 Type;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_BRAND_TYPE PRIMARY KEY (brand_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Brand_1 Type;
             Static data:
             M: Marke
             EM: Eigenmarke';

