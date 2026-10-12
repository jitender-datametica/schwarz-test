CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_RPT_RANK
 /* 
 #DescStart# 
 #$Revision: 12250 $, $LastChangedBy: gkunz $ 
 #SubjectAreas#:
 #DescEnd# 
 */
 (
   rank_nr
) AS
SELECT Row_Number() Over (ORDER BY 1) AS rank_nr
FROM p_lew_mart_cm.v_lil_client
QUALIFY rank_nr <= 6;