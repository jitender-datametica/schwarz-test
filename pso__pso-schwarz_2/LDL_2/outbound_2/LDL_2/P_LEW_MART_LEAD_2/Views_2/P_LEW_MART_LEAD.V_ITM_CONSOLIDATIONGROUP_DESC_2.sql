/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS.
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.4  06.08.2020    Roy,Ritanjal             Introduce new country_2 LV
#  1.5  27.11.2020    Morris, Michael          Add Column(s) for  _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.6  30.03.2021    Morris, Michael          cons_item_desc_BE_fr changed to language_id = 2
#                                              20210329_2796_corr_2572
#                                              https://jira.schwarz/browse/REP4-8912
#  1.7  12.04.2021    Morris, Michael          Copied from lew_mart_msi. BGES/VGES functionality added
#                                              20210318_2789_itm_store_cons
#                                              https://jira.schwarz/browse/INTMIG-779
#                                              SF: https://jira.schwarz/browse/INTMIG-1399
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_itm_consolidationgroup_desc_2 (client_id
OPTIONS(description='International client ID'), wh_id OPTIONS(description='Company ID'), aspect_id
OPTIONS(description='Aspect BGES or VGES'), itm_consgrp_id OPTIONS(description='Item_2 consolidation group ID'),
cons_orig_item_nr OPTIONS(description='Original consolidation item_2 nr.'), cons_dat_valid_from_item
OPTIONS(description='Record valid from date'), cons_fg OPTIONS(description='Consolidation Flag'), cons_item_desc_at
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_be
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_be_fr
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_bg
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_ch
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_cy
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_cz
OPTIONS(description='Consolidation item_2 description'), cons_item_desc
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_dk
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_ee
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_es
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_fi
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_fr
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_gb
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_gr
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_hr
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_hu
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_ie
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_it
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_lt
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_lv
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_ni
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_nl
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_de
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_pl
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_pt
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_ro
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_se
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_si
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_sk
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_cs
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_mt
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_us
OPTIONS(description='Consolidation item_2 description'), cons_item_desc_rs
OPTIONS(description='Consolidation item_2 description')) OPTIONS(DESCRIPTION = `ITEM_2 CONSOLIDATION DESCRIPTION VIEW`) AS
/* Gesellschaft */
/* Because the consolidation description is only available in local language use the description also for language_id = 7. */
/* A union logic is used instead of a LEFT OUTER CROSS JOIN due to performance reasons */ SELECT x.client_id,
 WH.src_wh_id AS wh_id,
 twh.aspect_id,
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
   WHEN x.language_id = 2
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
     FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_2 AS I1
      INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_2 AS C1 ON I1.client_id = C1.client_id AND I1.item_sid =
         C1.item_sid AND I1.wh_loc_sid = C1.wh_loc_sid
     WHERE CURRENT_DATE BETWEEN C1.dat_rec_start AND C1.dat_rec_end
      AND CURRENT_DATE BETWEEN I1.dat_rec_start AND I1.dat_rec_end
     UNION ALL
     SELECT client_id,
      wh_loc_sid,
      item_sid,
      CAST(- 1 AS BIGNUMERIC) AS itm_consgrp_id,
      item_sid AS cons_item_sid
     FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_2 AS I2
     WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
      AND NOT EXISTS (SELECT 1
       FROM ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_2 AS C2
       WHERE I2.client_id = client_id
        AND I2.item_sid = item_sid
        AND I2.wh_loc_sid = wh_loc_sid
        AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end)) AS i
   INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS A ON i.client_id = A.client_id AND i.item_sid = A.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_consolidationgroup_2 AS CGP ON i.client_id = CGP.client_id AND i.wh_loc_sid =
       CGP.wh_loc_sid AND i.itm_consgrp_id = CGP.itm_consgrp_id AND CURRENT_DATE BETWEEN CGP.dat_rec_start AND CGP.dat_rec_end
     
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_orig_item_desc_act_2 AS OID ON i.client_id = OID.client_id AND A.orig_item_nr =
       OID.orig_item_nr AND A.dat_valid_from = OID.dat_valid_from AND i.itm_consgrp_id = - 1
  GROUP BY i.client_id,
   i.wh_loc_sid,
   i.itm_consgrp_id,
   cons_orig_item_nr,
   cons_dat_valid_from_item,
   cons_fg,
   language_id) AS x
 INNER JOIN (SELECT DISTINCT K.client_id,
   K.loc_sid_wh AS k_loc_sid_wh,
   TR.aspect_id,
   TR.loc_sid_wh AS tr_loc_sid_wh
  FROM ldl_p_lew_mart_lead_ac.v_org_store_merge_2 AS K
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_2 AS TR ON K.client_id = TR.client_id AND K.store_id = TR.store_id
    AND TR.aspect_id IN (1, 2)
  WHERE K.test_store_fg = 0
   AND K.aspect_id = 1
   AND K.wh_id > 0
   AND K.orig_store_nr <> K.wh_id
   AND K.dat_closing IS NULL
   AND K.dat_closing_ovis IS NULL
   AND K.mis_store_active_fg = 1
   AND TR.wh_id IS NOT NULL) AS twh ON x.client_id = twh.client_id AND x.wh_loc_sid = twh.k_loc_sid_wh
   /* Auflösung WH */
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON x.client_id = WH.client_id AND twh.tr_loc_sid_wh = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1
GROUP BY x.client_id,
 wh_id,
 twh.aspect_id,
 x.itm_consgrp_id,
 x.cons_orig_item_nr,
 x.cons_dat_valid_from_item,
 x.cons_fg;