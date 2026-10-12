/* #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: 	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_stdgroup_1 AS SELECT stdgroup_id,
  CASE
  WHEN stdgroup_id IN (1)
  THEN 'O&G'
  WHEN stdgroup_id IN (2)
  THEN 'Fleisch'
  WHEN stdgroup_id IN (3)
  THEN 'Mopro'
  WHEN stdgroup_id IN (4)
  THEN 'Non Food'
  ELSE 'Andere'
  END AS stdgroup_name
FROM ldl_p_lew_mart_msi.v_itm_statisticgroup_1 AS ISG
GROUP BY stdgroup_id;