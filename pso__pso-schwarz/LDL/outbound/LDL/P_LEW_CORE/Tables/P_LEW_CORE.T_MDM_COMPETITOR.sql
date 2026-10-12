CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_competitor (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
competitor_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key Competitor            CBX: CNT_ITEM.LDL_COMPETITOR,LDL_COMPETITOR2'),
src_competitor_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='unified abbreviation of the competitor            CBX: CNT_ITEM.LDL_COMPETITOR,LDL_COMPETITOR2'),
competitor_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Competitor name;            CBX: CTM_CODELIST.CUST_TEXT1 (code list\'LIDL_COMPET\')'),
competitor_short_name STRING(100)
OPTIONS(description='abbreveated Competitor name;            CBX: CNT_CODELIST.NAME (code list\'LIDL_COMPET\')'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (competitor_sid) NOT ENFORCED
) OPTIONS(description='list of retail companies regarded as competitors             CBX: Codelist LIDL_COMPET');