CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_product_retail_line_2 (retail_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_2 or return of products..'),
retail_event_line_seq OPTIONS(description='The number of the line in the retail event.'), event_start_tmsp
OPTIONS(description='The point in time when the scanning (or the manual input) of the article started.'), event_end_tmsp
OPTIONS(description='The point in time when the scanning (or the manual input) of the article was finished.'), cal_dt
OPTIONS(description='The business date on which the retail event is counted.'), retail_event_end_tmsp
OPTIONS(description='The point in time when the related retail event was finished.'), store_sid
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
real_estate_sid OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
cash_register_sid
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_hash
OPTIONS(description='The encrypted number of the cashier. (The hash is unique for a given store and a day.)'),
auth_by_hash
OPTIONS(description='In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the encrypted number which identifies the employee_2, who has authorized the transaction. (The hash is unique for a given store and a day.)'),
cust_sid OPTIONS(description='The unique identifier (surrogate key) for the customer.'), prod_retail_line_type_cd
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
retail_event_line_scenario_id
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
sales_variant_sid OPTIONS(description='The unique identifier (surrogate key) for a sales_2 variant of a product.'),
wawi_item_sid
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item_2 which represents the sales_2 variant which is sold.'),
local_prod_nr
OPTIONS(description='The number which identifies the product in the operational retail management system within the given market / internal organization (i.e. the local item_2 number).  Note that the product number is unique for a certain point in time, but may be re_2-used later on. One product may be identified by several numbers in case of parallel listings or rolling listings. This is the number which has been configured in the cash registers of the given stores for the point in time when the retail transaction was made.'),
prod_variant_input_nr
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_2, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_2, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name OPTIONS(description='The name of the product variant, as it is printed on the receipt.'),
weight_based_fg
OPTIONS(description='An indicator showing, if the product variant was sold (or returned) by weight instead of count.'),
prod_variant_cnt
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
uom_cd OPTIONS(description='The code identifying the unit_2 of measure.'), unit_price
OPTIONS(description='The price of a single unit_2 of the product variant, in the currency indicated by the currency code.'),
base_gross_val
OPTIONS(description='The base gross amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts or price modifications are not considered.'),
retail_line_gross_val
OPTIONS(description='The gross amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts and price changes are considered.'),
retail_line_net_val
OPTIONS(description='The net amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts and price changes are considered. (This is a calculated amount!)'),
retail_line_vat_val OPTIONS(description='The total amount of value added tax which was charged for this line.'),
tax_class_cd OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'), geo_area_sid
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_pct OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'), curr_cd
OPTIONS(description='The code identifying the currency, according to ISO 4217.'), turnover_relevant_fg
OPTIONS(description='An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'),
discount_fg
OPTIONS(description='An indicator showing, if a discount or a price modification was applied to the product.'),
prod_entry_method_cd
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd
OPTIONS(description='The code identifying the way, how the unit_2 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
prod_return_reason_sid
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt OPTIONS(description='A free text field describing the circumstances of the return.'), orig_sales_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the sales_2 transaction in which the returned product was sold.'),
orig_sales_event_nr
OPTIONS(description='The sequence number of the sales_2 transaction in which the returned product was sold. (It is unique to the cash register, but might be re_2-cycled after some time.)'),
parent_line_seq OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cancel_line_seq
OPTIONS(description='In case the product retail line is cancelled, this is the number of the related cancellation line.'),
curr_group_fg OPTIONS(description='Flag for Group Currency'), curr_local_fg
OPTIONS(description='Flag for Local Currency'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT main.retail_event_sid,
 main.retail_event_line_seq,
 main.event_start_tmsp,
 main.event_end_tmsp,
 main.bus_dt AS cal_dt,
 main.retail_event_end_tmsp,
 main.store_sid,
 main.country_org_sid,
 main.country_org_cd,
 main.real_estate_sid,
 main.cash_register_sid,
 main.cash_register_type_cd,
 main.cash_register_usg_type_cd,
 main.cashier_hash,
 main.auth_by_hash,
 main.cust_sid,
 main.prod_retail_line_type_cd,
 main.retail_event_line_scenario_id,
 main.prod_variant_sid AS sales_variant_sid,
 main.wawi_item_sid,
 main.local_prod_nr,
 main.prod_variant_input_nr,
 main.prod_variant_input_nr_type_cd,
 main.displayed_prod_variant_name,
 main.weight_based_fg,
 main.prod_variant_cnt,
 main.prod_variant_qty,
 main.uom_cd,
 main.unit_price,
 main.base_gross_val,
 main.retail_line_gross_val,
  main.retail_line_net_val / fer.exchange_rate AS retail_line_net_val,
 main.retail_line_vat_val,
 main.tax_class_cd,
 main.geo_area_sid,
 main.tax_pct,
 main.curr_cd,
 main.turnover_relevant_fg,
 main.discount_fg,
 main.prod_entry_method_cd,
 main.price_entry_method_cd,
 main.prod_return_reason_sid,
 main.return_txt,
 main.orig_sales_event_sid,
 main.orig_sales_event_nr,
 main.parent_line_seq,
 main.cancel_line_seq,
  CASE
  WHEN fer.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN fer.src_curr_cd = fer.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_rel.t_product_retail_line_2 AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg;