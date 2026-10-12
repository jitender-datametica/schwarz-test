CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_market (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
market_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO market
            CBX: CNT_CODELIST.CODE codelist \'LIDL_CONTINENT_TYPE\''''),
market_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO market code
            CBX: CNT_CODELIST.CODE codelist \'LIDL_CONTINENT_TYPE\''''),
market STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO market name
            CBX: CNT_CODELIST.NAME codelist \'LIDL_CONTINENT_TYPE\''''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (market_sid) NOT ENFORCED
) OPTIONS(description='''NFPO target markets
             CBX: codelist LIDL_CONTINENT_TYPE''');