CREATE OR REPLACE TABLE ldl_data_production_fe_mstr_temp.t_mly_prot_wawi_product_1 (
wawi_prod_sid INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
wawi_country_cd STRING(2) NOT NULL,
wawi_orig_item_nr INTEGER NOT NULL,
wawi_prod_descr STRING(500)
);