CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_PSA_PARAMETER as
   /* 	
   #DescStart# 	
   #$Revision: 8438 $, $LastChangedBy: umeister $ 	
   #SubjectAreas#: Aktionsverkauf 	
   #DescEnd# 	
   */	
	
   SELECT	
   ENV_CD    AS ENV_CD,	
   REPORT_ID AS PSA_REPORT_ID,	
   WITHDRAWAL,	
   REPORT_FROM,	
   REPORT_UNTIL	
    FROM p_lew_process_ac.v_psa_report_parameter	
    GROUP BY 1,2,3,4,5	
;