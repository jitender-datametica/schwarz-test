CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_vk_int_price_infl (
cy_week_partial_week_id BIGNUMERIC(38,0),
price_infl_val NUMERIC(18,5),
price_infl_val_mtd NUMERIC(18,5),
price_infl_val_bytd NUMERIC(18,5),
price_infl_val_p1y NUMERIC(18,5),
price_infl_val_p1y_mtd NUMERIC(18,5),
price_infl_val_p1y_bytd NUMERIC(18,5)
) CLUSTER BY cy_week_partial_week_id;