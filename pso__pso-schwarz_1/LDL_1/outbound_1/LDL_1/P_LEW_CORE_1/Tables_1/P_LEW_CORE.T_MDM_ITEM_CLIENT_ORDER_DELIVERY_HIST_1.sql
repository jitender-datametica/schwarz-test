CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_client_order_delivery_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key NFPO item_1 instance            CBX: CNT_ITEM.REF_NO'),
client_id_order BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key internal organisation, here the local NFPO the order is related to            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
country_del_seq_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='sequence of the planned delivery, derived from source column name'),
cy_week_delivery BIGNUMERIC(38,0)
OPTIONS(description='scheduled Calendar_1 Week of the delivery            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3'),
country_request_qty BIGNUMERIC(38,0)
OPTIONS(description='requested unit_1 quantity            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_PLAN_QTY1, LDL_CTRY_DELIVERY_PLAN_QTY2, LDL_CTRY_DELIVERY_PLAN_QTY3'),
country_delivery_qty BIGNUMERIC(38,0)
OPTIONS(description='scheduled unit_1 quantity            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_TOTAL_QTY1, LDL_CTRY_DELIVERY_TOTAL_QTY2, LDL_CTRY_DELIVERY_TOTAL_QTY3'),
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
PRIMARY KEY (mdm_item_sid, client_id_order, country_del_seq_nr, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='order information of NFPO items for the local NFPOs, split into planned delivery waves             CBX: LDL_ITEM_QUANTITY_1');