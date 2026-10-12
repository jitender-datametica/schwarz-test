CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_OUG_ID_1(
	OUG_ID
) AS

/* LOOKUP : Kennzeichen Obst und Gemuese Artikel_1
   2022-07-26 ssch0611 : added entry for 0 = nicht gepflegt (union))
*/

SELECT $1 AS oug_id
FROM (
  SELECT oug_id 
  FROM DBP_VIEW.V_L_OUG_ID_1
  WHERE oug_id > 0 
  GROUP BY oug_id   
  
  UNION ALL
  SELECT 0 
  FROM TABLE(GENERATOR(rowcount => 1))    
) sub00
;