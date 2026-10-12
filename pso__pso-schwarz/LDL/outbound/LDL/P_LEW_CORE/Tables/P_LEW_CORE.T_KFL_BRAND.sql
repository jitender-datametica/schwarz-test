CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_kfl_brand (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
kfl_brand_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key Kaufland brand            CBX: CNT_ITEM.LDL_BRAND_KL'),
kfl_brand_name STRING(100)
OPTIONS(description='identifying name of the Kaufland Brand            CBX: CNT_ITEM.LDL_BRAND_KL'),
brand_type_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='FK Brand Type; constant value EM (only Eigenmarken from Kaufland will be used here)                        '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (kfl_brand_sid) NOT ENFORCED
)
OPTIONS(description='store brands of the division Kaufland related to items created and ordered by the Lidl NFPO in the common process for non food items             CBX: CNT_ITEM.LDL_BRAND_KL');