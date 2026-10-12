CREATE OR REPLACE VIEW ldl_p_lew_process.v_ejr_load_1 AS SELECT lg.client_id,
 lg.loc_sid,
 ORG_STORE.aspect_id,
 lg.dwh_cal_dt,
 lg.store_open_fg,
 lg.core,
 lg.solace,
 lg.dayend_completion,
 lg.ladequote,
 lg.ladequote_solace,
 lg.dayend_completion_backup
FROM (SELECT COALESCE(st.client_id, base.client_id) AS client_id,
   COALESCE(st.loc_sid_store, base.loc_sid) AS loc_sid,
   COALESCE(st.dat_open, base.dwh_cal_dt) AS dwh_cal_dt,
    CASE
    WHEN st.dat_open IS NOT NULL
    THEN 1
    ELSE 0
    END AS store_open_fg,
   base.core,
   base.solace,
    CASE
    WHEN base.core > base.dayend_completion
    THEN base.core
    ELSE base.dayend_completion
    END AS dayend_completion,
    SUM(CASE
      WHEN base.dayend_completion IS NULL AND base.solace IS NOT NULL
      THEN 0
      ELSE COALESCE(base.core, 0) / COALESCE(CASE
         WHEN base.core > base.dayend_completion
         THEN base.core
         ELSE base.dayend_completion
         END, base.core, 1)
      END) * 100 AS ladequote,
    SUM(COALESCE(base.solace, 0) / COALESCE(base.dayend_completion, base.core, base.solace)) * 100 AS ladequote_solace,
   base.dayend_completion AS dayend_completion_backup
  FROM (SELECT client_id,
     loc_sid,
     dwh_cal_dt,
     SUM(core) AS core,
     SUM(solace) AS solace,
     SUM(dayend_completion) AS dayend_completion
    FROM ldl_p_lew_process.t_ejr_load_log_1
    WHERE (receipt_transactiontype_id IN ('100', '101', '150', '151', '200', '201', '250', '251', '300', '301', '350',
         '351') OR receipt_transactiontype_id IS NULL)
     AND dwh_cal_dt >= DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 13 MONTH)
    GROUP BY client_id,
     loc_sid,
     dwh_cal_dt) AS base
   FULL JOIN (SELECT *
    FROM ldl_p_lew_bil.v_sys_md_storelist_1 AS ST
    WHERE dat_open >= DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 13 MONTH)) AS st ON base.client_id = st.client_id
       AND base.loc_sid = st.loc_sid_store AND base.dwh_cal_dt = st.dat_open
  GROUP BY client_id,
   loc_sid,
   dwh_cal_dt,
   store_open_fg,
   base.core,
   base.solace,
   dayend_completion,
   dayend_completion_backup) AS lg
 LEFT JOIN ldl_p_lew_core.t_wawi_org_store_merge_act_1 AS ORG_STORE ON lg.client_id = ORG_STORE.client_id AND lg.loc_sid =
   ORG_STORE.st_loc_sid;