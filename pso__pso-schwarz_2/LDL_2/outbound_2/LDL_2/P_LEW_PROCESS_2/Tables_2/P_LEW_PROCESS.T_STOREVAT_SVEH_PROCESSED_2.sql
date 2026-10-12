CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_storevat_sveh_processed_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
vat_exception STRING(300) COLLATE 'und:ci' DEFAULT 'default' NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
vat_pct NUMERIC(9,5),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_created DATETIME NOT NULL
);