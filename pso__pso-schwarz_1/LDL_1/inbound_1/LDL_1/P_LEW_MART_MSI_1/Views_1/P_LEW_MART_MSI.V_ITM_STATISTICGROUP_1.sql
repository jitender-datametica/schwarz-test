CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_STATISTICGROUP_1 AS
   /* 	
   #DescStart# 	
   #$Revision: 6806 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Language_views 	
   #DescEnd# 	
   */	
	
   SELECT	
   t1.client_id
   ,t1.statisticgroup_id
   ,t1.statisticgroup_desc
   ,t1.language_id
   ,CASE	
         WHEN t1.statisticgroup_id IN (1)     THEN 1	
         WHEN t1.statisticgroup_id IN (3,4)   THEN 2	
         WHEN t1.statisticgroup_id IN (6)     THEN 3	
         WHEN t1.statisticgroup_id IN (10,11) THEN 4	
         ELSE 5	
       END                                           AS stdgroup_id	
	
    FROM p_lew_core_ac.v_wawi_itm_statisticgroup_1 AS t1_1	
   INNER JOIN p_lew_mart_msi.v_ref_user_language_1 t2	
   ON LOWER(current_USER) = LOWER(t2.db_user)	
   AND t2.language_id = t1.language_id	
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end	
;