CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_SUBITEMGROUP_1
(
    client_id
    , sub_item_grp_sid
    , src_node
    , src_subitemgrp_cd
    , src_subitemgrp_id
    , sub_item_grp_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   sub_item_grp_sid,
   src_node,
   src_subitemgrp_cd,
   src_subitemgrp_id,
   sub_item_grp_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core_ac.v_subitemgroup_1
;