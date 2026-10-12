/* #DescStart# 
 #$Revision: 12250 $, $LastChangedBy: gkunz $ 
 #SubjectAreas#:
 #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_rpt_rank_2 (rank_nr) AS SELECT ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) AS
 rank_nr
FROM ldl_p_lew_mart_cm.v_lil_client_2
QUALIFY (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) <= 6;