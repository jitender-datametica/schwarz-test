CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_store_wk_ftm_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
cy_week BIGNUMERIC(38,0) OPTIONS(description='Week'),
cy_week_sequence BIGNUMERIC(38,0) OPTIONS(description='Week Sequence'),
orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store number'),
loc_sid_store_move_to BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store id'),
country_cd STRING(3) NOT NULL OPTIONS(description='Country_1 code'),
country_store_week STRING(100) OPTIONS(description='Country_1, Store, Week list'),
ref_cy_week BIGNUMERIC(38,0) OPTIONS(description='Reference Week'),
sales_net_val BIGNUMERIC(38,5),
sales_pieces BIGNUMERIC(38,5),
wrtoff_val BIGNUMERIC(38,5),
buying_val BIGNUMERIC(38,5),
ref_sales_net_val BIGNUMERIC(38,5),
ref_sales_pieces BIGNUMERIC(38,5),
ref_wrtoff_val BIGNUMERIC(38,5),
ref_buying_val BIGNUMERIC(38,5)
) OPTIONS(description='FTM Aggregate Store Week table');