CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_mmo_shelf_capacity_item_location_replenishment_info_hist_2 (
client_id BIGNUMERIC(38),
loc_sid BIGNUMERIC(38) NOT NULL,
item_sid BIGNUMERIC(38) NOT NULL,
loc_sid_wh BIGNUMERIC(38),
shelf_capacity_unit_id BIGNUMERIC(38),
shelf_capacity_qty BIGNUMERIC(38),
extraction_date DATE NOT NULL,
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);