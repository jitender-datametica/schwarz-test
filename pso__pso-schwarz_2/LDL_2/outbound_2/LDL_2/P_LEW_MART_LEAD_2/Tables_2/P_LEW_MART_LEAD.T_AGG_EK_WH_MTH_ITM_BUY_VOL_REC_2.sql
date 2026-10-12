CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_ek_wh_mth_itm_buy_vol_rec_2 (
client_id BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
item_id BIGNUMERIC(38,0),
family_cd STRING(20),
subitemgroup_id BIGNUMERIC(38,0),
itemgroup_int_id BIGNUMERIC(38,0),
cy_month BIGNUMERIC(38,0),
byr BIGNUMERIC(38,0),
buying_volume_val NUMERIC(18,5),
receive_piece_qty NUMERIC(18,5)
) CLUSTER BY cy_month, client_id;