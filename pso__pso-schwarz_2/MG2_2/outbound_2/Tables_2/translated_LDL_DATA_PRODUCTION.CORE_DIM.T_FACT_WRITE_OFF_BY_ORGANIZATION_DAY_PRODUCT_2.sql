DROP TABLE IF EXISTS ldl_data_production_core_dim.t_fact_write_off_by_organization_day_product_2;
CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_write_off_by_organization_day_product_2 (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store or warehouse, where the product had to be written off.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
logistic_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_2 organization. This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.) This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.'),
write_off_for_breakage_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
write_off_net_val NUMERIC(29,5)
OPTIONS(description='The total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day, independent on the reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_net_val NUMERIC(29,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given product on that day because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
PRIMARY KEY (bus_dt, int_org_sid, logistic_variant_sid) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='An aggregate fact holding write-offs and turnover per day, product (logistic variant) and internal organization (store or warehouse).');