CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITM_FAM_PILLAR_MAP_1
(
  client_id
, item_familygroup_id
, src_familygrp_cd
, pillar_id
)
AS
   SELECT
     client_id,
   item_familygroup_id,
   src_familygrp_cd,
   pillar_id
  FROM p_lew_process_mstr_ac.v_itm_fam_pillar_map_1
;