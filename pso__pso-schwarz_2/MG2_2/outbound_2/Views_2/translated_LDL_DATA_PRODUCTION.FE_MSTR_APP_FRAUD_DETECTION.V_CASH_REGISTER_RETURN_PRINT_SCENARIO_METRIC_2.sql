CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_return_print_scenario_metric_2 (scenario_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF FRAUD DETECTION SCENARIO'), metric_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF MICROSTRATEY METRIC'), cust_sid
OPTIONS(description='The unique identifier (surrogate key) for the customer.'), cust_ident_type_cd
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
cash_register_event_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED CASH REGISTER EVENT. DEPENDING ON THE SCENARIO, IT REFERENCES A RETAIL EVENT, A PRICE LOOKUP EVENT OR A TECHNICAL CASH REGISTER EVENT.'),
cash_register_event_nr
OPTIONS(description='THE SEQUENCE NUMBER OF THE CASH REGISTER TRANSACTION. IT IS UNIQUE TO THE CASH REGISTER, BUT MIGHT BE RE_2-CYCLED AFTER SOME TIME.'),
cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
bus_dt OPTIONS(description='THE BUSINESS DATE ON WHICH THE RETAIL EVENT IS COUNTED.'), store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED RETAIL EVENT HAPPEND.'),
rel_cash_register_event_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED CASH REGISTER EVENT. DEPENDING ON THE SCENARIO, IT REFERENCES A RETAIL EVENT, A PRICE LOOKUP EVENT OR A TECHNICAL CASH REGISTER EVENT.'),
rel_cash_register_event_nr
OPTIONS(description='THE SEQUENCE NUMBER OF THE CASH REGISTER TRANSACTION. IT IS UNIQUE TO THE CASH REGISTER, BUT MIGHT BE RE_2-CYCLED AFTER SOME TIME.'),
rel_cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
cash_register_event_line_seq
OPTIONS(description='THE NUMBER OF THE LINE IN THE RETAIL EVENT, IN THE CASE OF THE TECHICAL EVENT OR PRICE INFORMATION EVENT IS THE VALUE ALWAYS\""-1\""'),
cash_register_event_line_seq_dbl OPTIONS(description='THE DUPLICATES OF THE FIRST ROW FOR FORMATTING AT FRONTEN'),
auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_2, who has authorized the transaction. (This is not an employee_2 number!)'),
line_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_2, who has authorized the transaction. (This is not an employee_2 number!)'),
event_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_2, who has authorized the transaction. (This is not an employee_2 number!)'),
parent_line_seq OPTIONS(description='IN CASE THE LINE REPRESENTS A DEPOSIT, THIS IS THE RELATED BASE LINE.'),
retail_event_line_scenario_id
OPTIONS(description='THE NUMERIC IDENTIFIER FOR THE SCENARIO WHICH IS REPRESENTED BY THE RETAIL EVENT LINE.'),
event_start_tmsp OPTIONS(description='THE POINT IN TIME WHEN THE RETAIL EVENT STARTED.'), event_end_tmsp
OPTIONS(description='THE END TIMESTAMP OF THE RETAIL EVENT.'), event_line_start_tmsp
OPTIONS(description='THE POINT IN TIME WHEN THE RETAIL EVENT LINE STARTED.'), event_line_end_tmsp
OPTIONS(description='THE END TIMESTAMP OF THE RETAIL EVENT LINE.'), rel_bus_dt
OPTIONS(description='THE BUSINESS DATE ON WHICH THE RETAIL EVENT IS COUNTED.'), rel_store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED RETAIL EVENT HAPPEND.'),
store_nr OPTIONS(description='THE IDENTIFIER FOR THE STORE WHERE THE RELATED RETAIL EVENT HAPPEND.'), country_org_cd
OPTIONS(description='THE CODE OF THE RELATED BUSINESS COUNTRY. (THE BUSINESS COUNTRY_2 IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
cash_register_nr OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASH REGISTER.'), prod_retail_line_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE SUBTYPE DISCRIMINATOR FOR PRODUCT RETAIL LINES.'), prod_variant_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR A SALES_2 VARIANT OF A PRODUCT.'), local_prod_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE PRODUCT IN THE OPERATIONAL RETAIL MANAGEMENT SYSTEM WITHIN THE GIVEN MARKET / INTERNAL ORGANIZATION (I.E. THE LOCAL ITEM_2 NUMBER).  NOTE THAT THE PRODUCT NUMBER IS UNIQUE FOR A CERTAIN POINT IN TIME, BUT MAY BE RE_2-USED LATER ON. ONE PRODUCT MAY BE IDENTIFIED BY SEVERAL NUMBERS IN CASE OF PARALLEL LISTINGS OR ROLLING LISTINGS. THIS IS THE NUMBER WHICH HAS BEEN CONFIGURED IN THE CASH REGISTERS OF THE GIVEN STORES FOR THE POINT IN TIME WHEN THE RETAIL TRANSACTION WAS MADE.'),
prod_variant_input_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE PRODUCT VARIANT - AS IT HAS BEEN SCANNED OR MANUALLY KEYED THIS. THIS CAN BE AN EAN_2, GTIN OR A PRICE LOOKUP NUMBER (PLU)'),
prod_variant_input_nr_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE KIND OF THE NUMBER WHICH HAS BEEN SCANNED OR TYPED IN, IN ORDER TO IDENTIFY THE PRODUCT VARIANT. THE PRODUCT VARIANT NUMBER CAN BE IDENTIFIED BY AN EAN_2, A GTIN OR A PRODUCT LOOKUP NUMBER (PLU).'),
displayed_prod_variant_name_title
OPTIONS(description='THE TITLE OF DISPLAY NAME IF IT IS RECEIPT NUMBER OR PRODUCT NUMBER'), displayed_prod_variant_name
OPTIONS(description='THE NAME OF THE PRODUCT VARIANT, AS IT IS PRINTED ON THE RECEIPT.'), prod_entry_method_cd
OPTIONS(description='THE CODE IDENTIFYING THE WAY, HOW THE PRODUCT WAS ENTERED INTO THE CASH REGISTER, I.E. IF THE PRODUCT IS SCANNED, OR IF IT IS ENTERED VIA THE KEYBOARD.'),
price_entry_method_cd
OPTIONS(description='THE CODE IDENTIFYING THE WAY, HOW THE UNIT_2 PRICE WAS ENTERED INTO THE CASH REGISTER, I.E. IF THE PRODUCT IS SCANNED, OR IF IT IS ENTERED VIA THE KEYBOARD.'),
paym_line_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE SUBTYPE DISCRIMINATOR FOR PAYMENT LINES. IT DISTINGUISHES BETWEEN INCOMING AND OUTGOING PAYMENTS, I.E. PAYMENTS MADE BY THE CUSTOMER AND PAYMENTS MADE TO THE CUSTOMER.'),
paym_type_id OPTIONS(description='THE IDENTIFIER FOR THE WAY OF PAYMENT, I.E. CASH, CARD, VOUCHER, ETC.'),
fraud_detection_relevant_fg OPTIONS(description='THE IDENTIFIER OF FRAUD DETECTION RELEVANT RECEIPTS.'),
prod_return_reason_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE REASONS WHY A PRODUCT WAS RETUREND TO THE STORE.'),
return_txt OPTIONS(description='A FREE TEXT FIELD DESCRIBING THE CIRCUMSTANCES OF THE RETURN.'), parent_retail_event_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED RETAIL TRANSACTION, I.E. FOR THE SALES_2 OR RETURN OF PRODUCTS..'),
unit_price
OPTIONS(description='THE PRICE OF A SINGLE UNIT_2 OF THE PRODUCT VARIANT, IN THE CURRENCY INDICATED BY THE CURRENCY CODE.'),
prod_variant_cnt
OPTIONS(description='THE NUMBER OF THIS PRODUCT VARIANT WHICH HAS BEEN SOLD OR RETURNED. (THIS ATTRIBUTE IS EMPTY FOR WEIGHT-BASED PRODUCTS.)'),
prod_variant_qty
OPTIONS(description='IN CASE OF WEIGHT-BASED PRODUCTS, THIS IS THE QUANTITY OF THE PRODUCT WHICH WAS SOLD OR RETURNED.'),
base_gross_val
OPTIONS(description='THE BASE GROSS AMOUNT OF THE SALES_2 OR RETURN, I.E. QUANTITY / COUNT * UNIT_2 PRICE. DISCOUNTS OR PRICE MODIFICATIONS ARE NOT CONSIDERED.'),
retail_line_gross_val
OPTIONS(description='THE GROSS AMOUNT OF THE SALES_2 OR RETURN, I.E. QUANTITY / COUNT * UNIT_2 PRICE. DISCOUNTS AND PRICE CHANGES ARE CONSIDERED.'),
retail_line_vat_val OPTIONS(description='THE TOTAL AMOUNT OF VALUE ADDED TAX WHICH WAS CHARGED FOR THIS LINE.'),
local_paym_val
OPTIONS(description='THE AMOUNT WHICH WAS PAID IN LOCAL CURRENCY. IF THE AMOUNT WAS PAID BY THE CUSTOMER, THE SIGN IS POSITIVE. IF THE AMOUNT WAS PAID TO THE CUSTOMER, THE SIGN IS NEGATIVE. IF THE PAYMENT WAS IN A FOREIGN CURRENCY, THIS IS THE LOCAL CURRENCY EQUIVALENT.'),
txn_gross_val
OPTIONS(description='THE TOTAL GROSS AMOUNT OF THE RETAIL TRANSACTION. (AMOUNT IN THE CURRENCY DEFINED BY THE CURRENCY CODE)'),
txn_vat_val
OPTIONS(description='THE TOTAL VAT AMOUNT OF THE RETAIL TRANSACTION. (AMOUNT IN THE CURRENCY DEFINED BY THE CURRENCY CODE)'),
tax_pct OPTIONS(description='THE ACTUAL TAX PERCENTAGE WHICH IS VALID FOR THE GIVEN TAX CLASS. E.G. 19%'),
cash_register_event_seq
OPTIONS(description='IS A SEQUENCE NUMBER PARTITION BY: REAL_ESTATE_SID ,BUS_DT ,CASHIER_HASH AND ORDER BY EVENT_END_TMSP.'),
dwh_created_tmsp OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED IN THE DATA WAREHOUSE.'),
dwh_updated_tmsp OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED IN THE DATA WAREHOUSE.'),
dwh_load_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF THE BATCH LOAD WHICH HAS DONE THE LAST UPDATE TO THIS RECORD. (CLOSING A RECORD IN HISTORY WITHOUT UPDATING ANY PAYLOAD COLUMNS DOES NOT TRIGGER AN UPDATE OF THE DWH_LOAD_ID.)'),
dwh_node_cd
OPTIONS(description='THE CODE FOR THE SOURCE SYSTEM (OR SLICE OF SOURCE SYSTEM) FROM WHICH THIS RECORD WAS LOADED.'),
orig_country_org_cd
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this column contains the country_2 information of the original receipt.'),
orig_store_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the store number of the original receipt.'),
orig_bus_dt
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the business date of the original receipt.'),
orig_cash_register_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
orig_cash_register_event_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
orig_cash_register_event_sid OPTIONS(description='THE ORIGINAL RECEIPT SURROGATE KEY'), orig_cashier_nr
OPTIONS(description='THE ORIGINAL RECEIPT CASHIER.')) AS SELECT DISTINCT s.scenario_id,
 m.metric_id,
 ec.cust_sid,
 ec.cust_ident_type_cd,
 CAST(ec.cash_register_event_sid AS STRING) AS cash_register_event_sid,
 ec.cash_register_event_nr,
 ec.cashier_nr,
 ec.bus_dt,
 ec.store_sid,
 CAST(cr_return_print.cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
 cr_return_print.cash_register_event_nr AS rel_cash_register_event_nr,
 cr_return_print.cashier_nr AS rel_cashier_nr,
 999 AS cash_register_event_line_seq,
 999 AS cash_register_event_line_seq_dbl,
 cr_return_print.event_auth_by_nr AS auth_by_nr,
 cr_return_print.line_auth_by_nr,
 cr_return_print.event_auth_by_nr,
 cr_return_print.parent_line_seq,
 cr_return_print.retail_event_line_scenario_id,
 FORMAT_TIMESTAMP('%H:%M:%S', cr_return_print.event_start_tmsp) AS event_start_tmsp,
 FORMAT_TIMESTAMP('%H:%M:%S', cr_return_print.event_end_tmsp) AS event_end_tmsp,
 FORMAT_DATE('%d.%m.%Y', cr_return_print.orig_bus_dt) AS event_line_start_tmsp,
 FORMAT_TIMESTAMP('%H:%M:%S', cr_return_print.event_end_tmsp) AS event_line_end_tmsp,
 cr_return_print.bus_dt AS rel_bus_dt,
 cr_return_print.store_sid AS rel_store_sid,
 cr_return_print.store_nr,
 cr_return_print.country_org_cd,
 cr_return_print.cash_register_nr,
 cr_return_print.prod_retail_line_type_cd,
 cr_return_print.prod_variant_sid,
   CAST(cr_return_print.cash_register_event_nr AS FLOAT64) * 1000 + 999 AS local_prod_nr,
 cr_return_print.prod_variant_input_nr,
 cr_return_print.prod_variant_input_nr_type_cd,
 cr_return_print.orig_cash_register_event_nr AS displayed_prod_variant_name_title,
  'Rückgabegrund:' || pr.prod_return_reason_descr AS displayed_prod_variant_name,
 cr_return_print.prod_entry_method_cd,
 cr_return_print.price_entry_method_cd,
 cr_return_print.paym_line_type_cd,
 cr_return_print.paym_type_id,
 cr_return_print.fraud_detection_relevant_fg,
 cr_return_print.prod_return_reason_sid,
 cr_return_print.return_txt,
 cr_return_print.parent_retail_event_sid,
 cr_return_print.unit_price,
 cr_return_print.prod_variant_cnt,
 cr_return_print.prod_variant_qty,
 cr_return_print.base_gross_val,
 cr_return_print.retail_line_gross_val,
 cr_return_print.retail_line_vat_val,
 cr_return_print.local_paym_val,
 cr_return_print.tax_line_gross_val AS txn_gross_val,
 cr_return_print.tax_line_val AS txn_vat_val,
 cr_return_print.tax_pct,
 cr_return_print.cash_register_event_seq,
 cr_return_print.dwh_created_tmsp,
 cr_return_print.dwh_updated_tmsp,
 cr_return_print.dwh_load_id,
 cr_return_print.dwh_node_cd,
 cr_return_print.orig_country_org_cd,
 cr_return_print.orig_store_nr,
 cr_return_print.orig_bus_dt,
 cr_return_print.orig_cash_register_nr,
 cr_return_print.orig_cash_register_event_nr,
 CAST(cr_return_print.orig_cash_register_event_nr AS STRING) AS orig_cash_register_event_sid,
 cr_return_print.orig_cash_register_nr AS orig_cashier_nr
FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS ec
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s ON ec.scenario_id = s.scenario_id
    AND s.scenario_grp_id = 2
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m ON s.scenario_id = m.scenario_id
  
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_2 AS cr_return ON ec.country_org_cd
     = cr_return.country_org_cd AND ec.cash_register_event_sid = cr_return.cash_register_event_sid AND cr_return.cash_register_event_rel_type_cd
    IN ('SELF', 'RETURN_SAME_ORIGINAL')
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_print_2 AS cr_return_print ON cr_return.country_org_cd
     = cr_return_print.country_org_cd AND cr_return.rel_cash_register_event_sid = cr_return_print.cash_register_event_sid
     AND cr_return_print.retail_event_line_scenario_id IN (141, 142)
 INNER JOIN ldl_data_production_core_rel.t_product_return_reason_2 AS pr ON cr_return_print.prod_return_reason_sid = pr.prod_return_reason_sid
    AND pr.lang_cd = 'DE';