UPDATE  DBP_DATA.best_belegfluss_bnk  

SET gp_id = gp_id_

FROM   (SELECT 
		mandant_id  	AS mandant_id_,
		best_beleg_id  	AS best_beleg_id_,
		CASE 	WHEN mandant_id = 1 and gp_id< 1000000 and gp_id >99999 THEN  gp_id * 10
			ELSE gp_id END  AS gp_id_ 
	FROM DBP_DATA.besch_best bb
	WHERE (mandant_id,best_beleg_id) IN ( 	SELECT mandant_id,best_beleg_id
						FROM ${TEMP_TABLE}
						WHERE gp_id= -1
						GROUP BY 1,2
					    )
	GROUP BY 1,2,3
	)  t2		
 WHERE 	gp_id  		= -1
AND 	mandant_id     	= mandant_id_
AND 	best_beleg_id  	= best_beleg_id_
;

