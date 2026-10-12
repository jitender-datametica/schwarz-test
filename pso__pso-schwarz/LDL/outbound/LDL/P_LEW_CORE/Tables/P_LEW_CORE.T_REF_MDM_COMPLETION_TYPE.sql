/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_completion_type
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:27:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_completion_type (
market_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO market
            derived from used source code list'''),
mdm_completion_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO completion types
            CBX:CNT_CODELIST.CODE (code list \'LIDL_OWIMFH\' and \'LIDL_COMPLTYPE_US\')'''),
mdm_completion_type_name STRING(100) NOT NULL
OPTIONS(description='''NFPO completion type name
            CBX:CNT_CODELIST.NAME (code list \'LIDL_OWIMFH\' and \'LIDL_COMPLTYPE_US\''''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (market_sid, mdm_completion_type_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO completion type codes, different codes are used for different markets
             CBX: CNT_CODELIST (code lists "LIDL_OWIMFH", "LIDL_COMPLTYPE_US")''');