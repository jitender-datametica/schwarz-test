CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_wh_initialization AS SELECT WHIR.country_name,
 COUNTRY.client_id,
 COUNTRY.country_iso AS country_name_short,
 CAL_DAY.cy AS year,
 CAL_DAY.cy_month AS month_id,
 CAL_DAY.month_of_year AS month,
 CAL_DAY.month_of_year_name AS month_name,
 CAL_DAY.week_of_year AS week,
 CAL_WEEK.cy_week_short_name AS week_name,
 CAL_DAY.cy_week AS week_id,
 CAL_WEEK.cy_week_name AS week_name_year,
 WHIR.wh_name,
 WHIR.wh_name_short,
 WHIR.wh_id,
 WHIR.object_type,
  CASE
  WHEN WHIR.object_type = 'B'
  THEN 'BGES'
  WHEN WHIR.object_type = 'V'
  THEN 'VGES'
  WHEN WHIR.object_type = 'BV'
  THEN 'BGES=VGES'
  WHEN WHIR.object_type = 'BnotV'
  THEN 'BGES!=VGES'
  ELSE NULL
  END AS object_type_desc,
 WHIR.stores_assigned_fg,
  CASE
  WHEN (WHIR.object_type = 'BV' OR WHIR.object_type = 'BnotV') AND WHIR.stores_assigned_fg
  THEN
  'WH_Master, WH_Move, STD_Move, STD_itemstock, PTM_Master, PTM_Move/GPS, WAMAS, DISPO, TTP, MMO_Master, MMO_Move, EJR, TXJ'
  WHEN (WHIR.object_type = 'BV' OR WHIR.object_type = 'BnotV') AND NOT WHIR.stores_assigned_fg
  THEN 'WH_Master, WH_Move, WAMAS, DISPO_Orders, TTP, (MMO_Master, MMO_Move)'
  WHEN WHIR.object_type = 'B' AND NOT WHIR.stores_assigned_fg
  THEN 'WH_Master, WH_Move, evtl. STD_itemstock'
  WHEN WHIR.object_type = 'V'
  THEN 'Keine Schnittstellen'
  ELSE NULL
  END AS interfaces,
 WHIR.wh_type,
  CASE
  WHEN STRPOS(WHIR.wh_type, '(NF)') <> 0
  THEN 1
  ELSE 0
  END AS non_food,
  CASE
  WHEN STRPOS(WHIR.wh_type, '(F)') <> 0
  THEN 1
  ELSE 0
  END AS food,
  CASE
  WHEN STRPOS(WHIR.wh_type, '(BP)') <> 0
  THEN 1
  ELSE 0
  END AS blumen_pflanzen,
  CASE
  WHEN STRPOS(WHIR.wh_type, '(TK)') <> 0
  THEN 1
  ELSE 0
  END AS tiko,
  CASE
  WHEN STRPOS(WHIR.wh_type, '(AL)') <> 0
  THEN 1
  ELSE 0
  END AS aussenlager,
  CASE
  WHEN STRPOS(WHIR.wh_type, '(OL)') <> 0
  THEN 1
  ELSE 0
  END AS online_lager,
 WHIR.bges_id,
 WHIR.vges_fg,
 WHIR.vges_id,
 WHIR.opening_date,
 WHIR.goods_receipt_date,
 WHIR.first_prod_data_date,
 WHIR.goods_issue_date,
 WHIR.stores_assigned_date,
 WHIR.stores_relocated_from,
 WHIR.working_hours_transmission,
 WHIR.wh_relocation_fg,
 STATUS_0.status_id,
 STATUS_0.status_,
 STATUS_0.aufgabe AS status_aufgabe,
 STATUS_0.anteil AS status_anteil,
  CASE
  WHEN WHIR.object_type = 'V' OR WHIR.object_type = 'BnotV'
  THEN '1.3x Management Cockpit'
  WHEN WHIR.object_type = 'BV'
  THEN '1.3 Management Cockpit'
  ELSE 'Keine Cockpit-Anzeige'
  END AS cockpit_display,
 WHIR.comments,
 WHIR.upload_date
FROM ldl_bcbi_fe_mstr_bcbi.t_wh_initialization AS WHIR
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_day AS CAL_DAY ON WHIR.opening_date = CAL_DAY.cal_dt
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_week AS CAL_WEEK ON CAL_DAY.cy_week = CAL_WEEK.cy_week
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_country AS COUNTRY ON WHIR.country_name = COUNTRY.country_name
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_wh_init_status AS STATUS_0 ON WHIR.status_id = STATUS_0.status_id;