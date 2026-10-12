CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_main_pillar_1 (
main_pillar_cd STRING(100) NOT NULL
OPTIONS(description='''code of the main pillar
            CBX: CNT_CODELIST.CODE (code list \'PRODUCT_CATEGORY\')'''),
main_pillar_name STRING(100)
OPTIONS(description='''name  of the main pillar
            CBX: CNT_CODELIST.NAME (code list \'PRODUCT_CATEGORY\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (main_pillar_cd) NOT ENFORCED
)
OPTIONS(description='''main pillar (HG/TX) directly assigned to the item_1 instance in the NFPO source system. 
             CBX:  CNT_CODELIST_1, code list \'PRODUCT CATEGORY\'''');