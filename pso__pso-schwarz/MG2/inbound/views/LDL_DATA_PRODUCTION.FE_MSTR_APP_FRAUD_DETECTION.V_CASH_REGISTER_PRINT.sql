create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_CASH_REGISTER_PRINT(
	REL_CASH_REGISTER_EVENT_SID COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
	REL_CASH_REGISTER_EVENT_NR COMMENT 'The sequence number of the cash register transaction. It is unique to the cash register, but might be re-cycled after some time.',
	REL_CASHIER_NR COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	CASH_REGISTER_EVENT_LINE_SEQ COMMENT 'The number of the line in the retail event, in the case of the techical event or price information event is the value always \""-1\""',
	CASH_REGISTER_EVENT_LINE_SEQ_DBL COMMENT 'The duplicates of the first row for formatting at frontend',
	AUTH_BY_NR COMMENT 'In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee, who has authorized the transaction. (This is not an employee number!)',
	LINE_AUTH_BY_NR COMMENT 'In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee, who has authorized the transaction. (This is not an employee number!)',
	EVENT_AUTH_BY_NR COMMENT 'In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee, who has authorized the transaction. (This is not an employee number!)',
	PARENT_LINE_SEQ COMMENT 'In case the line represents a deposit, this is the related base line.',
	RETAIL_EVENT_LINE_SCENARIO_ID COMMENT 'The numeric identifier for the scenario which is represented by the retail event line.',
	EVENT_START_TMSP COMMENT 'The point in time when the retail event started.',
	EVENT_END_TMSP COMMENT 'The end timestamp of the retail event.',
	EVENT_LINE_START_TMSP COMMENT 'The point in time when the retail event line started.',
	EVENT_LINE_END_TMSP COMMENT 'The end timestamp of the retail event line.',
	REL_BUS_DT COMMENT 'The business date on which the retail event is counted.',
	REL_STORE_SID COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
	STORE_NR COMMENT 'The identifier for the store where the related retail event happend.',
	COUNTRY_ORG_CD COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
	CASH_REGISTER_NR COMMENT 'The number which identifies the cash register.',
	PROD_RETAIL_LINE_TYPE_CD COMMENT 'The code identifying the subtype discriminator for product retail lines.',
	PROD_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for a sales variant of a product.',
	LOCAL_PROD_NR COMMENT 'The number which identifies the product in the operational retail management system within the given market / internal organization (i.e. the local item number).  Note that the product number is unique for a certain point in time, but may be re-used later on. One product may be identified by several numbers in case of parallel listings or rolling listings. This is the number which has been configured in the cash registers of the given stores for the point in time when the retail transaction was made.',
	PROD_VARIANT_INPUT_NR COMMENT 'The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN, GTIN or a price lookup number (PLU)',
	PROD_VARIANT_INPUT_NR_TYPE_CD COMMENT 'The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN, a GTIN or a product lookup number (PLU).',
	DISPLAYED_PROD_VARIANT_NAME_TITLE COMMENT 'The title of display name if it is receipt number or product number',
	DISPLAYED_PROD_VARIANT_NAME COMMENT 'The name of the product variant, as it is printed on the receipt.',
	PROD_ENTRY_METHOD_CD COMMENT 'The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.',
	PRICE_ENTRY_METHOD_CD COMMENT 'The code identifying the way, how the unit price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.',
	PAYM_LINE_TYPE_CD COMMENT 'The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.',
	PAYM_TYPE_ID COMMENT 'The identifier for the way of payment, i.e. cash, card, voucher, etc.',
	FRAUD_DETECTION_RELEVANT_FG COMMENT 'The identifier of fraud detection relevant receipts.',
	PROD_RETURN_REASON_SID COMMENT 'The unique identifier (surrogate key) for the reasons why a product was returend to the store.',
	RETURN_TXT COMMENT 'A free text field describing the circumstances of the return.',
	PARENT_RETAIL_EVENT_SID COMMENT 'The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales or return of products..',
	UNIT_PRICE COMMENT 'The price of a single unit of the product variant, in the currency indicated by the currency code.',
	PROD_VARIANT_CNT COMMENT 'The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)',
	PROD_VARIANT_QTY COMMENT 'In case of weight-based products, this is the quantity of the product which was sold or returned.',
	BASE_GROSS_VAL COMMENT 'The base gross amount of the sales or return, i.e. quantity / count * unit price. Discounts or price modifications are not considered.',
	RETAIL_LINE_GROSS_VAL COMMENT 'The gross amount of the sales or return, i.e. quantity / count * unit price. Discounts and price changes are considered.',
	RETAIL_LINE_VAT_VAL COMMENT 'The total amount of value added tax which was charged for this line.',
	LOCAL_PAYM_VAL COMMENT 'The amount which was paid in local currency. If the amount was paid by the customer, the sign is positive. If the amount was paid to the customer, the sign is negative. If the payment was in a foreign currency, this is the local currency equivalent.',
	TXN_GROSS_VAL COMMENT 'The total gross amount of the retail transaction. (amount in the currency defined by the currency code)',
	TXN_VAT_VAL COMMENT 'The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)',
	TAX_PCT COMMENT 'The actual tax percentage which is valid for the given tax class. E.g. 19%',
	CASH_REGISTER_EVENT_SEQ COMMENT 'Is a sequence number partition by: real_estate_sid ,bus_dt ,cashier_hash and order by event_end_tmsp.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	ORIG_COUNTRY_ORG_CD COMMENT 'In case of the return the customer needs to provide the original receipt, this column contains the country information of the original receipt.',
	ORIG_STORE_NR COMMENT 'In case of the return the customer needs to provide the original receipt, this columns contains the store number of the original receipt.',
	ORIG_BUS_DT COMMENT 'In case of the return the customer needs to provide the original receipt, this columns contains the business date of the original receipt.',
	ORIG_CASH_REGISTER_NR COMMENT 'In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.',
	ORIG_CASH_REGISTER_EVENT_NR COMMENT 'In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.',
	ORIG_CASH_REGISTER_EVENT_SID COMMENT 'THE ORIGINAL RECEIPT SURROGATE KEY'
) as 
WITH CTE_TRANSACTION_TYPES (RETAIL_EVENT_LINE_SCENARIO_ID,RETAIL_EVENT_LINE_SCENARIO_NAME,RETAIL_EVENT_LINE_SCENARIO_SHORT_NAME,RETAIL_EVENT_LINE_SCENARIO_DESCR) 
AS
(
SELECT
MAIN.RETAIL_EVENT_LINE_SCENARIO_ID
,DECODE(MAIN.RETAIL_EVENT_LINE_SCENARIO_ID,480,'Preisanzeige',MAIN.RETAIL_EVENT_LINE_SCENARIO_NAME)
,MAIN.RETAIL_EVENT_LINE_SCENARIO_SHORT_NAME
,MAIN.RETAIL_EVENT_LINE_SCENARIO_DESCR
FROM CORE_REL.T_RETAIL_EVENT_LINE_SCENARIO MAIN
WHERE MAIN.LANG_CD = 'DE'
AND MAIN.RETAIL_EVENT_LINE_SCENARIO_ID NOT IN ( 
		SELECT
			CRE.TECH_CASH_REGISTER_EVENT_TYPE_CD
		  FROM CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_TYPE CRE
		WHERE CRE.LANG_CD = 'DE'
		UNION ALL
		SELECT
			RES.RETAIL_EVENT_SCENARIO_ID
		FROM CORE_REL.T_RETAIL_EVENT_SCENARIO RES
		WHERE RES.LANG_CD = 'DE' 
		)
UNION ALL 
SELECT
MAIN.TECH_CASH_REGISTER_EVENT_TYPE_CD
,MAIN.TECH_CASH_REGISTER_EVENT_TYPE_DESCR
,MAIN.TECH_CASH_REGISTER_EVENT_TYPE_DESCR
,MAIN.TECH_CASH_REGISTER_EVENT_TYPE_DESCR
FROM CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_TYPE MAIN
WHERE MAIN.LANG_CD = 'DE'
UNION ALL
SELECT
MAIN.RETAIL_EVENT_SCENARIO_ID
,MAIN.RETAIL_EVENT_SCENARIO_NAME
,MAIN.RETAIL_EVENT_SCENARIO_NAME
,MAIN.RETAIL_EVENT_SCENARIO_DESCR
FROM CORE_REL.T_RETAIL_EVENT_SCENARIO MAIN
WHERE MAIN.LANG_CD = 'DE' 
) 
SELECT
main.cash_register_event_sid::VARCHAR(100) AS REL_CASH_REGISTER_EVENT_SID
,main.cash_register_event_nr AS REL_CASH_REGISTER_EVENT_NR
,main.cashier_nr AS REL_CASHIER_NR
,DECODE(COALESCE(d.double_val,1),1,main.cash_register_event_line_seq,NULL) AS cash_register_event_line_seq
,COALESCE(d.double_val,1) AS cash_register_event_line_seq_dbl
,DECODE(COALESCE(d.double_val,1),0,main.event_auth_by_nr,2,main.event_auth_by_nr,main.line_auth_by_nr) AS  auth_nr
,main.line_auth_by_nr
,main.event_auth_by_nr
,main.parent_line_seq
,main.retail_event_line_scenario_id
,TO_CHAR(main.event_start_tmsp,'HH24:MI:SS') AS event_start_tmsp
,TO_CHAR(main.event_end_tmsp,'HH24:MI:SS') AS  event_end_tmsp
,DECODE(COALESCE(d.double_val,1),0,TO_CHAR(main.bus_dt,'DD.MM.YYYY'),1,TO_CHAR(main.event_line_start_tmsp,'HH24:MI:SS'),TO_CHAR(main.event_start_tmsp,'HH24:MI:SS'))  AS event_line_start_tmsp
,TO_CHAR(DECODE(COALESCE(d.double_val,1),1,main.event_line_end_tmsp,main.event_end_tmsp),'HH24:MI:SS') AS event_line_end_tmsp
,main.bus_dt AS REL_BUS_DT
,main.store_sid AS REL_STORE_SID
,main.store_nr
,main.country_org_cd
,main.cash_register_nr
,main.prod_retail_line_type_cd
,main.prod_variant_sid
,DECODE(COALESCE(d.double_val,1),0,main.cash_register_event_nr,2,'',COALESCE(main.local_prod_nr, (main.cash_register_event_nr * 1000 + main.cash_register_event_line_seq)::VARCHAR(30)) ) AS local_prod_nr
,main.prod_variant_input_nr
,main.prod_variant_input_nr_type_cd
,DECODE(COALESCE(d.double_val,1),0, main.cash_register_event_nr,2,'',main.local_prod_nr) AS displayed_prod_variant_name_title  
,DECODE(COALESCE(d.double_val,1),0,'>> '||header_sce.retail_event_line_scenario_name || ' <<',2,'',
        COALESCE(main.prod_name,line_sce.retail_event_line_scenario_name)) AS displayed_prod_variant_name 
