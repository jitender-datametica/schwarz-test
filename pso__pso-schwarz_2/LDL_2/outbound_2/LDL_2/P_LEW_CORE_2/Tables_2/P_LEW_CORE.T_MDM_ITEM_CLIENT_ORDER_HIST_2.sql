/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_client_order_hist_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:34:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_client_order_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key NFPO item_2 instance            CBX: CNT_ITEM.REF_NO'),
client_id_order BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key internal organisation, here the organisation the order is related to            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
cbx_order_version BIGNUMERIC(38,0)
OPTIONS(description='technical version of the NFPO item_2 order in the source system            CBX: LDL_ITEM_QUANTITY.REVISION'),
cy_week_advertise BIGNUMERIC(38,0)
OPTIONS(description='planned calendar_2 week of the advertising for this item_2 in the sales_2 area of the local NFPO            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_ADVERTISEMENT_DATE'),
cy_week_import BIGNUMERIC(38,0)
OPTIONS(description='planned week of the delivery for this item_2 into the area of the local NFPO            CBX: LDL_ITEM_QUANTITY.LDL_DELIVERY_DATE_OWIM'),
client_sell_from_dt DATE
OPTIONS(description='planned sales_2 start date in the sales_2 area of the local NFPO            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_SALES_DATE'),
client_order_carton_weight NUMERIC(18,5)
OPTIONS(description='case weight in kg;            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_BRUTTO_KOLLI'),
client_order_total_qty BIGNUMERIC(38,0)
OPTIONS(description='total order piece quantity            CBX: LDL_ITEM_QUANTITY.LDL_TOTAL_QTY_PER_COUNTRY'),
client_order_total_carton_qty BIGNUMERIC(38,0)
OPTIONS(description='total order case quantity            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_TOTAL_NUM_OF_CTN'),
client_order_notes STRING(300) COLLATE 'und:ci'
OPTIONS(description='Order notes of the local NFPO            CBX: LDL_ITEM_QUANTITY.LDL_ARTICLE_INFORMATION'),
ldl_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of stores intended to sell the item_2 (Lidl)            AMP: Filialanzahl            '),
kfl_large_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of large stores intended to sell the item_2 (Kaufland)            STEP:MARKTANZAHL_GROSS'),
kfl_small_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of small stores intended to sell the item_2 (Kaufland)            STEP:MARKTANZAHL_KLEIN'),
purch_net_euro_price NUMERIC(18,5)
OPTIONS(description='purchasing net price in EURO (Warenbezugspreis)            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_BUYING_PRICE_CRYPT'),
sales_vat_pct BIGNUMERIC(38,5)
OPTIONS(description='vat percentage            AMP: tax_value             STEP: steuersatz_nonfood'),
sales_gross_euro_price NUMERIC(18,5)
OPTIONS(description='sales_2 gross price in EURO (VK_2 brutto in EUR)            AMP: VK_2 in EUR brutto            STEP: VK_2 in EUR brutto'),
local_eks_sup_nr STRING(100)
OPTIONS(description='supplier_2 number used in EKS for the local subsidiary of the supplier_2            CBX: LDL_ITEM_QUANTITY.LDL_EKS_NO            '),
local_sup_name STRING(100)
OPTIONS(description='name of the local subsidiary of the supplier_2            CBX: LDL_ITEM_QUANTITY.LDL_VENDOR_NAME            '),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_sid, client_id_order, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='order information of NFPO items for the local NFPOs             CBX: LDL_ITEM_QUANTITY_2');