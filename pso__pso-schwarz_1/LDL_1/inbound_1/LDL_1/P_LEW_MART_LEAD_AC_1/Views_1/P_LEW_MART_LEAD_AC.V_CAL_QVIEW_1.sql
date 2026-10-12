CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_CAL_QVIEW_1
(
  dspy_dt
, cal_dt
, cy_py_ind
, cy_week
)
AS
   SELECT
     dspy_dt,
   cal_dt,
   cy_py_ind,
   cy_week
  FROM p_lew_mart_lead.v_cal_qview_1
;