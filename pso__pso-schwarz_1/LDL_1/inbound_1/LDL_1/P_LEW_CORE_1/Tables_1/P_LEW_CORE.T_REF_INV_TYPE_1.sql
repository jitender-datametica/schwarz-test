/* --------------------------------------------------------------------------------
   DDL for table: t_ref_inv_type_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_INV_TYPE_1 (
   inv_type_id                         NUMBER(38,0)     NOT NULL COMMENT 'id of the general inventory type, includes types for stock correction count requests',
   inv_type_descr                      VARCHAR(100)     NOT NULL COMMENT 'description of the general inventory type, includes types for stock correction count requests',
   inv_type_descr_en                   VARCHAR(100)     NOT NULL COMMENT 'english description of the general inventory type, includes types for stock correction count requests',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_INV_TYPE PRIMARY KEY (inv_type_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. general inventory type, includes types for stock correction count requests;
             Source: static reference, possible values in WAWI field C438_INV_TYPE';

