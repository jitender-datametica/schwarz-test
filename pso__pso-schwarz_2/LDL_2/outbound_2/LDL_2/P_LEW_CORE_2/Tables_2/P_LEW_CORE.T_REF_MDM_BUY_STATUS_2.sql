/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_buy_status_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:22:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_buy_status_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
buy_status_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO status_2 code related to the order quantity definition process for the local NFPOs of items
            CBX: CNT_CODELIST.CODE codelist \'LIDL_CO_STATUS\''''),
buy_status STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO status_2 name related to the order quantity definition process for the local NFPOs of items
            CBX: CNT_CODELIST.NAME'''),
buy_status_descr STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO status_2 description related to the order quantity definition process for the local NFPOs of items
            CBX: CTM_CODELIST_BOOK.CUST_TEXT1'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id) NOT ENFORCED
)
OPTIONS(description='''NFPO status_2 codes related to the order quantity definition process for the local NFPOs of items
             CBX: CNT_CODELIST_2 (code list "LIDL_CO_STATUS")''');