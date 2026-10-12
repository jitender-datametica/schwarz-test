/* #DescStart#
#$Revision: 8040 $, $LastChangedBy: mlysik $
#SubjectAreas#: WAWI, SAP; Kleinbelege / Storeforms
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_store_day_item_sfo AS
-- Zuordnung Wawi/Lead basiert (wie in Elwis DWH Implementierung): Aspect_id 1:  Bges Sicht

-- Zuordnung Wawi/Lead basiert (wie in Elwis DWH Implementierung): Aspect_id 2:  Vges Sicht

-- Zuordnung Elwis basiert (wie in Elwis DWH Implementierung): Bges Sicht
 -- Kennzeichnung der Quelle SAP

/* Teilabschriften SAP */ /* Heranziehen weitere Attribute der Zeitdimension */ -- Kennzeichnung der Quelle SAP

/* Abschriften auf 0 SAP */ /* Heranziehen weitere Attribute der Zeitdimension */ -- Kennzeichnung der Quelle SAP

/* Abschriften WAWI */ /* Heranziehen weitere Attribute der Zeitdimension */
/* Ermittlung Zuordnung zu WH und SIG ueber Stammdaten fuer ASWAS und ASIS Sicht (s.o.) */
/* link zu WAWI-basierten Daten wie in EKO, funktioniert für SAP-Länder nur, so lange die WAWI-Stammdatenpflege über EJR-Workaround stattfindet */
-- Bges Sicht wawi/lead (Aspect_id = 1)
 SELECT sfo.client_id,
 sfo.loc_sid_store,
 sfo.src_orig_store_nr,
 sfo.booking_dat,
 sfo.cy_week,
 sfo.cy_month,
 sfo.item_sid,
 sfo.sfotype_id,
 sfo.pcwo_reason_id,
 sfo.sfo_total_qty,
 sfo.sfo_wrtoff_zero_qty,
 sfo.sfo_total_rtl_rl_val,
 sfo.sfo_total_rtl_rl_net_val,
 sfo.sfo_wrtoff_zero_rtl_rl_val,
 sfo.sfo_wrtoff_zero_rtl_rl_net_val,
 sfo.val_pr_diff_sfo,
 sfo.val_pr_diff_net_sfo,
 sfo.sfo_total_wh_val,
 sfo.sfo_total_wh_net_val,
 sfo.sfo_total_store_val,
 sfo.sfo_total_store_net_val,
 sfo.foodaction_fg,
 sfo.src_fg -- Kennzeichnung der Quelle SAP
