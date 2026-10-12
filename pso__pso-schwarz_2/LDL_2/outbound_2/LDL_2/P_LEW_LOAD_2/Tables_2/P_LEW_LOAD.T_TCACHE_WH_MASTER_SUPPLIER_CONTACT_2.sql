CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_wh_master_supplier_contact_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
sup_contact_id INTEGER NOT NULL,
medium_type_id INTEGER NOT NULL,
sup_sid BIGNUMERIC(38,0) NOT NULL,
contact_preference_fg INTEGER,
contact_active_fg INTEGER,
contact_last_changed_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);