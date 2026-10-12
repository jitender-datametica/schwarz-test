CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_BKNG_CHMBR_NTWK_STAT_2
/*
#DescStart#
#$Revision: 9966 $, $LastChangedBy: knagmote $
#SubjectAreas#: One-to-one view on dimension table for network connectivity of baking chambers
#DescEnd#
*/
(
  client_id
, loc_sid_store
, oven_id
, oven_brand
, dwh_valid_from
, dwh_valid_to
, connected_fg
)
AS
   SELECT
     client_id,
   loc_sid_store,
   oven_id,
   oven_brand,
   dwh_valid_from,
   dwh_valid_to,
   connected_fg
  FROM p_lew_mart_lead.t_dim_bkng_chmbr_ntwk_stat_2
;