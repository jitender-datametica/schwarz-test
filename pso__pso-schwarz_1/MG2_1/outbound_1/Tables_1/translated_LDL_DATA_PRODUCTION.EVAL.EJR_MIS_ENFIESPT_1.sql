CREATE OR REPLACE TABLE ldl_data_production_eval.ejr_mis_enfiespt_1 (
client_id INTEGER,
client_desc STRING(35) COLLATE 'und:ci',
orig_store_nr INTEGER,
move_store_desc STRING(255) COLLATE 'und:ci',
store_id INTEGER,
byr INTEGER,
cy_month INTEGER,
cy_month_name STRING(100) COLLATE 'und:ci',
currency_iso_cd STRING(3) COLLATE 'und:ci',
curr_tot_id INTEGER,
aspect_id INTEGER,
aspect_desc STRING(4) COLLATE 'und:ci',
umsatz BIGNUMERIC(29,11),
abverkauf NUMERIC(29,5)
);