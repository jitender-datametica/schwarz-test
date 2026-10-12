/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_MARGIN_CONTRIBUTION_TARGET_REGIONAL
   GENERATED FROM POWERDESIGNER ON Mittwoch, 27. Dezember 2023 14:23:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_margin_contribution_target_regional (
bus_year BIGNUMERIC NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
is_wine_spirits_fg BOOL NOT NULL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
prod_size_type_group_cd STRING(5) NOT NULL
OPTIONS(description='A code for product size classification grouped in the bigger buckets -\'Kleinteil\',\'Großteil\', etc'),
pack_size_handle_group_cd STRING(5) NOT NULL
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
prod_food_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is a food or non food'),
brand_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand or not'),
prod_org_lvl_name STRING(50) NOT NULL
OPTIONS(description='The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization.'),
prod_promo_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product  is a part of a promotion or main assortment.'),
delivery_src_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for source location of product from where it is delivered i.e. from supplier or warehouse directly'),
ship_size_handle_group_cd STRING(10)
OPTIONS(description='A code used for the "Logistic part" of the DBR (Margin Contribution) Report. It divides the product size in types based on how they will be handled as packages (P_KT,P_GT,P_2MH ...  )'),
prod_size_handle_group_cd STRING(10)
OPTIONS(description='Product size classification defined by Controlling/PM. It divides the product size in types based on their dimensions (P_KT,P_GT,P_2MH, P_Sonst).            Necessary for evaluation of variable and fixed costs based on the size group.'),
tgt_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Qty of products planned to sell'),
tgt_revenue_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned Revenue before Returns'),
tgt_revenue_before_loss_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned Revenue excluding losses'),
tgt_cogs_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Cost of goods sold'),
tgt_delivery_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Delivery costs + cogs'),
tgt_return_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Qty of products returned'),
tgt_return_good_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Qty of products returned with batch 01 (goods that can be reselled)'),
tgt_return_damaged_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Qty of products returned with batch 02 or 03 ( scratched and damaged goods)'),
tgt_pack_qty BIGNUMERIC(38,5) OPTIONS(description='Qty of packages sent'),
tgt_return_pack_qty BIGNUMERIC(38,5) OPTIONS(description='Qty of packages returned'),
tgt_wh_costs_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs to manage warehouses'),
tgt_ship_revenue_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned revenues coming from shipping'),
tgt_ship_coupon_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Revenue lost because of shipping coupons'),
tgt_ship_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned Lidl costs for shipping and transport (order process)'),
tgt_return_prod_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Value of products returned'),
tgt_cogs_return_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Cost of goods sold of the products returned'),
tgt_tax_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs of taxes/vat/customs'),
tgt_write_off_loss_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned losses for write offs after return'),
tgt_price_change_loss_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned losses for price changes after return'),
tgt_coupon_change_loss_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Losses for price changes due to coupons'),
tgt_goodwill_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Goodwill costs'),
tgt_recycled_goods_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Value of products that are recycled and scrapped'),
tgt_stock_deval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Value lost from the stock for depreciation ( devaluation )'),
tgt_reimburs_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Reimbursement '),
tgt_personal_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for the personal'),
tgt_material_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for material '),
tgt_adv_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for advertisment'),
tgt_ic_income_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Intercompany income'),
tgt_ic_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Intercompany costs'),
tgt_corporate_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Corporate costs (e.g. Webpage)'),
tgt_other_material_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Other material costs'),
tgt_ship_total_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Sum of shipping costs/revenue'),
tgt_return_total_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Sum of returns costs/revenue (derived metric)'),
tgt_sellback_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Value of products that are recycled and scrapped that can be resold.'),
tgt_order_qty BIGNUMERIC(38,5) OPTIONS(description='Number of orders.'),
tgt_return_good_prod_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Value of products returned with batch 01 (goods that can be resold).'),
tgt_cogs_return_good_prod_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost of goods sold for products returned with batch 01 (goods that can be resold).'),
tgt_ext_storage_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for external storages.'),
tgt_transport_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Transportation costs for goods movement.'),
tgt_cogs_delivery_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Delivery costs + cogs (Derived metric: 17+18).'),
tgt_gross_margin_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned margin before return'),
tgt_return_ship_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned Lidl costs for shipping and transport (Return process)'),
tgt_adm_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned costs for Administration (support function)'),
tgt_it_wshop_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned costs for IT involved in webshop specific support operation'),
tgt_it_ic_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned costs for IT involved in Intercompany support operation'),
tgt_return_ship_revenue_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned costs coming from returns shipping'),
tgt_write_off_residual_util_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned losses for write offs (residual utilization) after return'),
tgt_write_off_discount_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned losses for write offs (discounts) after return'),
tgt_promo_price_change_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned losses for promotion price changes after return'),
tgt_perm_price_change_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned losses for permanent price changes after return'),
tgt_fin_compensation_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned costs for financial compensation to webshops'),
tgt_curr_tax_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned costs for taxation processes'),
tgt_common_fees_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned costs for common fees (e.g. license fees, purchasing fees, service fees) (accounted on cust_order_perform_dt)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bus_year, month_of_bus_year, wshop_cd, is_wine_spirits_fg, prod_size_type_group_cd,
 pack_size_handle_group_cd, prod_food_class_cd, brand_class_cd, prod_org_lvl_name, prod_promo_class_cd,
 delivery_src_type_cd) NOT ENFORCED
) OPTIONS(description='The table contains planned contribution margin per webshop (planned costs and revenues )');