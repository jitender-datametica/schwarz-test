UPDATE DBP_DATA.lief_einteilung_2

SET flw_fg = dd.flw_fg_

FROM
( 	SELECT
	 dt1.mandant_id		AS mandant_id_
	,dt1.best_beleg_id	AS best_beleg_id_
	,dt1.best_beleg_pos_id	AS best_beleg_pos_id_
	,dt1.einteil_id		AS einteil_id_
	,dt2.flw_fg		AS flw_fg_

	FROM  	${TEMP_TABLE} dt1
	INNER JOIN DBP_DATA.besch_best_det_2 dt2
	ON  	dt1.mandant_id        = dt2.mandant_id
	AND 	dt1.best_beleg_id     = dt2.best_beleg_id
	AND 	dt1.best_beleg_pos_id = dt2.best_beleg_pos_id
	AND 	dt2.flw_fg <>0
	GROUP BY 1,2,3,4,5
) dd
 WHERE 	mandant_id 		= mandant_id_
AND 	best_beleg_id      	= best_beleg_id_
AND 	best_beleg_pos_id      	= best_beleg_pos_id_
AND 	einteil_id      	= einteil_id_
;

