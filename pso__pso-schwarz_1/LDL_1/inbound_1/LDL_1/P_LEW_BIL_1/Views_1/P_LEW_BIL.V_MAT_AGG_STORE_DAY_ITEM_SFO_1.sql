CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_STORE_DAY_ITEM_SFO_1
AS
/*
#DescStart#
#$Revision: 8040 $, $LastChangedBy: mlysik $
#SubjectAreas#: WAWI, SAP; Kleinbelege / Storeforms
#DescEnd#
*/
SELECT
sfo.client_id,
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
sfo.src_fg                           --Kennzeichnung der Quelle SAP
,
CASE WHEN fa.client_id IS NULL THEN 0 ELSE 1 END AS foodaction_fg_asis,
stwh_aspect1.wh_loc_sid AS loc_sid_wh_aspect1_asis -- Zuordnung Wawi/Lead basiert (wie in Elwis DWH Implementierung): Aspect_id 1:  Bges Sicht
,
stwh_aspect2.wh_loc_sid AS loc_sid_wh_aspect2_asis -- Zuordnung Wawi/Lead basiert (wie in Elwis DWH Implementierung): Aspect_id 2:  Vges Sicht
,
stwh.loc_sid_wh AS loc_sid_wh_asis -- Zuordnung Elwis basiert (wie in Elwis DWH Implementierung): Bges Sicht 
,
f.sub_item_grp_sid AS sub_item_grp_sid_asis,
CURRENT_TIMESTAMP(6) AS dwh_updated
FROM
(SELECT
sfo.client_id,
sfo.loc_sid_store,
sfo.src_orig_store_nr,
sfo.booking_dat,
cal.cy_week,
cal.cy_month,
sfo.item_sid,
CAST(TO_NUMBER(sfo.sfo_type_cd) AS INTEGER)                      AS sfotype_id,
CAST(sfo.pcwo_reason_id AS INTEGER)                              AS pcwo_reason_id,
SUM(sfo.sfo_total_qty)                                           AS sfo_total_qty,
SUM(CAST(sfo.sfo_wrtoff_zero_qty AS DECIMAL(38,5)))              AS sfo_wrtoff_zero_qty,
SUM(sfo.sfo_total_rtl_rl_val)                                    AS sfo_total_rtl_rl_val,
SUM(sfo.sfo_total_rtl_rl_net_val)                                AS sfo_total_rtl_rl_net_val,
SUM(CAST(sfo.sfo_wrtoff_zero_rtl_rl_val AS DECIMAL(38,10)))     AS sfo_wrtoff_zero_rtl_rl_val,
SUM(CAST(sfo.sfo_wrtoff_zero_rtl_rl_net_val AS DECIMAL(38,10))) AS sfo_wrtoff_zero_rtl_rl_net_val,
SUM(sfo.val_pr_diff_sfo)                                         AS val_pr_diff_sfo,
SUM(sfo.val_pr_diff_net_sfo)                                     AS val_pr_diff_net_sfo,
SUM(sfo.sfo_total_wh_val)                                        AS sfo_total_wh_val,
SUM(sfo.sfo_total_wh_net_val)                                    AS sfo_total_wh_net_val,
SUM(sfo.sfo_total_store_val)                                     AS sfo_total_store_val,
SUM(sfo.sfo_total_store_net_val)                                 AS sfo_total_store_net_val,
sfo.foodaction_fg,
cast(1 as BYTEINT)                                               AS src_fg                           --Kennzeichnung der Quelle SAP

/* Teilabschriften SAP */
FROM p_lew_bil.v_item_loc_sfo_partial_writeoff_prc_chng_1 sfo

/* Heranziehen weitere Attribute der Zeitdimension */
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
ON sfo.booking_dat = cal.cal_dt

GROUP BY
   sfo.client_id
  ,sfo.loc_sid_store
  ,sfo.src_orig_store_nr
  ,sfo.booking_dat
  ,cal.cy_week
  ,cal.cy_month
  ,sfo.item_sid
  ,sfo.sfo_type_cd
  ,sfo.pcwo_reason_id
  ,sfo.foodaction_fg


UNION ALL
SELECT
sfo.client_id,
sfo.loc_sid_store,
sfo.orig_store_nr                                                AS src_orig_store_nr,
sfo.booking_date                                                 AS booking_dat,
cal.cy_week,
cal.cy_month,
sfo.item_sid,
sfo.sfo_wawi_id                                                  AS sfotype_id,
sfo.pcwo_reason_id,
SUM(sfo.sfo_total_qty)                                           AS sfo_total_qty,
SUM(sfo.sfo_wrtoff_zero_qty)                                     AS sfo_wrtoff_zero_qty,
SUM(sfo.sfo_total_rtl_rl_val)                                    AS sfo_total_rtl_rl_val,
SUM(sfo.sfo_total_rtl_rl_net_val)                                AS sfo_total_rtl_rl_net_val,
SUM(sfo.sfo_wrtoff_zero_rtl_rl_val)                              AS sfo_wrtoff_zero_rtl_rl_val,
SUM(sfo.sfo_wrtoff_zero_rtl_rl_net_val)                          AS sfo_wrtoff_zero_rtl_rl_net_val,
SUM(sfo.val_pr_diff_sfo)                                         AS val_pr_diff_sfo,
SUM(sfo.val_pr_diff_net_sfo)                                     AS val_pr_diff_net_sfo,
SUM(sfo.sfo_total_wh_val)                                        AS sfo_total_wh_val,
SUM(sfo.sfo_total_wh_net_val)                                    AS sfo_total_wh_net_val,
SUM(sfo.sfo_total_store_val)                                     AS sfo_total_store_val,
SUM(sfo.sfo_total_store_net_val)                                 AS sfo_total_store_net_val,
sfo.foodaction_fg,
cast(1 as BYTEINT)                                               AS src_fg                          --Kennzeichnung der Quelle SAP

/* Abschriften_1 auf 0 SAP */
FROM p_lew_bil.v_item_loc_sfo_zero_writeoff_1 sfo

/* Heranziehen weitere Attribute der Zeitdimension */
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
ON sfo.booking_date = cal.cal_dt

GROUP BY
   sfo.client_id
  ,sfo.loc_sid_store
  ,sfo.orig_store_nr
  ,sfo.booking_date
  ,cal.cy_week
  ,cal.cy_month
  ,sfo.item_sid
  ,sfo.sfo_wawi_id
  ,sfo.pcwo_reason_id
  ,sfo.foodaction_fg

UNION ALL
SELECT
sfo.client_id,
sfo.st_loc_sid                                                   AS loc_sid_store,
sfo.orig_store_nr                                                AS src_orig_store_nr,
sfo.dat_formdate                                                 AS booking_dat,
cal.cy_week,
sfo.cy_month,
sfo.item_sid,
sfo.sfotype_id,
sfo.pcwo_reason_id,
sfo.qty_total_sfo                                                AS sfo_total_qty,
sfo.qty_total_sfo_wrtoff_zero                                    AS sfo_wrtoff_zero_qty,
sfo.val_rtl_rl_sfo                                               AS sfo_total_rtl_rl_val,
sfo.val_rtl_rl_net_sfo                                           AS sfo_total_rtl_rl_net_val,
sfo.val_wrtoff_zero                                              AS sfo_wrtoff_zero_rtl_rl_val,
sfo.val_wrtoff_zero_net                                          AS sfo_wrtoff_zero_rtl_rl_net_val,
sfo.val_pr_diff_sfo                                              AS val_pr_diff_sfo,
sfo.val_pr_diff_net_sfo                                          AS val_pr_diff_net_sfo,
sfo.val_total_wh_sfo                                             AS sfo_total_wh_val,
sfo.val_total_wh_net_sfo                                         AS sfo_total_wh_net_val,
sfo.val_total_str_sfo                                            AS sfo_total_store_val,
sfo.val_total_str_net_sfo                                        AS sfo_total_store_net_val,
sfo.foodaction_fg,
cast(0 as BYTEINT)                                               AS src_fg                          --Kennzeichnung der Quelle SAP

/* Abschriften_1 WAWI */
FROM p_lew_core_ac.v_wawi_agg_store_day_item_sfo_1 sfo

/* Heranziehen weitere Attribute der Zeitdimension */
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
ON cal.cal_dt = sfo.dat_formdate
) sfo

