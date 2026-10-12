CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_ITM_FAM_PILLAR_MAP_2
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
  FROM p_lew_process_mstr.t_itm_fam_pillar_map_2
;