CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_METADATA_1
(
      client_id
    , orig_item_nr
    , item_desc
    , normal_fg
    , brand_fg
    , dur_shelflife_day_cust
    , itemgrp_int_cd
    , item_grp_int_name
    , subitemgrp_cd
    , sub_item_grp_name
    , familygrp_cd
    , item_fam_grp_name
    , vat_pct_val
    , price_buying
)
AS
   SELECT
         client_id,
   orig_item_nr,
   item_desc,
   normal_fg,
   brand_fg,
   dur_shelflife_day_cust,
   itemgrp_int_cd,
   item_grp_int_name,
   subitemgrp_cd,
   sub_item_grp_name,
   familygrp_cd,
   item_fam_grp_name,
   vat_pct_val,
   price_buying
  FROM p_lew_mart_analytics.t_pvt_metadata_1
;