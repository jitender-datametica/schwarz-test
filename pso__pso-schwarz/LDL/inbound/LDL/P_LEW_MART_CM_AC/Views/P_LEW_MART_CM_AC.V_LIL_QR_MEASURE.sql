CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_QR_MEASURE
(
   qr_meas_id
  ,qr_meas_desc
  ,qr_meas_desc_EN
) AS
SELECT
   qr_meas_id
  ,qr_meas_desc
  ,qr_meas_desc_EN
FROM P_LEW_MART_CM.V_LIL_QR_MEASURE ;

