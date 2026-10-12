CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_QR_TOP_RTL_1
(
   client_id
  ,country_iso_cd
  ,rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,qr_rtl_id
) AS
SELECT
   client_id
  ,country_iso_cd
  ,rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,qr_rtl_id
FROM P_LEW_MART_CM.V_LIL_QR_TOP_RTL_1 ;

