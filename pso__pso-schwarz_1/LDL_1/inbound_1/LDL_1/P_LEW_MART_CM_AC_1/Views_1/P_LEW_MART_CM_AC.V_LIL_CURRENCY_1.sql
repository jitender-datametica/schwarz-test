CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_CURRENCY_1
(
  currency_iso_cd
  ,currency_desc
  ,currency_desc_EN
  ,currency_srt_cd
  ,currency_srt
) AS
SELECT
  currency_iso_cd
  ,currency_desc
  ,currency_desc_EN
  ,currency_srt_cd
  ,currency_srt
FROM P_LEW_MART_CM.V_LIL_CURRENCY_1 ;
