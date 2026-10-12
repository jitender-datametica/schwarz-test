CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_cash_register_return_print_scenario_metric (scenario_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF FRAUD DETECTION SCENARIO'), metric_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF MICROSTRATEY METRIC'), cust_sid
OPTIONS(description='The unique identifier (surrogate key) for the customer.'), cust_ident_type_cd
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
cash_register_event_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED CASH REGISTER EVENT. DEPENDING ON THE SCENARIO, IT REFERENCES A RETAIL EVENT, A PRICE LOOKUP EVENT OR A TECHNICAL CASH REGISTER EVENT.'),
cash_register_event_nr
OPTIONS(description='THE SEQUENCE NUMBER OF THE CASH REGISTER TRANSACTION. IT IS UNIQUE TO THE CASH REGISTER, BUT MIGHT BE RE-CYCLED AFTER SOME TIME.'),
cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
bus_dt OPTIONS(description='THE BUSINESS DATE ON WHICH THE RETAIL EVENT IS COUNTED.'), store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED RETAIL EVENT HAPPEND.'),
rel_cash_register_event_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED CASH REGISTER EVENT. DEPENDING ON THE SCENARIO, IT REFERENCES A RETAIL EVENT, A PRICE LOOKUP EVENT OR A TECHNICAL CASH REGISTER EVENT.'),
rel_cash_register_event_nr
OPTIONS(description='THE SEQUENCE NUMBER OF THE CASH REGISTER TRANSACTION. IT IS UNIQUE TO THE CASH REGISTER, BUT MIGHT BE RE-CYCLED AFTER SOME TIME.'),
rel_cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
cash_register_event_line_seq
OPTIONS(description='THE NUMBER OF THE LINE IN THE RETAIL EVENT, IN THE CASE OF THE TECHICAL EVENT OR PRICE INFORMATION EVENT IS THE VALUE ALWAYS "-1"'),
cash_register_event_line_seq_dbl OPTIONS(description='THE DUPLICATES OF THE FIRST ROW FOR FORMATTING AT FRONTEN'),
auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee, who has authorized the transaction. (This is not an employee number!)'),
line_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee, who has authorized the transaction. (This is not an employee number!)'),
event_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee, who has authorized the transaction. (This is not an employee number!)'),
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
OPTIONS(description='THE CODE OF THE RELATED BUSINESS COUNTRY. (THE BUSINESS COUNTRY IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
cash_register_nr OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASH REGISTER.'), prod_retail_line_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE SUBTYPE DISCRIMINATOR FOR PRODUCT RETAIL LINES.'), prod_variant_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR A SALES VARIANT OF A PRODUCT.'), local_prod_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE PRODUCT IN THE OPERATIONAL RETAIL MANAGEMENT SYSTEM WITHIN THE GIVEN MARKET / INTERNAL ORGANIZATION (I.E. THE LOCAL ITEM NUMBER).  NOTE THAT THE PRODUCT NUMBER IS UNIQUE FOR A CERTAIN POINT IN TIME, BUT MAY BE RE-USED LATER ON. ONE PRODUCT MAY BE IDENTIFIED BY SEVERAL NUMBERS IN CASE OF PARALLEL LISTINGS OR ROLLING LISTINGS. THIS IS THE NUMBER WHICH HAS BEEN CONFIGURED IN THE CASH REGISTERS OF THE GIVEN STORES FOR THE POINT IN TIME WHEN THE RETAIL TRANSACTION WAS MADE.'),
prod_variant_input_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE PRODUCT VARIANT - AS IT HAS BEEN SCANNED OR MANUALLY KEYED THIS. THIS CAN BE AN EAN, GTIN OR A PRICE LOOKUP NUMBER (PLU)'),
prod_variant_input_nr_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE KIND OF THE NUMBER WHICH HAS BEEN SCANNED OR TYPED IN, IN ORDER TO IDENTIFY THE PRODUCT VARIANT. THE PRODUCT VARIANT NUMBER CAN BE IDENTIFIED BY AN EAN, A GTIN OR A PRODUCT LOOKUP NUMBER (PLU).'),
displayed_prod_variant_name_title
OPTIONS(description='THE TITLE OF DISPLAY NAME IF IT IS RECEIPT NUMBER OR PRODUCT NUMBER'), displayed_prod_variant_name
OPTIONS(description='THE NAME OF THE PRODUCT VARIANT, AS IT IS PRINTED ON THE RECEIPT.'), prod_entry_method_cd
OPTIONS(description='THE CODE IDENTIFYING THE WAY, HOW THE PRODUCT WAS ENTERED INTO THE CASH REGISTER, I.E. IF THE PRODUCT IS SCANNED, OR IF IT IS ENTERED VIA THE KEYBOARD.'),
price_entry_method_cd
OPTIONS(description='THE CODE IDENTIFYING THE WAY, HOW THE UNIT PRICE WAS ENTERED INTO THE CASH REGISTER, I.E. IF THE PRODUCT IS SCANNED, OR IF IT IS ENTERED VIA THE KEYBOARD.'),
paym_line_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE SUBTYPE DISCRIMINATOR FOR PAYMENT LINES. IT DISTINGUISHES BETWEEN INCOMING AND OUTGOING PAYMENTS, I.E. PAYMENTS MADE BY THE CUSTOMER AND PAYMENTS MADE TO THE CUSTOMER.'),
paym_type_id OPTIONS(description='THE IDENTIFIER FOR THE WAY OF PAYMENT, I.E. CASH, CARD, VOUCHER, ETC.'),
fraud_detection_relevant_fg OPTIONS(description='THE IDENTIFIER OF FRAUD DETECTION RELEVANT RECEIPTS.'),
prod_return_reason_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE REASONS WHY A PRODUCT WAS RETUREND TO THE STORE.'),
return_txt OPTIONS(description='A FREE TEXT FIELD DESCRIBING THE CIRCUMSTANCES OF THE RETURN.'), parent_retail_event_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED RETAIL TRANSACTION, I.E. FOR THE SALES OR RETURN OF PRODUCTS..'),
unit_price
OPTIONS(description='THE PRICE OF A SINGLE UNIT OF THE PRODUCT VARIANT, IN THE CURRENCY INDICATED BY THE CURRENCY CODE.'),
prod_variant_cnt
OPTIONS(description='THE NUMBER OF THIS PRODUCT VARIANT WHICH HAS BEEN SOLD OR RETURNED. (THIS ATTRIBUTE IS EMPTY FOR WEIGHT-BASED PRODUCTS.)'),
prod_variant_qty
OPTIONS(description='IN CASE OF WEIGHT-BASED PRODUCTS, THIS IS THE QUANTITY OF THE PRODUCT WHICH WAS SOLD OR RETURNED.'),
base_gross_val
OPTIONS(description='THE BASE GROSS AMOUNT OF THE SALES OR RETURN, I.E. QUANTITY / COUNT * UNIT PRICE. DISCOUNTS OR PRICE MODIFICATIONS ARE NOT CONSIDERED.'),
retail_line_gross_val
OPTIONS(description='THE GROSS AMOUNT OF THE SALES OR RETURN, I.E. QUANTITY / COUNT * UNIT PRICE. DISCOUNTS AND PRICE CHANGES ARE CONSIDERED.'),
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
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this column contains the country information of the original receipt.'),
orig_store_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the store number of the original receipt.'),
orig_bus_dt
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the business date of the original receipt.'),
orig_cash_register_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
orig_cash_register_event_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
orig_cash_register_event_sid OPTIONS(description='THE ORIGINAL RECEIPT SURROGATE KEY'), orig_cashier_nr
OPTIONS(description='THE ORIGINAL RECEIPT CASHIER.')) AS WITH CTE_CLS_REL_CASH_REGISTER AS (SELECT *
  FROM (SELECT t1.cash_register_event_sid_ow AS cash_register_event_sid,
      t1.scenario_id,
      t1.cust_sid,
      t1.cust_ident_type_cd,
      t1.cash_register_event_nr,
      t1.cashier_nr,
      t1.bus_dt,
      t1.store_sid,
      t1.country_org_cd,
      t1.rel_cash_register_event_sid,
      t1.rel_bus_dt,
      t1.cash_register_event_rel_type_cd
     FROM (SELECT DISTINCT MAX(CASE
          WHEN REL.cash_register_event_rel_type_cd = 'SUCCESSOR'
          THEN REL.rel_cash_register_event_sid
          ELSE 0
          END) OVER (PARTITION BY CAST(REL.cash_register_event_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS cash_register_event_sid_ow,
        CLS.scenario_id,
        CLS.cust_sid,
        CLS.cust_ident_type_cd,
        ROUND(CAST(RIGHT(SUBSTR(CAST(MAX(CASE
               WHEN REL.cash_register_event_rel_type_cd = 'SUCCESSOR'
               THEN REL.rel_cash_register_event_sid
               ELSE 0
               END) OVER (PARTITION BY CAST(REL.cash_register_event_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING) AS STRING), 1, 39), 10) AS BIGNUMERIC), 0) AS cash_register_event_nr,
        CLS.cashier_nr,
        CLS.bus_dt,
        CLS.store_sid,
        CLS.country_org_cd,
         CASE
         WHEN REL.cash_register_event_rel_type_cd = 'SELF'
         THEN REL.cash_register_event_sid
         ELSE REL.rel_cash_register_event_sid
         END AS rel_cash_register_event_sid,
        REL.rel_bus_dt,
        REL.cash_register_event_rel_type_cd
       FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship AS REL
        INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification AS CLS ON REL.bus_dt = CLS.bus_dt
            AND REL.country_org_cd = CLS.country_org_cd AND REL.cash_register_event_sid = CLS.cash_register_event_sid
       WHERE CLS.scenario_id IN (6, 60100, 60200, 60300)
        AND REL.cash_register_event_rel_type_cd IN ('SELF', 'SUCCESSOR', 'EVENT_AROUND_LOGOFF', 'SUCC_ALL_NPI_EVENTS'))
      AS t1
     UNION ALL
     SELECT t5.cash_register_event_sid_ow AS cash_register_event_sid,
      t5.scenario_id,
      t5.cust_sid,
      t5.cust_ident_type_cd,
      t5.cash_register_event_nr,
      t5.cashier_nr,
      t5.bus_dt,
      t5.store_sid,
      t5.country_org_cd,
      t5.rel_cash_register_event_sid,
      t5.rel_bus_dt,
      t5.cash_register_event_rel_type_cd
     FROM (SELECT DISTINCT MAX(CASE
          WHEN REL.cash_register_event_rel_type_cd = 'SELF'
          THEN 0
          ELSE REL.rel_cash_register_event_sid
          END) OVER (PARTITION BY CAST(REL.cash_register_event_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS cash_register_event_sid_ow,
        CLS.scenario_id,
        CLS.cust_sid,
        CLS.cust_ident_type_cd,
        ROUND(CAST(RIGHT(SUBSTR(CAST(MAX(CASE
               WHEN REL.cash_register_event_rel_type_cd = 'SELF'
               THEN 0
               ELSE REL.rel_cash_register_event_sid
               END) OVER (PARTITION BY CAST(REL.cash_register_event_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING) AS STRING), 1, 39), 10) AS BIGNUMERIC), 0) AS cash_register_event_nr,
        CLS.cashier_nr,
        CLS.bus_dt,
        CLS.store_sid,
        CLS.country_org_cd,
         CASE
         WHEN REL.cash_register_event_rel_type_cd = 'SELF'
         THEN REL.cash_register_event_sid
         ELSE REL.rel_cash_register_event_sid
         END AS rel_cash_register_event_sid,
        REL.rel_bus_dt,
        REL.cash_register_event_rel_type_cd
       FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship AS REL
        INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification AS CLS ON REL.bus_dt = CLS.bus_dt
            AND REL.country_org_cd = CLS.country_org_cd AND REL.cash_register_event_sid = CLS.cash_register_event_sid
       WHERE CLS.scenario_id IN (12, 120100, 120200, 120300, 120400, 120600, 120700, 120900, 120800)
        AND REL.cash_register_event_rel_type_cd IN ('SELF', 'ORIGINAL')) AS t5
     UNION ALL
     SELECT CLS.cash_register_event_sid,
      CLS.scenario_id,
      CLS.cust_sid,
      CLS.cust_ident_type_cd,
      ROUND(CAST(CLS.cash_register_event_nr AS BIGNUMERIC), 0) AS cash_register_event_nr,
      CLS.cashier_nr,
      CLS.bus_dt,
      CLS.store_sid,
      CLS.country_org_cd,
      REL.rel_cash_register_event_sid,
      REL.rel_bus_dt,
      REL.cash_register_event_rel_type_cd
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship AS REL
      INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification AS CLS ON REL.bus_dt = CLS.bus_dt
          AND REL.country_org_cd = CLS.country_org_cd AND REL.cash_register_event_sid = CLS.cash_register_event_sid
     WHERE CLS.scenario_id NOT IN (6, 60100, 60200, 60300, 12, 120100, 120200, 120300, 120400, 120600, 120700, 120800,
        120900)) AS t9) (SELECT S.scenario_id,
   M.metric_id,
   EC.cust_sid,
   EC.cust_ident_type_cd,
   CAST(EC.cash_register_event_sid AS STRING),
   EC.cash_register_event_nr,
   EC.cashier_nr,
   EC.bus_dt,
   EC.store_sid,
   CAST(CR_RETURN_PRINT.cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
   CR_RETURN_PRINT.cash_register_event_nr AS rel_cash_register_event_nr,
   CR_RETURN_PRINT.cashier_nr AS rel_cashier_nr,
   CR_RETURN_PRINT.cash_register_event_line_seq,
   999 AS cash_register_event_line_seq_dbl,
   CR_RETURN_PRINT.event_auth_by_nr,
   CR_RETURN_PRINT.line_auth_by_nr,
   CR_RETURN_PRINT.event_auth_by_nr AS event_auth_by_nr0,
   CR_RETURN_PRINT.parent_line_seq,
   CR_RETURN_PRINT.retail_event_line_scenario_id,
   FORMAT_TIMESTAMP('%H:%M:%S', CR_RETURN_PRINT.event_start_tmsp) AS event_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', CR_RETURN_PRINT.event_end_tmsp) AS event_end_tmsp,
   FORMAT_DATE('%d.%m.%Y', CR_RETURN_PRINT.orig_bus_dt) AS event_line_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', CR_RETURN_PRINT.event_end_tmsp) AS event_line_end_tmsp,
   CR_RETURN_PRINT.bus_dt AS rel_bus_dt,
   CR_RETURN_PRINT.store_sid AS rel_store_sid,
   CR_RETURN_PRINT.store_nr,
   CR_RETURN_PRINT.country_org_cd,
   CR_RETURN_PRINT.cash_register_nr,
   CR_RETURN_PRINT.prod_retail_line_type_cd,
   CR_RETURN_PRINT.prod_variant_sid,
     CAST(CR_RETURN_PRINT.cash_register_event_nr AS FLOAT64) * 10000 + CR_RETURN_PRINT.cash_register_event_line_seq AS
   local_prod_nr,
   CR_RETURN_PRINT.prod_variant_input_nr,
   CR_RETURN_PRINT.prod_variant_input_nr_type_cd,
   CR_RETURN_PRINT.orig_cash_register_event_nr AS displayed_prod_variant_name_title,
    'Rückgabegrund:' || PR.prod_return_reason_descr AS displayed_prod_variant_name,
   CR_RETURN_PRINT.prod_entry_method_cd,
   CR_RETURN_PRINT.price_entry_method_cd,
   CR_RETURN_PRINT.paym_line_type_cd,
   CR_RETURN_PRINT.paym_type_id,
   CR_RETURN_PRINT.fraud_detection_relevant_fg,
   CR_RETURN_PRINT.prod_return_reason_sid,
   CR_RETURN_PRINT.return_txt,
   CR_RETURN_PRINT.parent_retail_event_sid,
   CR_RETURN_PRINT.unit_price,
   CR_RETURN_PRINT.prod_variant_cnt,
   CR_RETURN_PRINT.prod_variant_qty,
   CR_RETURN_PRINT.base_gross_val,
   CR_RETURN_PRINT.retail_line_gross_val,
   CR_RETURN_PRINT.retail_line_vat_val,
   CR_RETURN_PRINT.local_paym_val,
   CR_RETURN_PRINT.tax_line_gross_val AS txn_gross_val,
   CR_RETURN_PRINT.tax_line_val AS txn_vat_val,
   CR_RETURN_PRINT.tax_pct,
   CR_RETURN_PRINT.cash_register_event_seq,
   CR_RETURN_PRINT.dwh_created_tmsp,
   CR_RETURN_PRINT.dwh_updated_tmsp,
   CR_RETURN_PRINT.dwh_load_id,
   CR_RETURN_PRINT.dwh_node_cd,
   CR_RETURN_PRINT.orig_country_org_cd,
   CR_RETURN_PRINT.orig_store_nr,
   CR_RETURN_PRINT.orig_bus_dt,
   CR_RETURN_PRINT.orig_cash_register_nr,
   CR_RETURN_PRINT.orig_cash_register_event_nr,
   CAST(CR_RETURN_PRINT.orig_cash_register_event_nr AS STRING) AS orig_cash_register_event_sid,
   CR_RETURN_PRINT.orig_cash_register_nr AS orig_cash_register_nr0
  FROM CTE_CLS_REL_CASH_REGISTER AS EC
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S ON EC.scenario_id = S.scenario_id AND S
     .scenario_grp_id = 2
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS M ON S.scenario_id = M.scenario_id
   INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_print AS CR_RETURN_PRINT ON EC.country_org_cd =
      CR_RETURN_PRINT.country_org_cd AND EC.rel_cash_register_event_sid = CR_RETURN_PRINT.cash_register_event_sid AND
     CR_RETURN_PRINT.retail_event_line_scenario_id IN (141, 142)
   INNER JOIN ldl_data_core_rel.t_product_return_reason AS PR ON CR_RETURN_PRINT.prod_return_reason_sid = PR.prod_return_reason_sid
      AND PR.lang_cd = 'DE'
  WHERE EC.cash_register_event_rel_type_cd IN ('SELF', 'RETURN_SAME_ORIGINAL'));