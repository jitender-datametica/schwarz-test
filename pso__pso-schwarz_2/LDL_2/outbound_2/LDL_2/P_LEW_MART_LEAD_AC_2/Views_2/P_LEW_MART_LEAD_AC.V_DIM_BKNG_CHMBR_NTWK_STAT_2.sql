CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_dim_bkng_chmbr_ntwk_stat_2 (client_id, loc_sid_store, oven_id, oven_brand
, dwh_valid_from, dwh_valid_to, connected_fg) AS SELECT client_id,
 loc_sid_store,
 oven_id,
 oven_brand,
 dwh_valid_from,
 dwh_valid_to,
 connected_fg
FROM ldl_p_lew_mart_lead.t_dim_bkng_chmbr_ntwk_stat_2;