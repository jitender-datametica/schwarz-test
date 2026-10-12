
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_QR_RETAILER_1
(
   qr_rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,qr_rtl_srt_cd
) 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   qrtl.qr_rtl_id
  ,COALESCE(qrtl.rtl_desc, rtl.rtl_desc) AS rtl_desc
  ,COALESCE(rtl.rtl_desc_EN, qrtl.rtl_desc, rtl.rtl_desc) AS rtl_desc_EN
  ,qrtl.qr_rtl_srt_cd
FROM (
  SELECT
    CAST(TRUNC(key_field) AS INTEGER) AS qr_rtl_id,
    MIN(CAST(DECODE(sub_code, 'RTL_DESC', val) AS VARCHAR(128))) AS rtl_desc,
    MIN(CAST(TRUNC(DECODE(sub_code, 'QR_RTL_SRT_CD', val)) AS INTEGER))  AS qr_rtl_srt_cd
  FROM P_LEW_PROCESS_MSTR_AC.v_lil_code_1
  WHERE main_code='QR_RETAILER'
  GROUP BY qr_rtl_id
) AS qrtl
LEFT OUTER JOIN P_LEW_MART_CM.v_lil_retailer_1 AS rtl
  ON rtl.rtl_id = qrtl.qr_rtl_id;
