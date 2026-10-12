/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_completion_type
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:27:56
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE (
   market_sid                          NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO market
            derived from used source code list',
   mdm_completion_type_cd              VARCHAR(100)     NOT NULL COMMENT 'NFPO completion types
            CBX:CNT_CODELIST.CODE (code list ''LIDL_OWIMFH'' and ''LIDL_COMPLTYPE_US'')',
   mdm_completion_type_name            VARCHAR(100)     NOT NULL COMMENT 'NFPO completion type name
            CBX:CNT_CODELIST.NAME (code list ''LIDL_OWIMFH'' and ''LIDL_COMPLTYPE_US''',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_COMPLETION_TYPE PRIMARY KEY (market_sid, mdm_completion_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO completion type codes, different codes are used for different markets
             CBX: CNT_CODELIST (code lists "LIDL_OWIMFH", "LIDL_COMPLTYPE_US")';
