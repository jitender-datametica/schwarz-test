
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_itm_familygroup_int_1
AS
SELECT IFGH.sub_item_grp_cd AS subitemgroup_id,
 IFG.src_familygrp_cd,
 SUBSTR(IFG.src_familygrp_cd, INSTR(IFG.src_familygrp_cd, '.') + 1) AS family_cd,
 MAX(CASE
   WHEN IFGD.client_id = 23
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc,
 MAX(CASE
   WHEN IFGD.client_id = 1
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_at,
 MAX(CASE
   WHEN IFGD.client_id = 2
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_be,
 MAX(CASE
   WHEN IFGD.client_id = 3
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_bg,
 MAX(CASE
   WHEN IFGD.client_id = 4
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_ch,
 MAX(CASE
   WHEN IFGD.client_id = 5
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_cy,
 MAX(CASE
   WHEN IFGD.client_id = 6
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_cz,
 MAX(CASE
   WHEN IFGD.client_id = 8
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_dk,
 MAX(CASE
   WHEN IFGD.client_id = 9
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_ee,
 MAX(CASE
   WHEN IFGD.client_id = 10
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_es,
 MAX(CASE
   WHEN IFGD.client_id = 11
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_fi,
 MAX(CASE
   WHEN IFGD.client_id = 12
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_fr,
 MAX(CASE
   WHEN IFGD.client_id = 13
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_gb,
 MAX(CASE
   WHEN IFGD.client_id = 14
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_gr,
 MAX(CASE
   WHEN IFGD.client_id = 15
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_hr,
 MAX(CASE
   WHEN IFGD.client_id = 16
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_hu,
 MAX(CASE
   WHEN IFGD.client_id = 17
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_ie,
 MAX(CASE
   WHEN IFGD.client_id = 18
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_it,
 MAX(CASE
   WHEN IFGD.client_id = 19
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_lt,
 MAX(CASE
   WHEN IFGD.client_id = 20
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_lv,
 MAX(CASE
   WHEN IFGD.client_id = 21
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_ni,
 MAX(CASE
   WHEN IFGD.client_id = 22
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_nl,
 MAX(CASE
   WHEN IFGD.client_id = 23
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_de,
 MAX(CASE
   WHEN IFGD.client_id = 24
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_pl,
 MAX(CASE
   WHEN IFGD.client_id = 25
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_pt,
 MAX(CASE
   WHEN IFGD.client_id = 26
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_ro,
 MAX(CASE
   WHEN IFGD.client_id = 27
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_se,
 MAX(CASE
   WHEN IFGD.client_id = 28
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_si,
 MAX(CASE
   WHEN IFGD.client_id = 29
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_sk,
 MAX(CASE
   WHEN IFGD.client_id = 31
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_cs,
 MAX(CASE
   WHEN IFGD.client_id = 32
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_mt,
 MAX(CASE
   WHEN IFGD.client_id = 33
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_us,
 MAX(CASE
   WHEN IFGD.client_id = 34
   THEN IFGD.item_fam_grp_descr
   ELSE NULL
   END) AS item_family_desc_rs
FROM ldl_p_lew_core_ac.v_item_familygroup_hist_1 AS IFGH
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_descr_1 AS IFGD ON IFGH.item_fam_grp_sid = IFGD.item_fam_grp_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_1 AS IFG ON IFGD.item_fam_grp_sid = IFG.item_fam_grp_sid
WHERE CURRENT_DATE BETWEEN IFGH.dwh_valid_from AND IFGH.dwh_valid_to
 AND IFGD.lang_cd = '@'
GROUP BY subitemgroup_id,
 IFG.src_familygrp_cd,
 family_cd;

