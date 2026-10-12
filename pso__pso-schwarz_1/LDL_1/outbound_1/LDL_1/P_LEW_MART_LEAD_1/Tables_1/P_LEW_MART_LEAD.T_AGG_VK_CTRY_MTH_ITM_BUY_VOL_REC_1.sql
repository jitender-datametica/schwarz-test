CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_vk_ctry_mth_itm_buy_vol_rec_1 (
client_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
item_id BIGNUMERIC(38,0),
family_cd BIGNUMERIC(38,0),
subitemgroup_id BIGNUMERIC(38,0),
itemgroup_int_id BIGNUMERIC(38,0),
cy_month BIGNUMERIC(38,0),
byr BIGNUMERIC(38,0),
sales_volume_val NUMERIC(18,5),
sales_piece_qty NUMERIC(18,5)
) CLUSTER BY cy_month, client_id;