/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_incoterm_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:33:43
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_INCOTERM_2 (
   market_sid                          NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO market
            derived from used source code list',
   mdm_incoterm_cd                     VARCHAR(100)     NOT NULL COMMENT 'NFPO incoterm codes similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.CODE (code list ''INCOTERM'' and ''LIDL_INCOTERM_US'')',
   mdm_incoterm_name                   VARCHAR(100)     NOT NULL COMMENT 'NFPO incoterm names similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.NAME (code list ''INCOTERM'' and ''LIDL_INCOTERM_US'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_INCOTERM PRIMARY KEY (market_sid, mdm_incoterm_cd) NOT ENFORCED 
)  COMMENT = 'NFPO set of codes for commercial terms in the contracts, different codes are used for different markets_2
             CBX: CNT_CODELIST_2 (code lists "INCOTERM", "LIDL_INCOTERM_US")';
