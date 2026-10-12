CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_QR_RETAILER
(
   qr_rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,qr_rtl_srt_cd
) AS
SELECT
   qr_rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,qr_rtl_srt_cd
FROM P_LEW_MART_CM.V_LIL_QR_RETAILER ;
