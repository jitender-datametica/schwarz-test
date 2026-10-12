CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_print_scenario_multi_lang_all_1 (print_type
OPTIONS(description='Extra column for print all receipts'), country_org_sid
OPTIONS(description='The unique identifier of the organzation country_1'), scenario_id
OPTIONS(description='The unique identifier of fraud detection scenario'), cust_sid
OPTIONS(description='The unique identifier (surrogate key) for the customer.'), cust_ident_type_cd
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
cash_register_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
cash_register_event_nr
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
cashier_nr
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
bus_dt OPTIONS(description='The business date on which the retail event is counted.'), store_sid
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
rel_cash_register_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
rel_cash_register_event_nr
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
rel_cashier_nr
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
cash_register_event_line_seq
OPTIONS(description='The number of the line in the retail event, in the case of the techical event or price information event is the value always\""-1\""'),
cash_register_event_line_seq_dbl OPTIONS(description='The duplicates of the first row for formatting at frontend'),
auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
line_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
event_auth_by_nr
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
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
OPTIONS(description='The code of the related business country. (The business country_1 is not identical to a political country.)'),
cash_register_nr OPTIONS(description='The number which identifies the cash register.'), prod_retail_line_type_cd
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'), prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product, which is the base for this sales_1 variant.'),
prod_variant_sid OPTIONS(description='The unique identifier (surrogate key) for a sales_1 variant of a product.'),
local_prod_nr
OPTIONS(description='The number which identifies the product in the operational retail management system within the given market / internal organization (i.e. the local item_1 number).  Note that the product number is unique for a certain point in time, but may be re_1-used later on. One product may be identified by several numbers in case of parallel listings or rolling listings. This is the number which has been configured in the cash registers of the given stores for the point in time when the retail transaction was made.'),
prod_variant_input_nr
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name_title
OPTIONS(description='The title of display name if it is receipt number or product number'), displayed_prod_variant_name
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'), prod_entry_method_cd
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd
OPTIONS(description='The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
paym_line_type_cd
OPTIONS(description='The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.'),
paym_type_id OPTIONS(description='The identifier for the way of payment, i.e. cash, card, voucher, etc.'),
fraud_detection_relevant_fg OPTIONS(description='The identifier of fraud detection relevant receipts.'),
prod_return_reason_sid
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt OPTIONS(description='A free text field describing the circumstances of the return.'), parent_retail_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
unit_price
OPTIONS(description='The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'),
prod_variant_cnt
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
base_gross_val
OPTIONS(description='The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'),
retail_line_gross_val
OPTIONS(description='The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'),
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
cash_register_event_scenario_id OPTIONS(description='The main transaction type code like return, sales_1, abort ...'),
orig_country_org_cd
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this column contains the country_1 information of the original receipt.'),
orig_store_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the store number of the original receipt.'),
orig_bus_dt
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the business date of the original receipt.'),
orig_cash_register_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
orig_cash_register_event_nr
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
orig_cash_register_event_sid OPTIONS(description='THE ORIGINAL RECEIPT SURROGATE KEY')) AS WITH
 cte_cls_rel_cash_register AS (SELECT t1.cash_register_event_sid_ow AS cash_register_event_sid,
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
        WHEN rel.cash_register_event_rel_type_cd = 'SUCCESSOR'
        THEN rel.rel_cash_register_event_sid
        ELSE 0
        END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      AS cash_register_event_sid_ow,
      cls.scenario_id,
      cls.cust_sid,
      cls.cust_ident_type_cd,
      ROUND(CAST(RIGHT(SUBSTR(CAST(MAX(CASE
             WHEN rel.cash_register_event_rel_type_cd = 'SUCCESSOR'
             THEN rel.rel_cash_register_event_sid
             ELSE 0
             END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING), 1, 10), 10) AS BIGNUMERIC)
       , 0) AS cash_register_event_nr,
      cls.cashier_nr,
      cls.bus_dt,
      cls.store_sid,
      cls.country_org_cd,
       CASE
       WHEN rel.cash_register_event_rel_type_cd = 'SELF'
       THEN rel.cash_register_event_sid
       ELSE rel.rel_cash_register_event_sid
       END AS rel_cash_register_event_sid,
      rel.rel_bus_dt,
      rel.cash_register_event_rel_type_cd
     FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_1 AS rel
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_1 AS cls ON rel.bus_dt
         = cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
        
     WHERE cls.scenario_id IN (6, 60100, 60200, 60300)
      AND rel.cash_register_event_rel_type_cd IN ('SELF', 'SUCCESSOR', 'EVENT_AROUND_LOGOFF', 'SUCC_ALL_NPI_EVENTS')) AS
    t1_1
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
        WHEN rel.cash_register_event_rel_type_cd = 'SELF'
        THEN 0
        ELSE rel.rel_cash_register_event_sid
        END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      AS cash_register_event_sid_ow,
      cls.scenario_id,
      cls.cust_sid,
      cls.cust_ident_type_cd,
      ROUND(CAST(RIGHT(SUBSTR(CAST(MAX(CASE
             WHEN rel.cash_register_event_rel_type_cd = 'SELF'
             THEN 0
             ELSE rel.rel_cash_register_event_sid
             END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING)
          , 1, 10), 10) AS BIGNUMERIC), 0) AS cash_register_event_nr,
      cls.cashier_nr,
      cls.bus_dt,
      cls.store_sid,
      cls.country_org_cd,
       CASE
       WHEN rel.cash_register_event_rel_type_cd = 'SELF'
       THEN rel.cash_register_event_sid
       ELSE rel.rel_cash_register_event_sid
       END AS rel_cash_register_event_sid,
      rel.rel_bus_dt,
      rel.cash_register_event_rel_type_cd
     FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_1 AS rel
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_1 AS cls ON rel.bus_dt
         = cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
        
     WHERE cls.scenario_id IN (12, 120100, 120200, 120300, 120400, 120600, 120700, 120800, 120900)
      AND rel.cash_register_event_rel_type_cd IN ('SELF', 'ORIGINAL')) AS t5
   UNION ALL
   SELECT cls.cash_register_event_sid,
    cls.scenario_id,
    cls.cust_sid,
    cls.cust_ident_type_cd,
    ROUND(CAST(cls.cash_register_event_nr AS BIGNUMERIC), 0) AS cash_register_event_nr,
    cls.cashier_nr,
    cls.bus_dt,
    cls.store_sid,
    cls.country_org_cd,
    rel.rel_cash_register_event_sid,
    rel.rel_bus_dt,
    rel.cash_register_event_rel_type_cd
   FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_1 AS rel
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_1 AS cls ON rel.bus_dt =
       cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
      
   WHERE cls.scenario_id NOT IN (6, 60100, 60200, 60300, 12, 120100, 120200, 120300, 120400, 120600, 120700, 120800,
      120900)), cte_return_same_original AS (SELECT country_org_cd,
   bus_dt,
   cash_register_event_sid,
   SUM(1) AS rel_cnt
  FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_1 AS cer
  GROUP BY country_org_cd,
   bus_dt,
   cash_register_event_sid) (SELECT 'ALL',
   org.country_org_sid,
   cls.scenario_id,
   cls.cust_sid,
   cls.cust_ident_type_cd,
   CAST(cls.cash_register_event_sid AS STRING) AS cash_register_event_sid,
   cls.cash_register_event_nr,
   cls.cashier_nr,
   cls.bus_dt,
   cls.store_sid,
   CAST(cls.rel_cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
   main.cash_register_event_nr AS rel_cash_register_event_nr,
   main.cashier_nr AS rel_cashier_nr,
   main.cash_register_event_line_seq,
   1 AS cash_register_event_line_seq_dbl,
   main.event_auth_by_nr,
   main.line_auth_by_nr,
   main.event_auth_by_nr AS event_auth_by_nr0,
   main.parent_line_seq,
   main.retail_event_line_scenario_id,
   FORMAT_TIMESTAMP('%H:%M:%S', main.event_start_tmsp) AS event_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', main.event_end_tmsp) AS event_end_tmsp,
    CASE
    WHEN main.retail_event_line_scenario_id = 855
    THEN main.event_end_tmsp
    ELSE main.event_line_start_tmsp
    END AS event_line_start_tmsp,
   main.event_line_end_tmsp,
   main.bus_dt AS rel_bus_dt,
   main.store_sid AS rel_store_sid,
   main.store_nr,
   main.country_org_cd,
   main.cash_register_nr,
   main.prod_retail_line_type_cd,
   sal_var.prod_sid,
   main.prod_variant_sid,
   main.local_prod_nr,
   main.prod_variant_input_nr,
   main.prod_variant_input_nr_type_cd,
   main.local_prod_nr AS displayed_prod_variant_name_title,
   main.prod_name AS displayed_prod_variant_name,
   main.prod_entry_method_cd,
   main.price_entry_method_cd,
   main.paym_line_type_cd,
   main.paym_type_id,
   main.fraud_detection_relevant_fg,
   main.prod_return_reason_sid,
   main.return_txt,
   main.parent_retail_event_sid,
    CASE
    WHEN main.cash_register_event_scenario_id = 480
    THEN main.tax_line_gross_val
    ELSE main.unit_price
    END AS unit_price,
    CASE
    WHEN main.cash_register_event_scenario_id = 480
    THEN 1
    ELSE main.prod_variant_cnt
    END AS prod_variant_cnt,
   main.prod_variant_qty,
   main.base_gross_val,
    CASE
    WHEN main.cash_register_event_scenario_id = 480
    THEN main.tax_line_gross_val
    ELSE main.retail_line_gross_val
    END AS retail_line_gross_val,
   main.retail_line_vat_val,
   main.local_paym_val,
   main.tax_line_gross_val AS txn_gross_val,
   main.tax_line_val AS txn_vat_val,
   main.tax_pct,
   main.cash_register_event_seq,
   main.dwh_created_tmsp,
   main.dwh_updated_tmsp,
   main.dwh_load_id,
   main.dwh_node_cd,
   main.cash_register_event_scenario_id,
   main.orig_country_org_cd,
   main.orig_store_nr,
   main.orig_bus_dt,
   main.orig_cash_register_nr,
   main.orig_cash_register_event_nr,
   main.orig_cash_register_event_nr AS orig_cash_register_event_nr0
  FROM cte_cls_rel_cash_register AS cls
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_scenario_to_relationship_type_1 AS rl ON
     cls.scenario_id = rl.scenario_id AND cls.cash_register_event_rel_type_cd = rl.cash_register_event_rel_type_cd
   LEFT JOIN cte_return_same_original AS sce_check ON cls.bus_dt = sce_check.bus_dt AND cls.cash_register_event_sid =
       sce_check.cash_register_event_sid AND cls.country_org_cd = sce_check.country_org_cd AND (cls.scenario_id = 8 AND
        sce_check.rel_cnt >= 3 OR cls.scenario_id <> 8)
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_print_1 AS main ON cls.rel_bus_dt = main.bus_dt
       AND cls.country_org_cd = main.country_org_cd AND cls.rel_cash_register_event_sid = main.cash_register_event_sid
   LEFT JOIN ldl_data_production_core_dim.t_dim_sales_variant_1 AS sal_var ON main.prod_variant_sid = sal_var.sales_variant_sid
      AND sal_var.dwh_valid_fg
   INNER JOIN (SELECT country_org_sid
    FROM ldl_data_production_core_dim.t_dim_internal_organization_1 AS org
    WHERE dwh_valid_fg
     AND is_country_org_fg) AS org ON TRUE);