,
  CASE
  WHEN FA.client_id IS NULL
  THEN 0
  ELSE 1
  END AS foodaction_fg_asis,
 STWH_ASPECT1.wh_loc_sid AS loc_sid_wh_aspect1_asis,
 STWH_ASPECT2.wh_loc_sid AS loc_sid_wh_aspect2_asis,
 STWH.loc_sid_wh AS loc_sid_wh_asis,
 F.sub_item_grp_sid AS sub_item_grp_sid_asis,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM (SELECT SFO.client_id,
    SFO.loc_sid_store,
    SFO.src_orig_store_nr,
    SFO.booking_dat,
    CAL.cy_week,
    CAL.cy_month,
    SFO.item_sid,
    CAST(ROUND(CAST(SFO.sfo_type_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) AS sfotype_id,
    CAST(SFO.pcwo_reason_id AS BIGNUMERIC) AS pcwo_reason_id,
    SUM(SFO.sfo_total_qty) AS sfo_total_qty,
    SUM(CAST(SFO.sfo_wrtoff_zero_qty AS BIGNUMERIC)) AS sfo_wrtoff_zero_qty,
    SUM(SFO.sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,
    SUM(SFO.sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,
    SUM(CAST(SFO.sfo_wrtoff_zero_rtl_rl_val AS BIGNUMERIC)) AS sfo_wrtoff_zero_rtl_rl_val,
    SUM(CAST(SFO.sfo_wrtoff_zero_rtl_rl_net_val AS BIGNUMERIC)) AS sfo_wrtoff_zero_rtl_rl_net_val,
    SUM(SFO.val_pr_diff_sfo) AS val_pr_diff_sfo,
    SUM(SFO.val_pr_diff_net_sfo) AS val_pr_diff_net_sfo,
    SUM(SFO.sfo_total_wh_val) AS sfo_total_wh_val,
    SUM(SFO.sfo_total_wh_net_val) AS sfo_total_wh_net_val,
    SUM(SFO.sfo_total_store_val) AS sfo_total_store_val,
    SUM(SFO.sfo_total_store_net_val) AS sfo_total_store_net_val,
    SFO.foodaction_fg,
    1 AS src_fg
   FROM ldl_p_lew_bil.v_item_loc_sfo_partial_writeoff_prc_chng AS SFO
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON SFO.booking_dat = CAL.cal_dt
   GROUP BY SFO.client_id,
    SFO.loc_sid_store,
    SFO.src_orig_store_nr,
    SFO.booking_dat,
    CAL.cy_week,
    CAL.cy_month,
    SFO.item_sid,
    SFO.sfo_type_cd,
    SFO.pcwo_reason_id,
    SFO.foodaction_fg
   UNION ALL
   SELECT SFO.client_id,
    SFO.loc_sid_store,
    SFO.orig_store_nr AS src_orig_store_nr,
    SFO.booking_date AS booking_dat,
    CAL.cy_week,
    CAL.cy_month,
    SFO.item_sid,
    SFO.sfo_wawi_id AS sfotype_id,
    SFO.pcwo_reason_id,
    SUM(SFO.sfo_total_qty) AS sfo_total_qty,
    SUM(SFO.sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty,
    SUM(SFO.sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,
    SUM(SFO.sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,
    SUM(SFO.sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val,
    SUM(SFO.sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val,
    SUM(SFO.val_pr_diff_sfo) AS val_pr_diff_sfo,
    SUM(SFO.val_pr_diff_net_sfo) AS val_pr_diff_net_sfo,
    SUM(SFO.sfo_total_wh_val) AS sfo_total_wh_val,
    SUM(SFO.sfo_total_wh_net_val) AS sfo_total_wh_net_val,
    SUM(SFO.sfo_total_store_val) AS sfo_total_store_val,
    SUM(SFO.sfo_total_store_net_val) AS sfo_total_store_net_val,
    SFO.foodaction_fg,
    1 AS src_fg
   FROM ldl_p_lew_bil.v_item_loc_sfo_zero_writeoff AS SFO
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON SFO.booking_date = CAL.cal_dt
   GROUP BY SFO.client_id,
    SFO.loc_sid_store,
    src_orig_store_nr,
    booking_dat,
    CAL.cy_week,
    CAL.cy_month,
    SFO.item_sid,
    sfotype_id,
    SFO.pcwo_reason_id,
    SFO.foodaction_fg
   UNION ALL
   SELECT SFO.client_id,
    SFO.st_loc_sid AS loc_sid_store,
    SFO.orig_store_nr AS src_orig_store_nr,
    SFO.dat_formdate AS booking_dat,
    CAL.cy_week,
    SFO.cy_month,
    SFO.item_sid,
    SFO.sfotype_id,
    SFO.pcwo_reason_id,
    SFO.qty_total_sfo AS sfo_total_qty,
    SFO.qty_total_sfo_wrtoff_zero AS sfo_wrtoff_zero_qty,
    SFO.val_rtl_rl_sfo AS sfo_total_rtl_rl_val,
    SFO.val_rtl_rl_net_sfo AS sfo_total_rtl_rl_net_val,
    SFO.val_wrtoff_zero AS sfo_wrtoff_zero_rtl_rl_val,
    SFO.val_wrtoff_zero_net AS sfo_wrtoff_zero_rtl_rl_net_val,
    SFO.val_pr_diff_sfo,
    SFO.val_pr_diff_net_sfo,
    SFO.val_total_wh_sfo AS sfo_total_wh_val,
    SFO.val_total_wh_net_sfo AS sfo_total_wh_net_val,
    SFO.val_total_str_sfo AS sfo_total_store_val,
    SFO.val_total_str_net_sfo AS sfo_total_store_net_val,
    SFO.foodaction_fg,
    0 AS src_fg
   FROM ldl_p_lew_core_ac.v_wawi_agg_store_day_item_sfo AS SFO
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON SFO.dat_formdate = CAL.cal_dt) AS sfo
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_map_act AS STWH_ASPECT1 ON sfo.client_id = STWH_ASPECT1.client_id
   AND sfo.loc_sid_store = STWH_ASPECT1.st_loc_sid AND STWH_ASPECT1.aspect_id = 1
   -- Vges Sicht wawi/lead (Aspekt_id = 2)

 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_map_act AS STWH_ASPECT2 ON sfo.client_id = STWH_ASPECT2.client_id
   AND sfo.loc_sid_store = STWH_ASPECT2.st_loc_sid AND STWH_ASPECT2.aspect_id = 2
   /* Zuordnung zu WH auf WAWI/Elwis Basis */
 LEFT JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown AS STWH ON sfo.client_id = STWH.client_id AND sfo.loc_sid_store
   = STWH.loc_sid_store /* Zuordnung zu SIG ueber Item Hierarchie */
 LEFT JOIN ldl_p_lew_core_ac.v_item_hist AS H ON sfo.client_id = H.client_id AND sfo.item_sid = H.item_sid AND
   CURRENT_DATE BETWEEN H.dwh_valid_from AND H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS F ON H.client_id = F.client_id AND H.item_fam_grp_sid = F.item_fam_grp_sid
     AND CURRENT_DATE BETWEEN F.dwh_valid_from AND F.dwh_valid_to
 LEFT JOIN ldl_p_lew_bil.v_item_foodaction_hist AS FA ON sfo.client_id = FA.client_id AND sfo.item_sid = FA.item_sid AND
   CURRENT_DATE BETWEEN FA.dwh_valid_from AND FA.dwh_valid_to;