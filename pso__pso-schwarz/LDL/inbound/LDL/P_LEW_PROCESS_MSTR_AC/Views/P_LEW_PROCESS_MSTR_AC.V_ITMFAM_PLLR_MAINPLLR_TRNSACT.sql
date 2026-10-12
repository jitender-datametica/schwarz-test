CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_ITMFAM_PLLR_MAINPLLR_TRNSACT
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
     FROM p_lew_process_mstr.v_itmfam_pllr_mainpllr_trnsact
;