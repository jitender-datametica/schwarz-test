CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_SUBITEMGROUP

/*
#DescStart#
#$Revision: 11351 $, $LastChangedBy: spalmeri $
#SubjectAreas#: Access Layer
#DescEnd#
*/
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
  FROM p_lew_mart_analytics.v_subitemgroup
;