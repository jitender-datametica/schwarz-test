--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE  DBP_DATA.art

SET mutter_wb_id = dt.mutter_wb_id

FROM
	(SELECT
	   a.mandant_id AS mandant_id
	  ,a.art_id AS art_id
	  ,CASE WHEN a.mutter_wb_id IS NULL AND b.mandant_id IS NOT NULL
	        THEN a.art_id
                ELSE a.mutter_wb_id
           END AS mutter_wb_id
 	 FROM DBP_DATA.art  a 
	 LEFT OUTER JOIN
		(SELECT DISTINCT 
	          mandant_id
	         ,mutter_wb_id 
	 	 FROM DBP_DATA.art
	 	 WHERE mutter_wb_id IS NOT NULL 
	 	 GROUP BY 1, 2
		 ) b
	  ON a.mandant_id = b.mandant_id
	  AND a.art_id = b.mutter_wb_id
	) dt WHERE DBP_DATA.art.mandant_id = dt.mandant_id
  AND DBP_DATA.art.art_id     = dt.art_id
;

