CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CAL_WEEK_T11_2
(
    cy_week
    , cy_week_t
)
AS
   SELECT
       cy_week
    , cy_week_t
  FROM p_lew_mart_msi.v_cal_week_t11_2
;