,main.prod_entry_method_cd
,main.price_entry_method_cd
,main.paym_line_type_cd
,main.paym_type_id
,main.fraud_detection_relevant_fg
,main.prod_return_reason_sid
,main.return_txt
,main.parent_retail_event_sid
,main.unit_price
,main.prod_variant_cnt
,main.prod_variant_qty
,main.base_gross_val
,main.retail_line_gross_val
,main.retail_line_vat_val
,main.local_paym_val
,main.tax_line_gross_val  AS txn_gross_val
,main.tax_line_val AS txn_vat_val
,main.tax_pct
,main.cash_register_event_seq
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
,main.orig_country_org_cd
,main.orig_store_nr
,main.orig_bus_dt
,main.orig_cash_register_nr
,main.orig_cash_register_event_nr
,main.orig_cash_register_event_nr
FROM CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_PRINT main
LEFT JOIN (SELECT TRUE AS base_val,0 AS double_val
            UNION ALL
            SELECT TRUE AS base_val,1 AS double_val
            UNION ALL
            SELECT TRUE AS base_val,2 AS double_val
		  ) d
ON main.first_line_of_event_fg = d.base_val
AND main.parent_line_seq = -1
LEFT JOIN  CTE_TRANSACTION_TYPES line_sce
ON main.retail_event_line_scenario_id = line_sce.retail_event_line_scenario_id
LEFT JOIN  CTE_TRANSACTION_TYPES header_sce
ON main.cash_register_event_scenario_id = header_sce.retail_event_line_scenario_id;