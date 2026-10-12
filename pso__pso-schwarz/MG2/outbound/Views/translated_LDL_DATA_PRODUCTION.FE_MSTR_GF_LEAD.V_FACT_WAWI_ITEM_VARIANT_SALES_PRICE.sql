CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_wawi_item_variant_sales_price (int_org_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE INTERNAL ORGANIZATION.'), int_org_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE DISCRIMINATORS FOR INTERNAL ORGANIZATIONS.'), country_org_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE COUNTRY ORGANIZATION.'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY FOR WHICH THE RELATED COUNTRY ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
wawi_item_variant_sid OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) OF THE WAWI ITEM VARIANT.'),
wawi_item_sid OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) OF THE WAWI ITEM.'), dwh_valid_from_tmsp
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD BECAME VALID.'), dwh_valid_to_tmsp
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS NO LONGER VALID.'), dwh_valid_fg
OPTIONS(description='AN INDICATOR SHOWING THE CURRENT RECORD, I.E. WHERE THE CURRENT DATE IS BETWEEN DWH_VALID_FROM AND DWH_VALID_TO.'),
sales_net_price
OPTIONS(description='THE NET PRICE (I.E. EXCLUDING VAT) FOR WHICH PRODUCTS THAT ARE RELATED TO THE WAWI ITEM VARIANT ARE SOLD IN THE GIVEN STORE OR WAREHOUSE.'),
sales_gross_price
OPTIONS(description='THE GROSS PRICE (I.E. INCLUDING VAT) FOR WHICH PRODUCTS THAT ARE RELATED TO THE WAWI ITEM VARIANT ARE SOLD IN THE GIVEN STORE OR WAREHOUSE.'),
deposit_val
OPTIONS(description='THE DEPOSIT AMOUNT FOR THIS WAWI ITEM VARIANT. E.G. 25C FOR A PLASTIC BOTTLE. (THIS ATTRIBUTE IS ONLY FILLED, IF THERE IS A DEPOSIT.)'),
tax_pct
OPTIONS(description='THE ACTUAL TAX PERCENTAGE WHICH IS APPLICABLE FOR THE WAWI ITEM VARIANT IN THE GIVEN STORE OR WAREHOUSE. (IN CASE SEVERAL TAXES APPLY, THIS IS THE TOTAL TAX PERCENTAGE.)'),
curr_cd OPTIONS(description='THE CODE IDENTIFYING THE CURRENCY ACCORDING TO ISO-4217.'), dwh_created_tmsp
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED IN THE DATA WAREHOUSE.'), dwh_updated_tmsp
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED OR LAST UPDATED.'), dwh_load_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF THE BATCH LOAD WHICH HAS DONE THE LAST UPDATE TO THIS RECORD. (CLOSING A RECORD IN HISTORY WITHOUT UPDATING ANY PAYLOAD COLUMNS DOES NOT TRIGGER AN UPDATE OF THE DWH_LOAD_ID.)'),
dwh_node_cd
OPTIONS(description='THE CODE FOR THE SOURCE SYSTEM (OR SLICE OF SOURCE SYSTEM) FROM WHICH THIS RECORD WAS LOADED.')) AS
SELECT main.int_org_sid,
 main.int_org_type_cd,
 main.country_org_sid,
 main.country_org_cd,
 main.wawi_item_variant_sid,
 main.wawi_item_sid,
 main.dwh_valid_from_tmsp,
 main.dwh_valid_to_tmsp,
 main.dwh_valid_fg,
  main.sales_net_price / fer.exchange_rate AS sales_net_price,
  main.sales_gross_price / fer.exchange_rate AS sales_gross_price,
  main.deposit_val / fer.exchange_rate AS deposit_val,
 main.tax_pct,
 main.curr_cd,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_dim.t_fact_wawi_item_variant_sales_price AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg;