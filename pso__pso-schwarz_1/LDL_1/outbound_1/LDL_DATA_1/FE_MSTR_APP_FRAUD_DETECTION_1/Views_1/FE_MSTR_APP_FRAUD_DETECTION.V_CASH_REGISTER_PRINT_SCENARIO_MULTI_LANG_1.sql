CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_cash_register_print_scenario_multi_lang_1 (country_org_sid
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
OPTIONS(description='The number of the line in the retail event, in the case of the techical event or price information event is the value always "-1"'),
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
orig_cash_register_event_sid OPTIONS(description='THE ORIGINAL RECEIPT SURROGATE KEY'))
OPTIONS(DESCRIPTION = `KEEPS THE CASH REGISTER EVENTS AT METRIC AND SCENARIO LEVEL WHICH ARE IDENTIFICATED FOR FRAUD DETECTION AND PRE- AND POST RECEIPTS FOR PRINTOUT.`)
AS WITH CTE_CLS_REL_CASH_REGISTER AS (SELECT t1.cash_register_event_sid_ow AS cash_register_event_sid,
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
      'SELF' AS cash_register_event_rel_type_cd
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_1 AS REL
      INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS CLS ON REL.bus_dt = CLS.bus_dt
          AND REL.country_org_cd = CLS.country_org_cd AND REL.cash_register_event_sid = CLS.cash_register_event_sid
     WHERE CLS.scenario_id IN (6, 60100, 60200, 60300, 52, 51)
      AND REL.cash_register_event_rel_type_cd IN ('SELF', 'SUCCESSOR', 'EVENT_AROUND_LOGOFF', 'SUCC_ALL_NPI_EVENTS')) AS
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
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_1 AS REL
      INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS CLS ON REL.bus_dt = CLS.bus_dt
          AND REL.country_org_cd = CLS.country_org_cd AND REL.cash_register_event_sid = CLS.cash_register_event_sid
     WHERE CLS.scenario_id IN (12, 120100, 120200, 120300, 120400, 120600, 120700, 120800, 120900)
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
   FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_1 AS REL
    INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS CLS ON REL.bus_dt = CLS.bus_dt
      AND REL.country_org_cd = CLS.country_org_cd AND REL.cash_register_event_sid = CLS.cash_register_event_sid
   WHERE CLS.scenario_id NOT IN (6, 60100, 60200, 60300, 12, 120100, 120200, 120300, 120400, 120600, 120700, 120800,
      120900, 52, 51)), CTE_RETURN_SAME_ORIGINAL AS (SELECT country_org_cd,
   bus_dt,
   cash_register_event_sid,
   SUM(1) AS rel_cnt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_1 AS CER
  GROUP BY country_org_cd,
   bus_dt,
   cash_register_event_sid) (SELECT org.country_org_sid,
   cls.scenario_id,
   cls.cust_sid,
   cls.cust_ident_type_cd,
   CAST(cls.cash_register_event_sid AS STRING) AS cash_register_event_sid,
   cls.cash_register_event_nr,
   cls.cashier_nr,
   cls.bus_dt,
   cls.store_sid,
   CAST(cls.rel_cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
   MAIN.cash_register_event_nr AS rel_cash_register_event_nr,
   MAIN.cashier_nr AS rel_cashier_nr,
   MAIN.cash_register_event_line_seq,
   1 AS cash_register_event_line_seq_dbl,
   MAIN.event_auth_by_nr,
   MAIN.line_auth_by_nr,
   MAIN.event_auth_by_nr AS event_auth_by_nr0,
   MAIN.parent_line_seq,
   MAIN.retail_event_line_scenario_id,
   FORMAT_TIMESTAMP('%H:%M:%S', MAIN.event_start_tmsp) AS event_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', MAIN.event_end_tmsp) AS event_end_tmsp,
    CASE
    WHEN MAIN.retail_event_line_scenario_id = 855
    THEN MAIN.event_end_tmsp
    ELSE MAIN.event_line_start_tmsp
    END AS event_line_start_tmsp,
   MAIN.event_line_end_tmsp,
   MAIN.bus_dt AS rel_bus_dt,
   MAIN.store_sid AS rel_store_sid,
   MAIN.store_nr,
   MAIN.country_org_cd,
   MAIN.cash_register_nr,
   MAIN.prod_retail_line_type_cd,
   SAL_VAR.prod_sid,
   MAIN.prod_variant_sid,
   MAIN.local_prod_nr,
   MAIN.prod_variant_input_nr,
   MAIN.prod_variant_input_nr_type_cd,
   MAIN.local_prod_nr AS displayed_prod_variant_name_title,
   MAIN.prod_name AS displayed_prod_variant_name,
   MAIN.prod_entry_method_cd,
   MAIN.price_entry_method_cd,
   MAIN.paym_line_type_cd,
   MAIN.paym_type_id,
   MAIN.fraud_detection_relevant_fg,
   MAIN.prod_return_reason_sid,
   MAIN.return_txt,
   MAIN.parent_retail_event_sid,
    CASE
    WHEN MAIN.cash_register_event_scenario_id = 480
    THEN MAIN.unit_price
    ELSE MAIN.unit_price
    END AS unit_price,
    CASE
    WHEN MAIN.cash_register_event_scenario_id = 480
    THEN 1
    ELSE MAIN.prod_variant_cnt
    END AS prod_variant_cnt,
   MAIN.prod_variant_qty,
   MAIN.base_gross_val,
    CASE
    WHEN MAIN.cash_register_event_scenario_id = 480
    THEN MAIN.unit_price
    ELSE MAIN.retail_line_gross_val
    END AS retail_line_gross_val,
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
   MAIN.cash_register_event_scenario_id,
   MAIN.orig_country_org_cd,
   MAIN.orig_store_nr,
   MAIN.orig_bus_dt,
   MAIN.orig_cash_register_nr,
   MAIN.orig_cash_register_event_nr,
   MAIN.orig_cash_register_event_nr AS orig_cash_register_event_nr0
  FROM ldl_data_core_app_fraud_detection.t_fraud_detection_suspicious_cash_register_event_1 AS SUSP
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS ORG_SUSP ON SUSP.store_sid = ORG_SUSP.int_org_sid AND
    ORG_SUSP.dwh_valid_fg
   INNER JOIN CTE_CLS_REL_CASH_REGISTER AS cls ON SUSP.bus_dt = cls.bus_dt AND ORG_SUSP.country_org_cd = cls.country_org_cd
        AND SUSP.cash_register_event_sid = cls.cash_register_event_sid AND SUSP.scenario_id = cls.scenario_id
   INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_scenario_to_relationship_type_1 AS RL ON cls.scenario_id
      = RL.scenario_id AND cls.cash_register_event_rel_type_cd = RL.cash_register_event_rel_type_cd
   LEFT JOIN CTE_RETURN_SAME_ORIGINAL AS sce_check ON cls.bus_dt = sce_check.bus_dt AND cls.cash_register_event_sid =
       sce_check.cash_register_event_sid AND cls.country_org_cd = sce_check.country_org_cd AND (cls.scenario_id = 8 AND
        sce_check.rel_cnt >= 3 OR cls.scenario_id <> 8)
   INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_print_1 AS MAIN ON cls.rel_bus_dt = MAIN.bus_dt AND cls.country_org_cd
       = MAIN.country_org_cd AND cls.rel_cash_register_event_sid = MAIN.cash_register_event_sid
   LEFT JOIN ldl_data_core_dim.t_dim_sales_variant_1 AS SAL_VAR ON MAIN.prod_variant_sid = SAL_VAR.sales_variant_sid AND
    SAL_VAR.dwh_valid_fg
   INNER JOIN (SELECT country_org_sid
    FROM ldl_data_core_dim.t_dim_internal_organization_1 AS ORG
    WHERE dwh_valid_fg
     AND is_country_org_fg) AS org ON TRUE);