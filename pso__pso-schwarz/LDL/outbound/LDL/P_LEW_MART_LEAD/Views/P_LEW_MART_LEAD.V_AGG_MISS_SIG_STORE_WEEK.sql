/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/calendar week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_sig_store_week (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), sub_item_grp_sid
OPTIONS(description='S-Key für Unterwarengruppe'), item_fam_grp_sid
OPTIONS(description='S-Key der Artikelfamiliengruppe'), itemgroup_int_id OPTIONS(description='Warengruppe ID'),
subitemgroup_id OPTIONS(description='Unterwarengruppe ID'), item_familygroup_id OPTIONS(description='Artikelfamilie ID'),
cy_week OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
day_cnt OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die ganze Woche'), miss_item_cnt_avg_day
OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/WEEK/ARTICLE FAMILY`) AS SELECT client_id,
 loc_sid_wh,
 move_to_store_id,
 wh_id,
 orig_store_nr,
 aspect_id,
 CAST(currency_iso_cd AS STRING) AS currency_iso_cd,
 curr_tot_id,
 item_grp_int_sid,
 sub_item_grp_sid,
 item_fam_grp_sid,
 itemgroup_int_id,
 subitemgroup_id,
 item_familygroup_id,
 cy_week,
 busyear,
 day_cnt,
 miss_item_cnt,
  CASE
  WHEN day_cnt > 0
  THEN miss_item_cnt / day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day
FROM (SELECT DISTINCT ASM.client_id,
   ASM.loc_sid_wh,
   ASM.store_id AS move_to_store_id,
   ASM.wh_id,
   ASM.orig_store_nr,
   ASM.aspect_id,
   curr.currency_iso_cd,
   curr.curr_tot_id,
   D1.item_grp_int_sid,
   D1.sub_item_grp_sid,
   D1.item_fam_grp_sid,
   ROUND(CAST(SIGH.item_grp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id,
   ROUND(CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
   IFG.src_familygrp_id AS item_familygroup_id,
   CAL.cy_week,
   CAL.busyear,
   COUNT(CASE
     WHEN D1.miss_item_cnt IS NOT NULL
     THEN D1.dat_formdate
     ELSE NULL
     END) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(ASM.aspect_id AS STRING)
      , CAST(D1.item_fam_grp_sid AS STRING), CAST(CAL.cy_week AS STRING), CAST(curr.curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
   SUM(D1.miss_item_cnt) OVER (PARTITION BY CAST(ASM.client_id AS STRING), CAST(ASM.store_id AS STRING), CAST(ASM.aspect_id AS STRING)
      , CAST(D1.item_fam_grp_sid AS STRING), CAST(CAL.cy_week AS STRING), CAST(curr.curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt
  FROM ldl_p_lew_core_ac.v_cal_calendarday AS CAL
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS ASM ON CAL.cal_dt BETWEEN ASM.dat_opening_ovis AND (COALESCE(ASM
      .dat_closing_ovis, DATE '9999-12-31'))
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS ASM1 ON ASM.store_id = ASM1.move_to_store_id AND ASM.aspect_id
      = ASM1.aspect_id
   INNER JOIN ldl_p_lew_mart_lead.t_agg_miss_sig_store_day AS D1 ON ASM.client_id = D1.client_id AND ASM1.store_id = D1
      .loc_sid_store AND CAL.cal_dt = D1.dat_formdate
   INNER JOIN ldl_p_lew_bil_ac.v_item_familygroup AS IFG ON ASM.client_id = IFG.client_id AND D1.item_fam_grp_sid = IFG
        .item_fam_grp_sid AND IFG.deleted_fg = 0 AND IFG.active_fg = 1 AND IFG.src_familygrp_id > 0
   INNER JOIN ldl_p_lew_bil_ac.v_subitemgroup AS SIG ON ASM.client_id = SIG.client_id AND D1.sub_item_grp_sid = SIG.sub_item_grp_sid
     
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SIGH ON ASM.client_id = SIGH.client_id AND D1.sub_item_grp_sid =
      SIGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to
   INNER JOIN (SELECT client_id,
     curr_cd AS currency_iso_cd,
     curr_tot_id
    FROM (SELECT client_id,
        'EUR' AS curr_cd,
        0 AS curr_tot_id
       FROM ldl_p_lew_core_ac.v_client AS C
       UNION DISTINCT
       SELECT C.client_id,
        C.curr_cd,
        CU.curr_tot_id
       FROM ldl_p_lew_core_ac.v_client AS C
        INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CU ON C.client_id = CU.client_id AND C.curr_cd = CU.currency_iso_cd
          ) AS c) AS curr ON ASM.client_id = curr.client_id) AS md;