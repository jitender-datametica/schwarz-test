CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_line_of_business_1 (
lob_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='line of business code \'LDL\',\'KFL\', distinguishes between Lidl and Kaufland related clients'),
lob_name STRING(100) NOT NULL OPTIONS(description='name of the line of business, \'Lidl\' or \'Kaufland\''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH')
) OPTIONS(description='''line of business
             distinguishes between Lidl and Kaufland related clients''');