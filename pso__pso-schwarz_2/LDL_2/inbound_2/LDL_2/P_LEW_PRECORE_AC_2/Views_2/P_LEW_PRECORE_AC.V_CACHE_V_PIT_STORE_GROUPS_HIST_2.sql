CREATE OR REPLACE VIEW P_LEW_PRECORE_AC.V_CACHE_V_PIT_STORE_GROUPS_HIST_2
(
   client_id
 , pvsg_srcinst_id
 , pvsg_srcinst_code
 , pvsg_storgrp_id
 , pvsg_cntry_id
 , pvsg_cntry_code
 , pvsg_storgrp_code
 , pvsg_storgrp_name
 , pvsg_storgrp_type
 , pvsg_warehs_id
 , pvsg_warehs_no
 , pvsg_warehs_name
 , pvsg_storgrp_storgrp_id
 , pvsg_storgrp_storgrp_code
 , pvsg_storgrp_storgrp_name
 , pvsg_storgrp_valid_from
 , pvsg_storgrp_valid_to
 , deleted_fg
 , dwh_valid_from
 , dwh_valid_to
 , dwh_load_id
 , dwh_created
 , dwh_updated
) 
AS
SELECT
  client_id,
  pvsg_srcinst_id,
  pvsg_srcinst_code,
  pvsg_storgrp_id,
  pvsg_cntry_id,
  pvsg_cntry_code,
  pvsg_storgrp_code,
  pvsg_storgrp_name,
  pvsg_storgrp_type,
  pvsg_warehs_id,
  pvsg_warehs_no,
  pvsg_warehs_name,
  pvsg_storgrp_storgrp_id,
  pvsg_storgrp_storgrp_code,
  pvsg_storgrp_storgrp_name,
  pvsg_storgrp_valid_from,
  pvsg_storgrp_valid_to,
  deleted_fg,
  dwh_valid_from,
  dwh_valid_to,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_precore.t_cache_v_pit_store_groups_hist_2
;