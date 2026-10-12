CREATE OR REPLACE TABLE ldl_data_production_fe_mstr_temp.t_mly_prot_wawi_product_variant (
wawi_variant_sid INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
wawi_country_cd STRING(2) NOT NULL,
wawi_orig_item_nr INTEGER NOT NULL,
wawi_case_size INTEGER NOT NULL,
wawi_variant_descr STRING(500),
wawi_case_size_dec NUMERIC(18,5) NOT NULL,
wawi_prod_sid INTEGER NOT NULL
);