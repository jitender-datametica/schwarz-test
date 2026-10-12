CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_write_off_by_organization_day (bus_dt
OPTIONS(description='The business date to which the measures are related.'), int_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'), int_org_type_cd
OPTIONS(description='The code identifying the discriminators for internal organizations.'), country_org_cd
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.)'),
write_off_net_val
OPTIONS(description='The total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of any reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day because of any reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_py_net_val
OPTIONS(description='The total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago because of any reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago because of any reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_py_swday_net_val
OPTIONS(description='The total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago because of any reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago because of any reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_breakage_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_breakage_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_breakage_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_breakage_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_breakage_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_breakage_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day, because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day, because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year, because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago, because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year, because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_sell_by_dt_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago, because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_deliv_quality_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_defective_non_food_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_donations_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day, because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day, because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago, because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago, because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago, because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_taken_prod_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago, because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day, because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day, because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago, because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago, because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago, because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_force_majeure_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago, because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day because of discounts, Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_discounts_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the given day because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_py_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same calendar date one year ago because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_py_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same calendar date one year ago because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_py_swday_net_val
OPTIONS(description='The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on the same weekday one year ago because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_stock_clearance_py_swday_bytd_net_val
OPTIONS(description='The business-year-to-date sum of the net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) up to the same weekday one year ago because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)'),
write_off_for_other_reasons_net_val
OPTIONS(description='This is a sum of main.write_off_for_donations_net_val + main.write_off_for taken_prod_net_val + main.write_off_for_force_majeure_net_val '),
curr_cd OPTIONS(description='The code identifying the currency according to ISO-4217.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT main.bus_dt,
 main.int_org_sid,
 main.int_org_type_cd,
 main.country_org_cd,
  main.write_off_net_val / fer.exchange_rate AS write_off_net_val,
  main.write_off_bytd_net_val / fer.exchange_rate AS write_off_bytd_net_val,
  main.write_off_py_net_val / fer.exchange_rate AS write_off_py_net_val,
  main.write_off_py_bytd_net_val / fer.exchange_rate AS write_off_py_bytd_net_val,
  main.write_off_py_swday_net_val / fer.exchange_rate AS write_off_py_swday_net_val,
  main.write_off_py_swday_bytd_net_val / fer.exchange_rate AS write_off_py_swday_bytd_net_val,
  main.write_off_for_breakage_net_val / fer.exchange_rate AS write_off_for_breakage_net_val,
  main.write_off_for_breakage_bytd_net_val / fer.exchange_rate AS write_off_for_breakage_bytd_net_val,
  main.write_off_for_breakage_py_net_val / fer.exchange_rate AS write_off_for_breakage_py_net_val,
  main.write_off_for_breakage_py_bytd_net_val / fer.exchange_rate AS write_off_for_breakage_py_bytd_net_val,
  main.write_off_for_breakage_py_swday_net_val / fer.exchange_rate AS write_off_for_breakage_py_swday_net_val,
  main.write_off_for_breakage_py_swday_bytd_net_val / fer.exchange_rate AS write_off_for_breakage_py_swday_bytd_net_val
 ,
  main.write_off_for_sell_by_dt_net_val / fer.exchange_rate AS write_off_for_sell_by_dt_net_val,
  main.write_off_for_sell_by_dt_bytd_net_val / fer.exchange_rate AS write_off_for_sell_by_dt_bytd_net_val,
  main.write_off_for_sell_by_dt_py_net_val / fer.exchange_rate AS write_off_for_sell_by_dt_py_net_val,
  main.write_off_for_sell_by_dt_py_bytd_net_val / fer.exchange_rate AS write_off_for_sell_by_dt_py_bytd_net_val,
  main.write_off_for_sell_by_dt_py_swday_net_val / fer.exchange_rate AS write_off_for_sell_by_dt_py_swday_net_val,
  main.write_off_for_sell_by_dt_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_sell_by_dt_py_swday_bytd_net_val,
  main.write_off_for_deliv_quality_net_val / fer.exchange_rate AS write_off_for_deliv_quality_net_val,
  main.write_off_for_deliv_quality_bytd_net_val / fer.exchange_rate AS write_off_for_deliv_quality_bytd_net_val,
  main.write_off_for_deliv_quality_py_net_val / fer.exchange_rate AS write_off_for_deliv_quality_py_net_val,
  main.write_off_for_deliv_quality_py_bytd_net_val / fer.exchange_rate AS write_off_for_deliv_quality_py_bytd_net_val,
  main.write_off_for_deliv_quality_py_swday_net_val / fer.exchange_rate AS write_off_for_deliv_quality_py_swday_net_val
 ,
  main.write_off_for_deliv_quality_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_deliv_quality_py_swday_bytd_net_val,
  main.write_off_for_defective_non_food_net_val / fer.exchange_rate AS write_off_for_defective_non_food_net_val,
  main.write_off_for_defective_non_food_bytd_net_val / fer.exchange_rate AS
 write_off_for_defective_non_food_bytd_net_val,
  main.write_off_for_defective_non_food_py_net_val / fer.exchange_rate AS write_off_for_defective_non_food_py_net_val,
  main.write_off_for_defective_non_food_py_bytd_net_val / fer.exchange_rate AS
 write_off_for_defective_non_food_py_bytd_net_val,
  main.write_off_for_defective_non_food_py_swday_net_val / fer.exchange_rate AS
 write_off_for_defective_non_food_py_swday_net_val,
  main.write_off_for_defective_non_food_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_defective_non_food_py_swday_bytd_net_val,
  main.write_off_for_donations_net_val / fer.exchange_rate AS write_off_for_donations_net_val,
  main.write_off_for_donations_bytd_net_val / fer.exchange_rate AS write_off_for_donations_bytd_net_val,
  main.write_off_for_donations_py_net_val / fer.exchange_rate AS write_off_for_donations_py_net_val,
  main.write_off_for_donations_py_bytd_net_val / fer.exchange_rate AS write_off_for_donations_py_bytd_net_val,
  main.write_off_for_donations_py_swday_net_val / fer.exchange_rate AS write_off_for_donations_py_swday_net_val,
  main.write_off_for_donations_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_donations_py_swday_bytd_net_val,
  main.write_off_for_taken_prod_net_val / fer.exchange_rate AS write_off_for_taken_prod_net_val,
  main.write_off_for_taken_prod_bytd_net_val / fer.exchange_rate AS write_off_for_taken_prod_bytd_net_val,
  main.write_off_for_taken_prod_py_net_val / fer.exchange_rate AS write_off_for_taken_prod_py_net_val,
  main.write_off_for_taken_prod_py_bytd_net_val / fer.exchange_rate AS write_off_for_taken_prod_py_bytd_net_val,
  main.write_off_for_taken_prod_py_swday_net_val / fer.exchange_rate AS write_off_for_taken_prod_py_swday_net_val,
  main.write_off_for_taken_prod_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_taken_prod_py_swday_bytd_net_val,
  main.write_off_for_force_majeure_net_val / fer.exchange_rate AS write_off_for_force_majeure_net_val,
  main.write_off_for_force_majeure_bytd_net_val / fer.exchange_rate AS write_off_for_force_majeure_bytd_net_val,
  main.write_off_for_force_majeure_py_net_val / fer.exchange_rate AS write_off_for_force_majeure_py_net_val,
  main.write_off_for_force_majeure_py_bytd_net_val / fer.exchange_rate AS write_off_for_force_majeure_py_bytd_net_val,
  main.write_off_for_force_majeure_py_swday_net_val / fer.exchange_rate AS write_off_for_force_majeure_py_swday_net_val
 ,
  main.write_off_for_force_majeure_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_force_majeure_py_swday_bytd_net_val,
  main.write_off_for_discounts_net_val / fer.exchange_rate AS write_off_for_discounts_net_val,
  main.write_off_for_discounts_bytd_net_val / fer.exchange_rate AS write_off_for_discounts_bytd_net_val,
  main.write_off_for_discounts_py_net_val / fer.exchange_rate AS write_off_for_discounts_py_net_val,
  main.write_off_for_discounts_py_bytd_net_val / fer.exchange_rate AS write_off_for_discounts_py_bytd_net_val,
  main.write_off_for_discounts_py_swday_net_val / fer.exchange_rate AS write_off_for_discounts_py_swday_net_val,
  main.write_off_for_discounts_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_discounts_py_swday_bytd_net_val,
  main.write_off_for_stock_clearance_net_val / fer.exchange_rate AS write_off_for_stock_clearance_net_val,
  main.write_off_for_stock_clearance_bytd_net_val / fer.exchange_rate AS write_off_for_stock_clearance_bytd_net_val,
  main.write_off_for_stock_clearance_py_net_val / fer.exchange_rate AS write_off_for_stock_clearance_py_net_val,
  main.write_off_for_stock_clearance_py_bytd_net_val / fer.exchange_rate AS
 write_off_for_stock_clearance_py_bytd_net_val,
  main.write_off_for_stock_clearance_py_swday_net_val / fer.exchange_rate AS
 write_off_for_stock_clearance_py_swday_net_val,
  main.write_off_for_stock_clearance_py_swday_bytd_net_val / fer.exchange_rate AS
 write_off_for_stock_clearance_py_swday_bytd_net_val,
   COALESCE(main.write_off_for_donations_net_val, 0) + COALESCE(main.write_off_for_taken_prod_net_val, 0) + COALESCE(main
   .write_off_for_force_majeure_net_val, 0) AS write_off_for_other_reasons_net_val,
 main.curr_cd,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_dim.t_fact_write_off_by_organization_day AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg;