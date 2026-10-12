CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ITM_FAM_PILLAR_MAP
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
  FROM p_lew_mart_lead.v_itm_fam_pillar_map
;