CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_ITMFAM_PLLR_MAINPLLR_TRNSACT_1
(
  src_familygrp_cd
, item_fam_grp_name
, pillar_id
, pillar_name
, main_pillar_id
, main_pillar_name
)
AS
   SELECT
     src_familygrp_cd,
   item_fam_grp_name,
   pillar_id,
   pillar_name,
   main_pillar_id,
   main_pillar_name
  FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_1
;