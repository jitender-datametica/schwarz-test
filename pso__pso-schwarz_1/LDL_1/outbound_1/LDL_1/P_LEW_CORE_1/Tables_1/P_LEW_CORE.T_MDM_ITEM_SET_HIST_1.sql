CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_set_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_set_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO item_1 set
            CBX: CNT_ITEM_1,
            LDL_ITEM_UNIQUE_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS'''),
style_names STRING(4000) COLLATE 'und:ci'
OPTIONS(description='''list of names of the styles used in the set composition
            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_PRODUCT_NAMES'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_set_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='''NFPO item_1 variant defining sets of styles
             CBX: LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_STYLE''');