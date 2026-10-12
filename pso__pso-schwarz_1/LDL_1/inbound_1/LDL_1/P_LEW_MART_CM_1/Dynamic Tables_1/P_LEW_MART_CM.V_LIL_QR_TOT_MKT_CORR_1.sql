
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_QR_TOT_MKT_CORR_1
(
   client_id
  ,rtl_id
  ,per_id
  ,currency_iso_cd
  ,corr_val_k
  ,corr_py_val_k
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
   SELECT
   datm.client_id AS client_id,
   rtl.rtl_id AS rtl_id,
   datm.per_id AS per_id,
   datm.currency_iso_cd AS currency_iso_cd,
   CAST(DECODE(rtl.rtl_id, datm.rtl_id, 0, -SUM(datm.val)) AS DECIMAL(23,5)) AS corr_val_k,
   CAST(DECODE(rtl.rtl_id, datm.rtl_id, 0, -SUM(datm.py_val)) AS DECIMAL(23,5)) AS corr_py_val_k
   FROM p_lew_mart_cm.v_lil_lift_data_act_1 AS datm
   CROSS JOIN (SELECT
   TRY_CAST(val AS INTEGER) AS rtl_id
   FROM p_lew_process_mstr_ac.v_lil_code_1
    WHERE main_code = 'QR_TOT_MKT_CORR'
      AND sub_code = 'FLTR_RTL_ID'
  ) AS rtl
   LEFT OUTER JOIN (SELECT
   da_i.client_id,
   da_i.rtl_id,
   da_i.per_id,
   da_i.currency_iso_cd
   FROM p_lew_mart_cm.v_lil_lift_data_act_1 AS da_i
   WHERE da_i.meas_id = (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='MEAS_ID' )  /* Value */
      AND da_i.prom_id = (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='PROM_ID' ) /* Promotion Total */
      AND da_i.lift_cat_id = (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='LIFT_CAT_ID' ) /* Total FMCG */
      AND COALESCE(da_i.val, 0) >= 1 /* exclude "fake zeroes" */
      AND da_i.rtl_id <> (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='TOT_MKT_RTL_ID' )         /* exclude "Total Market" */
     GROUP BY 1,2,3,4
  ) AS da
   ON  da.client_id = datm.client_id
   AND da.rtl_id = rtl.rtl_id
   AND da.per_id = datm.per_id
   AND da.currency_iso_cd = datm.currency_iso_cd
   WHERE datm.meas_id = (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='MEAS_ID' )  /* Value */
    AND datm.rtl_id  = (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='TOT_MKT_RTL_ID' ) /* Total Market */
    AND da.rtl_id IS NULL /* No selected retailer present */
    AND datm.prom_id = (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='PROM_ID' )  /* Promotion Total */
    AND datm.lift_cat_id = (SELECT
   CAST(val AS INTEGER) AS meas_id
   FROM p_lew_process_mstr_ac.v_lil_code_1 WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='LIFT_CAT_ID' ) /* Total FMCG */
  GROUP BY 1,2,3,4, datm.rtl_id;
