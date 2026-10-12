CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_HIERARCHY_2 as
   /*
   #DescStart#
   #$Revision: 6410 $, $LastChangedBy: mproch $
   #SubjectAreas#: Artikelstamm
   #DescEnd#
   */
   SELECT
     item.client_id,
   item.item_sid,
   item.src_matnr,
   item.src_orig_item_nr,
   item.src_dat_valid_from,
   item.src_case_size,
   item.item_name,
   famg.src_familygrp_cd,
   famg.src_familygrp_id,
   famg.item_fam_grp_name,
   suig.sub_item_grp_sid,
   suig.src_subitemgrp_cd,
   suig.sub_item_grp_name,
   igri.src_itemgrp_int_cd,
   igri.item_grp_int_name
  FROM p_lew_bil.v_item_2 item_2
   INNER JOIN p_lew_core_ac.v_item_familygroup_2 famg
   ON item.item_fam_grp_sid = famg.item_fam_grp_sid
   INNER JOIN p_lew_core_ac.v_item_familygroup_hist_2 famg_h
   ON item.item_fam_grp_sid = famg_h.item_fam_grp_sid
   AND CURRENT_DATE BETWEEN famg_h.dwh_valid_from AND famg_h.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_subitemgroup_2 suig
   ON famg_h.sub_item_grp_sid = suig.sub_item_grp_sid
   INNER JOIN p_lew_core_ac.v_subitemgroup_hist_2 suig_h
   ON famg_h.sub_item_grp_sid = suig_h.sub_item_grp_sid
   AND CURRENT_DATE BETWEEN suig_h.dwh_valid_from AND suig_h.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_itemgroup_international_2 igri
   ON suig_h.item_grp_int_sid = igri.item_grp_int_sid

   WHERE item.dwh_actual_fg = 1
   ;