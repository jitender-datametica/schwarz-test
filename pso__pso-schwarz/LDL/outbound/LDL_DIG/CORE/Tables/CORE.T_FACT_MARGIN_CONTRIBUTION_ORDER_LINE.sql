/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_MARGIN_CONTRIBUTION_ORDER_LINE
   GENERATED FROM POWERDESIGNER ON Dienstag, 25. Februar 2025 16:47:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_margin_contribution_order_line (
cust_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The particular position number of an item in an order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_dt DATE OPTIONS(description='The date when order was made'),
cust_order_perform_dt DATE
OPTIONS(description='The timestamp when the delivery to the customer actually started. This timestamp is relevant from a financial perspective as until then you are not allowed to charge him/her. In case of serveral performance timestamps for a single article within a single order the last date is picked.'),
cust_order_return_dt DATE OPTIONS(description='The date when return was made'),
cust_order_goodwill_dt DATE OPTIONS(description='The date when goodwill was made'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
is_bundle_header_fg BOOL
OPTIONS(description='Indicates if position represents a bundle header ( null in all the other cases)'),
bundle_header_pos_nr BIGNUMERIC(38,0)
OPTIONS(description='In case of a line being a composition part of the bundle-header (see bundle header code field), it can be allocated with this field to its header item'),
bundle_header_prod_variant_sid BIGNUMERIC
OPTIONS(description='Unique Identifier for the product variant of the bundle header to which this bundle item belongs'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
prod_variant_sid BIGNUMERIC OPTIONS(description='Ordered product'),
is_wine_spirits_fg BOOL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
pack_size_handle_group_cd STRING(5)
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
prod_size_type_group_cd STRING(5)
OPTIONS(description='A code for product size classification grouped in the bigger buckets -\'Kleinteil\',\'Großteil\', etc'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location of product from where it is delivered i.e. from supplier or warehouse directly'),
prod_food_class_cd STRING(5) OPTIONS(description='The code for the indicating if product is a food or non food'),
brand_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand or not'),
prod_org_lvl_name STRING(50)
OPTIONS(description='The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization.'),
prod_promo_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product  is a part of a promotion or main assortment.'),
prod_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product'),
ship_size_handle_group_cd STRING(10)
OPTIONS(description='A code used for the "Logistic part" of the DBR (Margin Contribution) Report. It divides the product size in types based on how they will be handled as packages (P_KT,P_GT,P_2MH ...  )'),
prod_size_handle_group_cd STRING(10)
OPTIONS(description='Product size classification defined by Controlling/PM. It divides the product size in types based on their dimensions (P_KT,P_GT,P_2MH, P_Sonst).            Necessary for evaluation of variable and fixed costs based on the size group.'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Qty of products planned to sell (accounted on cust_order_perform_dt)'),
revenue_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned Revenue before Returns (accounted on cust_order_perform_dt)'),
revenue_before_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned Revenue excluding losses (accounted on cust_order_perform_dt)'),
cogs_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Cost of goods sold (accounted on cust_order_perform_dt)'),
return_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Qty of products returned (accounted on cust_order_return_dt)'),
pack_qty_mf BIGNUMERIC(38,5)
OPTIONS(description='Qty of MF packages sent (MF = small packages) (accounted on cust_order_perform_dt)'),
return_pack_qty_mf BIGNUMERIC(38,5)
OPTIONS(description='Qty of MF packages returned (MF = small packages) (accounted on cust_order_return_dt)'),
pack_qty_nmf BIGNUMERIC(38,5)
OPTIONS(description='Qty of NMF packages sent (NMF = bulky items) (accounted on cust_order_perform_dt)'),
return_pack_qty_nmf BIGNUMERIC(38,5)
OPTIONS(description='Qty of NMF packages returned (NMF = bulky items) (accounted on cust_order_return_dt)'),
pack_qty_2mh BIGNUMERIC(38,5)
OPTIONS(description='Qty of 2MH packages sent (2MH = 2 man handling packages) (accounted on cust_order_perform_dt)'),
return_pack_qty_2mh BIGNUMERIC(38,5)
OPTIONS(description='Qty of 2MH packages returned (2MH = 2 man handling packages) (accounted on cust_order_return_dt)'),
wh_costs_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Costs to manage warehouses (accounted on cust_order_perform_dt)'),
ship_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue lost because of shipping coupons (accounted on cust_order_perform_dt)'),
branch_ship_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue lost because of shipping coupons given by Filiale (physical shops) (accounted on cust_order_perform_dt)'),
return_prod_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Value of products returned (accounted on cust_order_return_dt)'),
cogs_return_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost of goods sold of the products returned (accounted on cust_order_return_dt)'),
coupon_change_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for price changes due to coupons generated as part of marketing campaign (accounted on cust_order_perform_dt)'),
prod_with_coupon_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of sold products with a coupon discount applied.  (accounted on cust_order_perform_dt)'),
gross_margin_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Calculated gross margin, equal to the net revenue from the product variant sales minus the associated cost of goods sold  (accounted on cust_order_perform_dt)'),
ship_paushal_revenue_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue from shipping costs (delivery paushal)  (accounted on cust_order_perform_dt)'),
ship_surcharge_revenue_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue from shipping costs (additional delivery costs)  (accounted on cust_order_perform_dt)'),
return_ship_paushal_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost generated by returning shipping costs to the customer (delivery paushal) (accounted on cust_order_return_dt)'),
return_ship_surcharge_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost generated by returning shipping costs to the customer (additional delivery costs) (accounted on cust_order_return_dt)'),
goodwill_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost of credit notes issued by the seller as a goodwill for reimbursing customers who received the item and kept it, but were not satisfied for some reason (scratches, minor transport defects, found it cheaper in another place...). These are usually partial refunds. The amount is in NET (exlc taxes) value, in euro. Accounted on cust_order_goodwill_dt'),
value_credit_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost of credit notes issued by the seller for reimbursing customers who received the item but did not choose to keep it (it was broken, returned, etc..). These are full refunds. The amount is in NET (exlc taxes) value, in euro. Accounted on cust_order_goodwill_dt'),
ghost_pack_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost of credit notes issued by the seller for reimbursing customers for "ghost" packages (packages lost before they reach the delivery company). The amount is in NET (excl. taxes) value, in euro. Accounted on cust_order_goodwill_dt'),
pack_lost_by_hauler_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost of credit notes issued by the seller for reimbursing customers for lost packages (lost by the delivery company). The amount is in NET (excl. taxes) value, in euro. Accounted on cust_order_goodwill_dt'),
common_fees_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Amount of common fees (e.g. license fees, purchasing fees, service fees) (accounted on cust_order_perform_dt)'),
sellback_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Value of products that are recycled and scrapped that can be resold. (accounted on cust_order_return_dt)'),
write_off_residual_util_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for write offs (residual utilization) (accounted on cust_order_perform_dt)'),
write_off_discount_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for write offs (discounts) (accounted on cust_order_perform_dt)'),
promo_price_change_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for promotion price changes  (accounted on cust_order_perform_dt)'),
perm_price_change_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for permanent price changes  (accounted on cust_order_perform_dt)'),
return_ship_cost_mf_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Lidl costs for shipping and transport (Return process) for MF packages (MF = small packages) (accounted on cust_order_return_dt)'),
ship_cost_mf_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Lidl costs for shipping and transport for MF packages (MF = small packages)  (accounted on cust_order_perform_dt)'),
return_ship_cost_nmf_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Lidl costs for shipping and transport (Return process) for NMF packages (NMF = bulky items) (accounted on cust_order_return_dt)'),
ship_cost_nmf_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Lidl costs for shipping and transport for NMF packages (NMF = bulky items)  (accounted on cust_order_perform_dt)'),
return_ship_cost_2mh_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Lidl costs for shipping and transport (Return process) for 2MH packages (2MH = 2 man handling packages) (accounted on cust_order_return_dt)'),
ship_cost_2mh_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Lidl costs for shipping and transport for 2MH packages (2MH = 2 man handling packages)  (accounted on cust_order_perform_dt)'),
return_good_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Qty of products returned with batch 01 (goods that can be resold) (accounted on cust_order_return_dt)'),
return_for_service_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Qty of products returned with batch 02 (goods to be proofed) (accounted on cust_order_return_dt)'),
return_damaged_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Qty of products returned with batch 003 ( scratched and damaged goods) (accounted on cust_order_return_dt)'),
return_write_off_residual_util_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for write offs (residual utilization) from returns (accounted on cust_order_return_dt)'),
return_write_off_discount_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for write offs (discounts) from returns  (accounted on cust_order_return_dt)'),
return_promo_price_change_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for promotion price changes  from returns (accounted on cust_order_return_dt)'),
return_perm_price_change_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses for permanent price changes from returns (accounted on cust_order_return_dt)'),
return_coupon_change_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The amount of money gained back when a returned product was bought using a coupon for a marketing campaign (accounted on cust_order_return_dt). Example: customer buys a t-shirt for 10 EUR using a 5 EUR coupon. After returning the t-shirt, the customer gets only 5 EUR back as this is the amount of money they actually paid. The remaining 5 EUR which was the original coupon amount for the marketing campaign will appear in this column.'),
return_ship_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue earned because of shipping coupons returned (accounted on cust_order_return_dt)'),
branch_return_ship_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue virtually earned because of Filiale (physical shops) shipping coupons returned (accounted on cust_order_return_dt)'),
recycled_goods_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Value of products that are recycled and scrapped'),
stock_deval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Value lost from the stock for depreciation ( devaluation )'),
adm_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for Administration (support function)'),
it_wshop_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Costs for IT involved in webshop specific support operation'),
it_ic_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for IT involved in Intercompany support operation'),
fin_compensation_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for financial compensation to webshops'),
curr_tax_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for taxation processes'),
reimburs_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Reimbursement value'),
personal_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for the personal'),
material_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for material '),
curr_ex_rate_diff_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Revenue or losses due to currency excange rate'),
adv_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for advertisment'),
ic_income_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Intercompany income'),
ic_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Intercompany costs'),
corporate_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Corporate costs (e.g. Webpage)'),
other_material_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Other material costs'),
ext_storage_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs for external storages.'),
transport_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Transportation costs for goods movement.'),
delivery_cost_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Delivery costs'),
tax_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Costs of taxes/vat/customs'),
return_prod_before_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Target price (maximum desired selling price) of returned products before any type of price reduction (such as write offs or promotions)'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
add_services_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Net Revenue in EUR coming from additional services (delivery_to_point_of_use / assembly). This cost is optional and mostly article dependent. (accounted on cust_order_perform_dt)'),
return_add_services_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Additional services net value of a returned article in EUR reimbursed to the customer. This cost is optional and mostly article dependent. (accounted on cust_order_return_dt)'),
is_replacement_order_fg BOOL OPTIONS(description='An indicator showing if the order is a replacement_order or not'),
coupon_write_off_loss_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses due to coupons generated for inventory reduction campaign (accounted on cust_order_perform_dt)'),
return_coupon_write_off_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The amount of money gained back when a returned product was bought using a coupon for inventory reduction campaign (accounted on cust_order_perform_dt). Example: customer buys a t-shirt for 10 EUR using a 5 EUR coupon. After returning the t-shirt, the customer gets only 5 EUR back as this is the amount of money they actually paid. The remaining 5 EUR which was the original coupon amount for the inventory reduction campaign will appear in this column.'),
sellback_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of products that have been returned by the customer and have had their price discounted in order to be resold. It is not clear if all of these products are going to be resold, they could instead be recycled or scrapped.'),
cancel_revenue_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue loss from ordered products that have been cancelled  (accounted on cust_order_dt)'),
cancel_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of ordered products that have been cancelled (accounted on cust_order_dt)'),
csa_ship_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue virtually lost because of shipping coupons assigned by the Customer Service Agent (CSA).(accounted on cust_order_perform_dt)'),
csa_return_ship_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue virtually earned because of shipping coupons assigned by the Customer Service Agent (CSA) returned (accounted on cust_order_return_dt)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_sid, cust_order_pos_nr) NOT ENFORCED
)
OPTIONS(description='A fact table with granularity one row per Customer Order Line (CUST_ORDER_SID + CUST_ORDER_POS_NR).              This is a derived table, based on several other fact tables (t_fact_customer_order_line, t_fact_customer_return_line, t_fact_customer_goodwill line, t_fact_goods_movement ..)              The table contains all metrics relevant to the profit /loss margin at Customer Order Line level.              IMPORTANT - please notice that here we have measures related to shipping of an item, returning of an item, having a "goodwill". While this events can be associated with Customer Order Line, not all of them happen on the same date (cust_order_dt). Some metrics are relevant for the date of the Return, other are releveant for the date of the Goodwill. Read the description of each column carefully to understand which metric (profit/loss amount) is accounted at which date.             Table is materialized (instead of view) for performance reasons - it is supposed to be used directly by AI team and as a source for aggregate tables that will be used by BI');