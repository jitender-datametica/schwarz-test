CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_supplier_2 (country_2, supplier_nr, supplier_name,
supplier_shortname, supplier_country, intbuycountry, supplier_wh, ma, mod_date, source_extraction_tmsp,
snflk_insert_tmsp, snflk_update_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_dim_supplier_2;