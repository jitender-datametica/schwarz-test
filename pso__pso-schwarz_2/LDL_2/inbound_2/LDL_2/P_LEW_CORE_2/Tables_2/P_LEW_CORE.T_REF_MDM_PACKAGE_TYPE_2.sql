/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_package_type_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:45:59
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_PACKAGE_TYPE_2 (
   package_type_cd                     VARCHAR(100)     NOT NULL COMMENT 'NFPO outer package_2 type codes for items
            CBX:  CNT_CODELIST.CODE, code list ''LIDL_PACKAGETYPE''',
   package_type_name                   VARCHAR(100)     COMMENT 'NFPO outer package_2 type names for items (NETZ/TOPF/BOX usw.)
            CBX:  CNT_CODELIST.NAME, code list ''LIDL_PACKAGETYPE''',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_PACKAGE_TYPE PRIMARY KEY (package_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO outer package_2 type for items (NETZ/TOPF/BOX usw.)
             CBX: CNT_CODELIST_2 (code list "LIDL_PACKAGETYPE")';
