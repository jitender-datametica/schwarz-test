create or replace dynamic table LDL_PRODUCTION.P_LEW_MART_CM.V_LIL_PERIOD(
	PER_ID,
	PER_TEXT,
	PER_TEXT_EN,
	PER_DESC,
	PER_DESC_EN,
	PER_TP_ID,
	PER_LVL,
	PER_YR,
	PER_START_DAT,
	PER_END_DAT,
	PY_PER_ID,
	PY_PER_DESC,
	PY_PER_DESC_EN,
	PQ_PER_ID,
	PQ_PER_DESC,
	PQ_PER_DESC_EN,
	PP_PER_ID,
	PP_PER_DESC,
	PP_PER_DESC_EN,
	LIAM_AVBL_FG,
	LIFT_AVBL_FG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_P_DYNAMIC_TABLE_P_LEW_MART_CM
 as 
SELECT
  pp.period_id AS per_id
 ,CAST(COALESCE(dsde.period_name, pc.period_name) AS VARCHAR(128)) AS per_text
 ,CAST(COALESCE(dsen.period_name, pc.period_name) AS VARCHAR(128)) AS per_text_EN
 
 ,CAST(COALESCE(dsde.period_name, pc.period_name) AS VARCHAR(128)) AS per_desc
 ,CAST(COALESCE(dsen.period_name, pc.period_name) AS VARCHAR(128)) AS per_desc_EN 
 
 ,CAST(pc.period_type_id AS SMALLINT) AS per_tp_id
 ,CAST(pp.period_lvl AS SMALLINT) AS per_lvl
 ,CAST(pc.period_year AS SMALLINT) AS per_yr
 ,CAST(NULL AS DATE) AS per_start_dat
 ,CAST(NULL AS DATE) AS per_end_dat
 ,pypp.period_id AS py_per_id
 
 ,CAST(COALESCE(pydsde.period_name, pypc.period_name) AS VARCHAR(128)) AS py_per_desc
 ,CAST(COALESCE(pydsen.period_name, pypc.period_name) AS VARCHAR(128)) AS py_per_desc_EN
  
 ,pqpp.period_id AS pq_per_id
 ,CAST(COALESCE(pqdsde.period_name, pqpc.period_name) AS VARCHAR(128)) AS pq_per_desc
 ,CAST(COALESCE(pqdsen.period_name, pqpc.period_name) AS VARCHAR(128)) AS pq_per_desc_EN
 
 ,TRUNC((pp.PERIOD_ID-2)/100)*100+((pp.PERIOD_ID-1)%100+12)%13+1 AS pp_per_id
 
 ,CAST(COALESCE(ppdsde.period_name, pppc.period_name) AS VARCHAR(128)) AS pp_per_desc
 ,CAST(COALESCE(ppdsen.period_name, pppc.period_name) AS VARCHAR(128)) AS pp_per_desc_EN
  
 ,CASE MAX(pp.liam_avbl_fg) WHEN 0 THEN NULL ELSE 1 END AS liam_avbl_fg
 ,CASE MAX(pp.lift_avbl_fg) WHEN 0 THEN NULL ELSE 1 END AS lift_avbl_fg
 FROM P_LEW_PROCESS_MSTR_AC.v_lil_period AS pp
 INNER JOIN P_LEW_CORE_AC.v_lil_period AS pc
  ON pc.period_sid = pp.period_sid
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period AS pypc
  ON pypc.period_sid = pc.period_sid_py
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period AS pqpc
  ON pqpc.period_sid = pc.period_sid_pq
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period AS pppc
  ON pppc.period_sid = TRUNC((pp.PERIOD_ID-2)/100)*100+((pp.PERIOD_ID-1)%100+12)%13+1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period AS pypp
  ON pypp.period_sid = pc.period_sid_py
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period AS pqpp 
  ON pqpp.period_sid = pc.period_sid_pq
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period AS pppp
  ON pppp.period_id = TRUNC((pp.PERIOD_ID-2)/100)*100+((pp.PERIOD_ID-1)%100+12)%13+1
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS dsde
   ON dsde.period_sid = pc.period_sid
  AND dsde.lang_cd = 'DE'
  LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS dsen
   ON dsen.period_sid = pc.period_sid
  AND dsen.lang_cd = 'EN'
 
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pydsde
   ON pydsde.period_sid = pypc.period_sid
  AND pydsde.lang_cd = 'DE'
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pydsen
   ON pydsen.period_sid = pypc.period_sid
  AND pydsen.lang_cd = 'EN' 
 
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pqdsde
   ON pqdsde.period_sid = pqpc.period_sid
  AND pqdsde.lang_cd = 'DE'
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pqdsen
   ON pqdsen.period_sid = pqpc.period_sid
  AND pqdsen.lang_cd = 'EN'
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS ppdsde
   ON ppdsde.period_sid = pppp.period_sid
  AND ppdsde.lang_cd = 'DE'
 LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS ppdsen
   ON ppdsen.period_sid = pppp.period_sid
  AND ppdsen.lang_cd = 'EN'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19;
