CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_PRODUCT_RETAIL_LINE_GROUP_CURR_1(
	RETAIL_EVENT_SID COMMENT 'The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'  
	,RETAIL_EVENT_LINE_SEQ COMMENT 'The number of the line in the retail event.'  
	,EVENT_START_TMSP COMMENT 'The point in time when the scanning (or the manual input) of the article started.'  
	,EVENT_END_TMSP COMMENT 'The point in time when the scanning (or the manual input) of the article was finished.'  
	,CAL_DT COMMENT 'The business date on which the retail event is counted.'  
	,RETAIL_EVENT_END_TMSP COMMENT 'The point in time when the related retail event was finished.'  
	,STORE_SID COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.'  
	,COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.'  
	,COUNTRY_ORG_CD COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)'  
	,REAL_ESTATE_SID COMMENT 'The unique identifier (surrogate key) for the real estate object.'  
	,CASH_REGISTER_SID COMMENT 'The unique identifier (surrogate key) for the cash register which has created this transaction.'  
	,CASH_REGISTER_TYPE_CD COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'  
	,CASH_REGISTER_USG_TYPE_CD COMMENT 'The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'  
	,CASHIER_HASH COMMENT 'The encrypted number of the cashier. (The hash is unique for a given store and a day.)'  
	,AUTH_BY_HASH COMMENT 'In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the encrypted number which identifies the employee_1, who has authorized the transaction. (The hash is unique for a given store and a day.)'  
	,CUST_SID COMMENT 'The unique identifier (surrogate key) for the customer.'  
	,PROD_RETAIL_LINE_TYPE_CD COMMENT 'The code identifying the subtype discriminator for product retail lines.'  
	,RETAIL_EVENT_LINE_SCENARIO_ID COMMENT 'The numeric identifier for the scenario which is represented by the retail event line.'  
	,SALES_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for a sales_1 variant of a product.'  
	,WAWI_ITEM_SID COMMENT 'The unique identifier (surrogate key) of the Wawi item_1 which represents the sales_1 variant which is sold.'  
	,LOCAL_PROD_NR COMMENT 'The number which identifies the product in the operational retail management system within the given market / internal organization (i.e. the local item_1 number).  Note that the product number is unique for a certain point in time, but may be re_1-used later on. One product may be identified by several numbers in case of parallel listings or rolling listings. This is the number which has been configured in the cash registers of the given stores for the point in time when the retail transaction was made.'  
	,PROD_VARIANT_INPUT_NR COMMENT 'The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'  
	,PROD_VARIANT_INPUT_NR_TYPE_CD COMMENT 'The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'  
	,DISPLAYED_PROD_VARIANT_NAME COMMENT 'The name of the product variant, as it is printed on the receipt.'  
	,WEIGHT_BASED_FG COMMENT 'An indicator showing, if the product variant was sold (or returned) by weight instead of count.'  
	,PROD_VARIANT_CNT COMMENT 'The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'  
	,PROD_VARIANT_QTY COMMENT 'In case of weight-based products, this is the quantity of the product which was sold or returned.'  
	,UOM_CD COMMENT 'The code identifying the unit_1 of measure.'  
	,EXCHANGE_RATE_TYPE_CD COMMENT 'The Exchange Rate Type Code'  
	,EXCHANGE_BUS_YEAR COMMENT 'The Exchange Rate of the business year'  
	,UNIT_PRICE COMMENT 'The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'  
	,BASE_GROSS_VAL COMMENT 'The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'  
	,RETAIL_LINE_GROSS_VAL COMMENT 'The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'  
	,RETAIL_LINE_NET_VAL COMMENT 'The net amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered. (This is a calculated amount!)'  
	,RETAIL_LINE_VAT_VAL COMMENT 'The total amount of value added tax which was charged for this line.'  
	,TAX_CLASS_CD COMMENT 'The code for the tax class, e.g. Reduced VAT Rate.'  
	,GEO_AREA_SID COMMENT 'The unique identifier (surrogate key) for the geographical area to which the tax class applies.'  
	,TAX_PCT COMMENT 'The actual tax percentage which is valid for the given tax class. E.g. 19%'  
	,CURR_CD COMMENT 'The code identifying the currency, according to ISO 4217.'  
	,TURNOVER_RELEVANT_FG COMMENT 'An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'  
	,DISCOUNT_FG COMMENT 'An indicator showing, if a discount or a price modification was applied to the product.'  
	,PROD_ENTRY_METHOD_CD COMMENT 'The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'  
	,PRICE_ENTRY_METHOD_CD COMMENT 'The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'  
	,PROD_RETURN_REASON_SID COMMENT 'The unique identifier (surrogate key) for the reasons why a product was returend to the store.'  
	,RETURN_TXT COMMENT 'A free text field describing the circumstances of the return.'  
	,ORIG_SALES_EVENT_SID COMMENT 'The unique identifier (surrogate key) for the sales_1 transaction in which the returned product was sold.'  
	,ORIG_SALES_EVENT_NR COMMENT 'The sequence number of the sales_1 transaction in which the returned product was sold. (It is unique to the cash register, but might be re_1-cycled after some time.)'  
	,PARENT_LINE_SEQ COMMENT 'In case the line represents a deposit, this is the related base line.'  
	,CANCEL_LINE_SEQ COMMENT 'In case the product retail line is cancelled, this is the number of the related cancellation line.'  
	,CURR_GROUP_FG COMMENT 'Flag for Group Currency'  
	,CURR_LOCAL_FG COMMENT 'Flag for Local Currency'  
	,DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.'  
	,DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'  
	,DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'  
	,DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) AS SELECT
main.retail_event_sid
,main.retail_event_line_seq
,main.event_start_tmsp
,main.event_end_tmsp
,main.bus_dt AS CAL_DT
,main.retail_event_end_tmsp
,main.store_sid
,main.country_org_sid
,main.country_org_cd
,main.real_estate_sid
,main.cash_register_sid
,main.cash_register_type_cd
,main.cash_register_usg_type_cd
,main.cashier_hash
,main.auth_by_hash
,main.cust_sid
,main.prod_retail_line_type_cd
,main.retail_event_line_scenario_id
,main.prod_variant_sid AS sales_variant_sid
,main.wawi_item_sid AS WAWI_ITEM_SID
,main.local_prod_nr
,main.prod_variant_input_nr
,main.prod_variant_input_nr_type_cd
,main.displayed_prod_variant_name
,main.weight_based_fg
,main.prod_variant_cnt
,main.prod_variant_qty
,main.uom_cd
,fer.exchange_rate_type_cd AS exchange_rate_type_cd
,fer.bus_year AS exchange_bus_year
,main.unit_price
,main.base_gross_val
,main.retail_line_gross_val
,main.retail_line_net_val / fer.exchange_rate AS retail_line_net_val
,main.retail_line_vat_val
,main.tax_class_cd
,main.geo_area_sid
,main.tax_pct
,main.curr_cd
,main.turnover_relevant_fg
,main.discount_fg
,main.prod_entry_method_cd
,main.price_entry_method_cd
,main.prod_return_reason_sid
,main.return_txt
,main.orig_sales_event_sid
,main.orig_sales_event_nr
,main.parent_line_seq
,main.cancel_line_seq
,DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
,DECODE(fer.src_curr_cd,fer.TGT_CURR_CD,1,0) AS curr_local_fg
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_REL.T_PRODUCT_RETAIL_LINE_1 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_1 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR')
AND fer.active_fg = TRUE;