CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_RAW_BUYER_2
(
  raw_buyer_id
 ,description
 ,description_EN
) AS
SELECT
  raw_buyer_id
 ,description
 ,description_EN
FROM P_LEW_MART_CM.V_LIL_RAW_BUYER_2 ;

