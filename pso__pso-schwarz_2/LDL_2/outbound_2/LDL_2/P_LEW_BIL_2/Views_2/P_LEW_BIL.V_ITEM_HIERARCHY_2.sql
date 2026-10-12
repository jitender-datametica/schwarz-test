/* #DescStart#
   #$Revision: 6410 $, $LastChangedBy: mproch $
   #SubjectAreas#: Artikelstamm
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_hierarchy_2 AS SELECT ITEM.client_id,
 ITEM.item_sid,
 ITEM.src_matnr,
 ITEM.src_orig_item_nr,
 ITEM.src_dat_valid_from,
 ITEM.src_case_size,
 ITEM.item_name,
 FAMG.src_familygrp_cd,
 FAMG.src_familygrp_id,
 FAMG.item_fam_grp_name,
 SUIG.sub_item_grp_sid,
 SUIG.src_subitemgrp_cd,
 SUIG.sub_item_grp_name,
 IGRI.src_itemgrp_int_cd,
 IGRI.item_grp_int_name
FROM ldl_p_lew_bil.v_item_2 AS ITEM_2
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_2 AS FAMG ON ITEM.item_fam_grp_sid = FAMG.item_fam_grp_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS FAMG_H ON ITEM.item_fam_grp_sid = FAMG_H.item_fam_grp_sid AND
   CURRENT_DATE BETWEEN FAMG_H.dwh_valid_from AND FAMG_H.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_2 AS SUIG ON FAMG_H.sub_item_grp_sid = SUIG.sub_item_grp_sid
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS SUIG_H ON FAMG_H.sub_item_grp_sid = SUIG_H.sub_item_grp_sid AND
   CURRENT_DATE BETWEEN SUIG_H.dwh_valid_from AND SUIG_H.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_itemgroup_international_2 AS IGRI ON SUIG_H.item_grp_int_sid = IGRI.item_grp_int_sid
WHERE ITEM.dwh_actual_fg = 1;