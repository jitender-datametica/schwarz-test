CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_market_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item instance
            CBX: CNT_ITEM.REF_NO'''),
market_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO market
            CBX: CNT_ITEM.LDL_INCOTERMS, LDL_INCOTERM_US, LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US'''),
mdm_incoterm_cd STRING(100)
OPTIONS(description='''NFPO incoterm codes similar to the terms defined by the International Chamber of Commerce
            CBX: CNT_ITEM.LDL_INCOTERMS, LDL_INCOTERM_US'''),
mdm_completion_type_cd STRING(100)
OPTIONS(description='''NFPO completion types
            CBX: CNT_ITEM.LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US'''),
invoice_curr_cd STRING(3)
OPTIONS(description='''invoice currency for certain markets: here only the currency code for the market US is available
            CBX: CNT_ITEM.LDL_CURRENCY_US'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_sid, market_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='''inormation of NFPO items in relation to markets
             CBX: CNT_ITEM''');