CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_RTL_LVL
 /* 
 #DescStart# 
 #$Revision: 12250 $, $LastChangedBy: gkunz $ 
 #SubjectAreas#:
 #DescEnd# 
 */ 
(
   rtl_lvl
  ,rtl_lvl_desc
  ,rtl_tp_id
)
AS
SELECT
   Cast(rlt.rtl_lvl AS SMALLINT) AS rtl_lvl
  ,Cast(lvl.rtl_lvl_desc AS VARCHAR(128)) AS rtl_lvl_desc
  ,Cast(rlt.rtl_tp_id AS BYTEINT) AS rtl_tp_id
FROM p_lew_process_mstr_ac.v_lil_rtl_lvl_tp AS rlt
INNER JOIN p_lew_process_mstr_ac.v_lil_retailer_level AS lvl
  ON lvl.rtl_lvl = rlt.rtl_lvl;