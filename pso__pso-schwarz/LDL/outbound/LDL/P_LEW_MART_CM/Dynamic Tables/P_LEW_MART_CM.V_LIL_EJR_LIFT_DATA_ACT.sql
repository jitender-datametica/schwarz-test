CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_ejr_lift_data_act
OPTIONS( max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT EJR.data_src_id,
  CASE
  WHEN EJR.client_id = 33
  THEN 331
  ELSE EJR.client_id
  END AS client_id,
 EJR.rtl_id,
 EJR.rtl_lvl,
 EJR.period_id AS per_id,
 CAST(COALESCE(DSDE.period_name, EJR.period_name) AS STRING) AS per_desc,
 CAST(COALESCE(DSEN.period_name, EJR.period_name) AS STRING) AS per_desc_en,
 CAST(COALESCE(PYDSDE.period_name, EJR.period_name_py) AS STRING) AS py_per_desc,
 CAST(COALESCE(PYDSEN.period_name, EJR.period_name_py) AS STRING) AS py_per_desc_en,
 EJR.gfk_cat_id AS lift_cat_id,
 EJR.promotion_brand_id AS prom_id,
 EJR.curr_cd AS currency_iso_cd,
 EJR.meas_id -- Anpassungen für Snowflake
,
 CAST(EJR.val AS NUMERIC) AS val,
 CAST(EJR.py_val AS NUMERIC) AS py_val,
 EJR.count_customer,
 EJR.count_customer_py,
 EJR.prot_fg
FROM ldl_p_lew_process_mstr_ac.v_lil_ejr_lift_data_act AS EJR
 INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PC ON EJR.period_sid = PC.period_sid
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSDE ON EJR.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSEN ON EJR.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSDE ON PC.period_sid_py = PYDSDE.period_sid AND PYDSDE.lang_cd =
   'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS PYDSEN ON PC.period_sid_py = PYDSEN.period_sid AND PYDSEN.lang_cd =
   'EN';