
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_consolidationgroup_desc_1
AS
SELECT x.client_id,
 WH.src_wh_id AS wh_id,
 x.itm_consgrp_id,
 x.cons_orig_item_nr,
 x.cons_dat_valid_from_item,
 x.cons_fg,
 MAX(CASE
   WHEN x.language_id = 1
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_at,
 MAX(CASE
   WHEN x.language_id = 2
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_be,
 MAX(CASE
   WHEN x.language_id = 12
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_be_fr,
 MAX(CASE
   WHEN x.language_id = 3
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_bg,
 MAX(CASE
   WHEN x.language_id = 4
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_ch,
 MAX(CASE
   WHEN x.language_id = 5
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_cy,
 MAX(CASE
   WHEN x.language_id = 6
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_cz,
 MAX(CASE
   WHEN x.language_id = 7 OR x.cons_fg = 1
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc,
 MAX(CASE
   WHEN x.language_id = 8
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_dk,
 MAX(CASE
   WHEN x.language_id = 9
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_ee,
 MAX(CASE
   WHEN x.language_id IN (10, 31)
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_es,
 MAX(CASE
   WHEN x.language_id = 11
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_fi,
 MAX(CASE
   WHEN x.language_id = 12
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_fr,
 MAX(CASE
   WHEN x.language_id = 13
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_gb,
 MAX(CASE
   WHEN x.language_id IN (14, 5)
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_gr,
 MAX(CASE
   WHEN x.language_id = 15
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_hr,
 MAX(CASE
   WHEN x.language_id = 16
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_hu,
 MAX(CASE
   WHEN x.language_id IN (17, 21)
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_ie,
 MAX(CASE
   WHEN x.language_id IN (18, 32)
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_it,
 MAX(CASE
   WHEN x.language_id = 19
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_lt,
 MAX(CASE
   WHEN x.language_id = 20
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_lv,
 MAX(CASE
   WHEN x.language_id = 21
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_ni,
 MAX(CASE
   WHEN x.language_id = 22
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_nl,
 MAX(CASE
   WHEN x.language_id = 23
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_de,
 MAX(CASE
   WHEN x.language_id = 24
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_pl,
 MAX(CASE
   WHEN x.language_id = 25
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_pt,
 MAX(CASE
   WHEN x.language_id = 26
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_ro,
 MAX(CASE
   WHEN x.language_id = 27
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_se,
 MAX(CASE
   WHEN x.language_id = 28
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_si,
 MAX(CASE
   WHEN x.language_id = 29
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_sk,
 MAX(CASE
   WHEN x.language_id = 31
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_cs,
 MAX(CASE
   WHEN x.language_id = 32
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_mt,
 MAX(CASE
   WHEN x.language_id = 33
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_us,
 MAX(CASE
   WHEN x.language_id = 34
   THEN x.cons_item_desc
   ELSE NULL
   END) AS cons_item_desc_rs
FROM (SELECT i.client_id,
   i.wh_loc_sid,
   i.itm_consgrp_id,
    CASE
    WHEN i.itm_consgrp_id = - 1
    THEN A.orig_item_nr
    ELSE CAST(- 1 AS BIGNUMERIC)
    END AS cons_orig_item_nr,
    CASE
    WHEN i.itm_consgrp_id = - 1
    THEN A.dat_valid_from
    ELSE DATE '1900-01-01'
    END AS cons_dat_valid_from_item,
    CASE
    WHEN i.itm_consgrp_id = - 1
    THEN 0
    ELSE 1
    END AS cons_fg,
   COALESCE(OID.language_id, i.client_id) AS language_id,
   MAX(COALESCE(CGP.itm_consgrp_desc, OID.item_desc)) AS cons_item_desc
  FROM (SELECT I1.client_id,
      I1.wh_loc_sid,
      I1.item_sid,
      C1.itm_consgrp_id,
      CAST(- 1 AS BIGNUMERIC) AS cons_item_id
     FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS I1
      INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS C1 ON I1.client_id = C1.client_id AND I1.item_sid =
         C1.item_sid AND I1.wh_loc_sid = C1.wh_loc_sid
     WHERE CURRENT_DATE BETWEEN C1.dat_rec_start AND C1.dat_rec_end
      AND CURRENT_DATE BETWEEN I1.dat_rec_start AND I1.dat_rec_end
     UNION ALL
     SELECT client_id,
      wh_loc_sid,
      item_sid,
      CAST(- 1 AS BIGNUMERIC) AS itm_consgrp_id,
      item_sid AS cons_item_sid
     FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS I2
     WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
      AND NOT EXISTS (SELECT 1
       FROM ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS C2
       WHERE I2.client_id = client_id
        AND I2.item_sid = item_sid
        AND I2.wh_loc_sid = wh_loc_sid
        AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end)) AS i
   INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS A ON i.client_id = A.client_id AND i.item_sid = A.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_consolidationgroup_1 AS CGP ON i.client_id = CGP.client_id AND i.wh_loc_sid =
       CGP.wh_loc_sid AND i.itm_consgrp_id = CGP.itm_consgrp_id AND CURRENT_DATE BETWEEN CGP.dat_rec_start AND CGP.dat_rec_end
     
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_orig_item_desc_act_1 AS OID ON i.client_id = OID.client_id AND A.orig_item_nr =
       OID.orig_item_nr AND A.dat_valid_from = OID.dat_valid_from AND i.itm_consgrp_id = - 1
  GROUP BY i.client_id,
   i.wh_loc_sid,
   i.itm_consgrp_id,
   cons_orig_item_nr,
   cons_dat_valid_from_item,
   cons_fg,
   language_id) AS x
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON x.client_id = WH.client_id AND x.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
GROUP BY x.client_id,
 wh_id,
 x.itm_consgrp_id,
 x.cons_orig_item_nr,
 x.cons_dat_valid_from_item,
 x.cons_fg;

