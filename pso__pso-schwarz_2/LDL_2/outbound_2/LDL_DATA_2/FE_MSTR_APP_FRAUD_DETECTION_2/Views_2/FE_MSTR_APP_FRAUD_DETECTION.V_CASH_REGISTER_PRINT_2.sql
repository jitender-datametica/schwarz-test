CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_cash_register_print_2 (rel_cash_register_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
rel_cash_register_event_nr
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_2-cycled after some time.'),
rel_cashier_nr
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
cash_register_event_line_seq
OPTIONS(description='The number of the line in the retail event, in the case of the techical event or price information event is the value always "-1"'),
cash_register_event_line_seq_dbl OPTIONS(description='The duplicates of the first row for formatting at frontend'),
auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_2, who has authorized the transaction. (This is not an employee_2 number!)'),
line_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_2, who has authorized the transaction. (This is not an employee_2 number!)'),
event_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_2, who has authorized the transaction. (This is not an employee_2 number!)'),
parent_line_seq OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
retail_event_line_scenario_id
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
event_start_tmsp OPTIONS(description='The point in time when the retail event started.'), event_end_tmsp
OPTIONS(description='The end timestamp of the retail event.'), event_line_start_tmsp
OPTIONS(description='The point in time when the retail event line started.'), event_line_end_tmsp
OPTIONS(description='The end timestamp of the retail event line.'), rel_bus_dt
OPTIONS(description='The business date on which the retail event is counted.'), rel_store_sid
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
store_nr OPTIONS(description='The identifier for the store where the related retail event happend.'), country_org_cd
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
cash_register_nr OPTIONS(description='The number which identifies the cash register.'), prod_retail_line_type_cd
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'), prod_variant_sid
OPTIONS(description='The unique identifier (surrogate key) for a sales_2 variant of a product.'), local_prod_nr
OPTIONS(description='The number which identifies the product in the operational retail management system within the given market / internal organization (i.e. the local item_2 number).  Note that the product number is unique for a certain point in time, but may be re_2-used later on. One product may be identified by several numbers in case of parallel listings or rolling listings. This is the number which has been configured in the cash registers of the given stores for the point in time when the retail transaction was made.'),
prod_variant_input_nr
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_2, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_2, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name_title
OPTIONS(description='The title of display name if it is receipt number or product number'), displayed_prod_variant_name
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'), prod_entry_method_cd
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd
OPTIONS(description='The code identifying the way, how the unit_2 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
paym_line_type_cd
OPTIONS(description='The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.'),
paym_type_id OPTIONS(description='The identifier for the way of payment, i.e. cash, card, voucher, etc.'),
fraud_detection_relevant_fg OPTIONS(description='The identifier of fraud detection relevant receipts.'),
prod_return_reason_sid
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt OPTIONS(description='A free text field describing the circumstances of the return.'), parent_retail_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_2 or return of products..'),
unit_price
OPTIONS(description='The price of a single unit_2 of the product variant, in the currency indicated by the currency code.'),
prod_variant_cnt
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
base_gross_val
OPTIONS(description='The base gross amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts or price modifications are not considered.'),
retail_line_gross_val
OPTIONS(description='The gross amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts and price changes are considered.'),
retail_line_vat_val OPTIONS(description='The total amount of value added tax which was charged for this line.'),
local_paym_val
OPTIONS(description='The amount which was paid in local currency. If the amount was paid by the customer, the sign is positive. If the amount was paid to the customer, the sign is negative. If the payment was in a foreign currency, this is the local currency equivalent.'),
txn_gross_val
OPTIONS(description='The total gross amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_vat_val
OPTIONS(description='The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)'),
tax_pct OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
cash_register_event_seq
OPTIONS(description='Is a sequence number partition by: real_estate_sid ,bus_dt ,cashier_hash and order by event_end_tmsp.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
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
orig_cash_register_event_sid OPTIONS(description='THE ORIGINAL RECEIPT SURROGATE KEY'))
OPTIONS(DESCRIPTION = `KEEPS THE CASH REGISTER EVENTS WHICH ARE IDENTIFICATED FOR FRAUD DETECTION AND PRE- AND POST RECEIPTS FOR PRINTOUT.`)
AS WITH CTE_TRANSACTION_TYPES AS (SELECT retail_event_line_scenario_id,
     CASE
     WHEN retail_event_line_scenario_id = 480
     THEN 'Preisanzeige'
     ELSE CAST(retail_event_line_scenario_name AS STRING)
     END AS retail_event_line_scenario_name,
    retail_event_line_scenario_short_name,
    retail_event_line_scenario_descr
   FROM ldl_data_core_rel.t_retail_event_line_scenario_2 AS MAIN
   WHERE lang_cd = 'DE'
    AND retail_event_line_scenario_id NOT IN (SELECT ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS
        tech_cash_register_event_type_cd
       FROM ldl_data_core_rel.t_technical_cash_register_event_type_2 AS CRE
       WHERE lang_cd = 'DE'
       UNION ALL
       SELECT retail_event_scenario_id
       FROM ldl_data_core_rel.t_retail_event_scenario_2 AS RES
       WHERE lang_cd = 'DE')
   UNION ALL
   SELECT ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS retail_event_line_scenario_id,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_name,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_short_name,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_descr
   FROM ldl_data_core_rel.t_technical_cash_register_event_type_2 AS MAIN
   WHERE lang_cd = 'DE'
   UNION ALL
   SELECT retail_event_scenario_id AS retail_event_line_scenario_id,
    retail_event_scenario_name AS retail_event_line_scenario_name,
    retail_event_scenario_name AS retail_event_line_scenario_short_name,
    retail_event_scenario_descr AS retail_event_line_scenario_descr
   FROM ldl_data_core_rel.t_retail_event_scenario_2 AS MAIN
   WHERE lang_cd = 'DE') (SELECT CAST(MAIN.cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
   MAIN.cash_register_event_nr AS rel_cash_register_event_nr,
   MAIN.cashier_nr AS rel_cashier_nr,
    CASE
    WHEN COALESCE(d.double_val, 1) = 1
    THEN MAIN.cash_register_event_line_seq
    ELSE NULL
    END AS cash_register_event_line_seq,
   COALESCE(d.double_val, 1) AS cash_register_event_line_seq_dbl,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN MAIN.event_auth_by_nr
    WHEN COALESCE(d.double_val, 1) = 2
    THEN MAIN.event_auth_by_nr
    ELSE MAIN.line_auth_by_nr
    END AS auth_nr,
   MAIN.line_auth_by_nr,
   MAIN.event_auth_by_nr,
   MAIN.parent_line_seq,
   MAIN.retail_event_line_scenario_id,
   FORMAT_TIMESTAMP('%H:%M:%S', MAIN.event_start_tmsp) AS event_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', MAIN.event_end_tmsp) AS event_end_tmsp,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN FORMAT_DATE('%d.%m.%Y', MAIN.bus_dt)
    WHEN COALESCE(d.double_val, 1) = 1
    THEN FORMAT_TIMESTAMP('%H:%M:%S', MAIN.event_line_start_tmsp)
    ELSE FORMAT_TIMESTAMP('%H:%M:%S', MAIN.event_start_tmsp)
    END AS event_line_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', CASE
     WHEN COALESCE(d.double_val, 1) = 1
     THEN MAIN.event_line_end_tmsp
     ELSE MAIN.event_end_tmsp
     END) AS event_line_end_tmsp,
   MAIN.bus_dt AS rel_bus_dt,
   MAIN.store_sid AS rel_store_sid,
   MAIN.store_nr,
   MAIN.country_org_cd,
   MAIN.cash_register_nr,
   MAIN.prod_retail_line_type_cd,
   MAIN.prod_variant_sid,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN CAST(MAIN.cash_register_event_nr AS STRING)
    WHEN COALESCE(d.double_val, 1) = 2
    THEN ''
    ELSE CAST(COALESCE(MAIN.local_prod_nr, CAST(CAST(MAIN.cash_register_event_nr AS FLOAT64) * 1000 + MAIN.cash_register_event_line_seq
        AS STRING)) AS STRING)
    END AS local_prod_nr,
   MAIN.prod_variant_input_nr,
   MAIN.prod_variant_input_nr_type_cd,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN CAST(MAIN.cash_register_event_nr AS STRING)
    WHEN COALESCE(d.double_val, 1) = 2
    THEN ''
    ELSE CAST(MAIN.local_prod_nr AS STRING)
    END AS displayed_prod_variant_name_title,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN CAST('>> ' || header_sce.retail_event_line_scenario_name || ' <<' AS STRING)
    WHEN COALESCE(d.double_val, 1) = 2
    THEN ''
    ELSE CAST(COALESCE(MAIN.prod_name, line_sce.retail_event_line_scenario_name) AS STRING)
    END AS displayed_prod_variant_name,
   MAIN.prod_entry_method_cd,
   MAIN.price_entry_method_cd,
   MAIN.paym_line_type_cd,
   MAIN.paym_type_id,
   MAIN.fraud_detection_relevant_fg,
   MAIN.prod_return_reason_sid,
   MAIN.return_txt,
   MAIN.parent_retail_event_sid,
   MAIN.unit_price,
   MAIN.prod_variant_cnt,
   MAIN.prod_variant_qty,
   MAIN.base_gross_val,
   MAIN.retail_line_gross_val,
   MAIN.retail_line_vat_val,
   MAIN.local_paym_val,
   MAIN.tax_line_gross_val AS txn_gross_val,
   MAIN.tax_line_val AS txn_vat_val,
   MAIN.tax_pct,
   MAIN.cash_register_event_seq,
   MAIN.dwh_created_tmsp,
   MAIN.dwh_updated_tmsp,
   MAIN.dwh_load_id,
   MAIN.dwh_node_cd,
   MAIN.orig_country_org_cd,
   MAIN.orig_store_nr,
   MAIN.orig_bus_dt,
   MAIN.orig_cash_register_nr,
   MAIN.orig_cash_register_event_nr,
   MAIN.orig_cash_register_event_nr AS orig_cash_register_event_nr0
  FROM ldl_data_core_app_fraud_detection.t_cash_register_print_2 AS MAIN
   LEFT JOIN (SELECT TRUE AS base_val,
      0 AS double_val
     UNION ALL
     SELECT TRUE AS base_val,
      1 AS double_val
     UNION ALL
     SELECT TRUE AS base_val,
      2 AS double_val) AS d ON MAIN.first_line_of_event_fg = d.base_val AND MAIN.parent_line_seq = - 1
   LEFT JOIN CTE_TRANSACTION_TYPES AS line_sce ON MAIN.retail_event_line_scenario_id = line_sce.retail_event_line_scenario_id
    
   LEFT JOIN CTE_TRANSACTION_TYPES AS header_sce ON MAIN.cash_register_event_scenario_id = header_sce.retail_event_line_scenario_id
    );