create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CM.V_LIL_EJR_LIFT_DATA_ACT(
	DATA_SRC_ID,
	CLIENT_ID,
	RTL_ID,
	RTL_LVL,
	PER_ID,
	PER_DESC,
	PER_DESC_EN,
	PY_PER_DESC,
	PY_PER_DESC_EN,
	LIFT_CAT_ID,
	PROM_ID,
	CURRENCY_ISO_CD,
	MEAS_ID,
	VAL,
	PY_VAL,
	COUNT_CUSTOMER,
	COUNT_CUSTOMER_PY,
	PROT_FG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_CM
 as
SELECT
    data_src_id
   ,DECODE(ejr.client_id, 33, 331, ejr.client_id) AS ""client_id""
   , rtl_id
   , rtl_lvl
   , period_id AS per_id
  ,CAST(COALESCE(dsde.period_name, ejr.period_name) AS VARCHAR(128)) AS per_desc
  ,CAST(COALESCE(dsen.period_name, ejr.period_name) AS VARCHAR(128)) AS per_desc_EN
  ,CAST(COALESCE(pydsde.period_name, ejr.period_name_py) AS VARCHAR(128)) AS py_per_desc
  ,CAST(COALESCE(pydsen.period_name, ejr.period_name_py) AS VARCHAR(128)) AS py_per_desc_EN  
   , gfk_cat_id AS lift_cat_id
   , promotion_brand_id AS prom_id
   , curr_cd AS currency_iso_cd
   , meas_id
-- Anpassungen für Snowflake
   , val::Decimal(23,5)
   , py_val::Decimal(23,5)
   , count_customer
   , count_customer_py
   , prot_fg
FROM P_LEW_PROCESS_MSTR_AC.v_lil_ejr_lift_data_act AS ejr
INNER JOIN P_LEW_CORE_AC.v_lil_period AS pc
  ON pc.period_sid = ejr.period_sid
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS dsde
    ON dsde.period_sid = ejr.period_sid
    AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS dsen
    ON dsen.period_sid = ejr.period_sid
    AND dsen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pydsde
    ON pydsde.period_sid = pc.period_sid_py
    AND pydsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_period_descr AS pydsen
    ON pydsen.period_sid = pc.period_sid_py
    AND pydsen.lang_cd = 'EN';
