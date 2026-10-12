/* --------------------------------------------------------------------------------
   DDL for table: t_fact_write_off_by_organization_day_wawi_item
   generated from Powerdesigner on Montag, 12. Mai 2025 14:51:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_write_off_by_organization_day_wawi_item (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store or warehouse, where the Wawi item had to be written off.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations. Here it distinguishes between stores and warehouses (internal companies).'),
wawi_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item which was written off.'),
wawi_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item variant which was written off.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country organization. This is the country organization which is responsible for the store or warehouse (internal company) which has written off the Wawi item.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.) This is the country organization which is responsible for the store or warehouse (internal company) which has written off the Wawi item.'),
write_off_net_val BIGNUMERIC(38,5)
OPTIONS(description='The total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day, independent on the reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_breakage_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because of defective non-food products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) for the given Wawi item on that day because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_dt, int_org_sid, wawi_item_variant_sid) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='An aggregate fact holding write-offs and turnover per day, Wawi item variant (the long Wawi number) and internal organization (store or warehouse).');