CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_STDGROUP_2
AS	
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: 	
   #DescEnd# 	
   */	
	
   SELECT	
   isg.stdgroup_id,	
   CASE	
    WHEN stdgroup_id IN (1)  THEN 'O&G'	
    WHEN stdgroup_id IN (2) THEN 'Fleisch'	
    WHEN stdgroup_id IN (3) THEN 'Mopro'	
    WHEN stdgroup_id IN (4) THEN 'Non Food'	
    ELSE 'Andere'	
    END                                           AS stdgroup_name	
    FROM p_lew_mart_msi.v_itm_statisticgroup_2 isg	
   GROUP BY  isg.stdgroup_id;