/*Ermittlung Zuordnung zu WH und SIG ueber Stammdaten fuer ASWAS und ASIS Sicht (s.o.)*/

/* link zu WAWI-basierten Daten wie in EKO, funktioniert für SAP-Länder nur, so lange die WAWI-Stammdatenpflege über EJR-Workaround stattfindet*/
-- Bges Sicht wawi/lead (Aspect_id = 1)
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_merge_map_act_1 stwh_aspect1
ON sfo.client_id = stwh_aspect1.client_id
  AND sfo.loc_sid_store = stwh_aspect1.st_loc_sid
  AND stwh_aspect1.aspect_id = 1

-- Vges Sicht wawi/lead (Aspekt_id = 2)
LEFT OUTER  JOIN p_lew_core_ac.v_wawi_org_store_merge_map_act_1 stwh_aspect2
ON sfo.client_id = stwh_aspect2.client_id
  AND sfo.loc_sid_store = stwh_aspect2.st_loc_sid
  AND stwh_aspect2.aspect_id = 2

/*Zuordnung zu WH auf WAWI/Elwis Basis */
LEFT OUTER JOIN p_lew_bil.v_store_to_warehouse_lastknown_1 stwh
ON sfo.client_id = stwh.client_id
  AND sfo.loc_sid_store = stwh.loc_sid_store

/*Zuordnung zu SIG ueber Item_1 Hierarchie*/
LEFT OUTER JOIN p_lew_core_ac.v_item_hist_1 h
ON sfo.client_id = h.client_id
  AND sfo.item_sid = h.item_sid
  AND CURRENT_DATE BETWEEN h.dwh_valid_from AND h.dwh_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_hist_1 f
ON h.client_id = f.client_id
  AND h.item_fam_grp_sid = f.item_fam_grp_sid
  AND CURRENT_DATE BETWEEN f.dwh_valid_from AND f.dwh_valid_to

LEFT OUTER JOIN p_lew_bil.v_item_foodaction_hist_1 AS fa
ON sfo.client_id = fa.client_id
  AND sfo.item_sid = fa.item_sid
  AND CURRENT_DATE BETWEEN fa.dwh_valid_from AND fa.dwh_valid_to
;


