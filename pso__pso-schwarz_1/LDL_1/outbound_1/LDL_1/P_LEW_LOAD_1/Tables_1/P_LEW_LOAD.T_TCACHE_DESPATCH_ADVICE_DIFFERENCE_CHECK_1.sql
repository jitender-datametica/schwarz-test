CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_despatch_advice_difference_check_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
wh_id BIGNUMERIC(38,0) NOT NULL,
despatch_advice_id BIGNUMERIC(38,0) NOT NULL,
despatch_advice_diff_nr BIGNUMERIC(38,0) NOT NULL,
create_date DATE,
mismatch_bbd BIGNUMERIC(38,0),
missing_bbd BIGNUMERIC(38,0),
unknown_gtin BIGNUMERIC(38,0),
unknown_gln BIGNUMERIC(38,0),
diff_qty BIGNUMERIC(38,0),
missing_item BIGNUMERIC(38,0),
diff_del_date BIGNUMERIC(38,0),
diff_case_size BIGNUMERIC(38,0),
unexpected_desadv BIGNUMERIC(38,0),
not_ordered_item BIGNUMERIC(38,0),
unknown_consignor BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
);