CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_XSELL_2
(
      client_id
    , week_id
    , orig_item_nr_lhs
    , orig_item_nr_rhs
    , ref_start_dt
    , ref_end_dt
    , same_subitemgrp_fg
    , item_desc_lhs
    , item_desc_rhs
    , rule_support
    , mdl_confidence
    , mdl_lift
    , mdl_coefficient
    , xsell_id
    , partkey
    , uap_filename
    , mod_tmsp
)
AS
   SELECT
         client_id,
   week_id,
   orig_item_nr_lhs,
   orig_item_nr_rhs,
   ref_start_dt,
   ref_end_dt,
   same_subitemgrp_fg,
   item_desc_lhs,
   item_desc_rhs,
   rule_support,
   mdl_confidence,
   mdl_lift,
   mdl_coefficient,
   xsell_id,
   partkey,
   uap_filename,
   mod_tmsp
  FROM p_lew_mart_analytics.t_pvt_xsell_2
;