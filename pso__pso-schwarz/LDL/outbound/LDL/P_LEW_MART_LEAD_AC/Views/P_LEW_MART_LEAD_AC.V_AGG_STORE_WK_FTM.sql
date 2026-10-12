CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_wk_ftm (client_id, cy_week, cy_week_sequence, orig_store_nr,
loc_sid_store_move_to, country_cd, country_store_week, ref_cy_week, sales_net_val, sales_pieces, wrtoff_val, buying_val
, ref_sales_net_val, ref_sales_pieces, ref_wrtoff_val, ref_buying_val) AS SELECT client_id,
 cy_week,
 cy_week_sequence,
 orig_store_nr,
 loc_sid_store_move_to,
 country_cd,
 country_store_week,
 ref_cy_week,
 sales_net_val,
 sales_pieces,
 wrtoff_val,
 buying_val,
 ref_sales_net_val,
 ref_sales_pieces,
 ref_wrtoff_val,
 ref_buying_val
FROM ldl_p_lew_mart_lead.t_agg_store_wk_ftm;