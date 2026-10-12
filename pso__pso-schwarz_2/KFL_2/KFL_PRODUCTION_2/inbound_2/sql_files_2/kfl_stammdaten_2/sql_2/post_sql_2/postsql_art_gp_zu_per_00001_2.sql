--AW 2021-04-22 check OK
UPDATE DBP_DATA.gp_2 
SET herst_fg = 1
FROM
(SELECT
	 MAX(t1.herst_id)       as dt_herst_id
	,t2.gp_id 		as dt_gp_id
	,t2.mandant_id          as dt_mandant_id
 FROM  DBP_DATA.art_gp_zu_per_2 t1_2
 INNER JOIN DBP_DATA.gp_2 t2
	 ON t1.herst_id   = t2.gp_id
	AND t1.mandant_id = t2.mandant_id
 GROUP BY 2,3
 ) dt WHERE gp_id      = dt_gp_id
  AND mandant_id = dt_mandant_id
;

INSERT INTO DBP_DATA.art_gp_zu_per_2
(
dat_von
,mandant_id
,art_id
,gp_id
,einkaufsorganisation_id
,gp_art_id
,dat_bis
,herst_id
,mhd_zeitraum_dz
,mutter_ek_id
)
SELECT

 dt1.dat_von
,dt1.mandant_id
,dt1.art_id
,-1 AS gp_id
,dt2.einkaufsorganisation_id
,'-1' AS gp_art_id
,dt1.dat_bis
,-2 AS herst_id
,-1 AS mhd_zeitraum_dz
,-1 mutter_ek_id

FROM DBP_DATA.art_2 dt1

INNER JOIN DBP_DATA.l_einkaufsorganisation_2 dt2
ON dt1.mandant_id = dt2.mandant_id
AND dt2.einkaufsorganisation_id = 1000

LEFT OUTER JOIN DBP_DATA.art_gp_zu_per_2 dt3
ON dt1.mandant_id = dt3.mandant_id
AND dt1.art_id = dt3.art_id

WHERE dt1.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
AND   dt1.mandant_id = 1
AND  dt3.art_id IS NULL
;

