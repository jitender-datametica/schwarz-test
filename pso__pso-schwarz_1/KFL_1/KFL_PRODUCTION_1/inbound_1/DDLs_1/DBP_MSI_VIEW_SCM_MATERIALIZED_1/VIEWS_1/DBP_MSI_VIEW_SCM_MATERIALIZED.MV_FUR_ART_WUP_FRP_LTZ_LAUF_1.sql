create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_FUR_ART_WUP_FRP_LTZ_LAUF_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	FUR_STANDARDABWEICHUNG,
	FUR_KLASSIFIKATIONSMITTELWERT,
	DREHKLASSE_KZ,
	VERBRAUCHSKONSTANZ_KZ
) as


SELECT
v01.mandant_id,


v05.aktuell_wup_id wup_id, 
v01.nb_id,
v01.art_id,
v01.standardabweichung AS fur_standardabweichung,
v01.klassifikationsmittelwert AS fur_klassifikationsmittelwert,
v02.drehklasse_id AS drehklasse_kz,
CASE WHEN standardabweichung = 0 THEN 'nicht ermittelbar'
 WHEN standardabweichung/ NullIfZero (klassifikationsmittelwert) < 0.25 THEN 'X' 
            WHEN standardabweichung/ NullIfZero (klassifikationsmittelwert) >= 0.5 THEN 'Z' 
	        ELSE 'Y' 
	   END AS verbrauchskonstanz_kz
FROM dbp_view.v_fur_art_wup_frp_ltz_lauf_1 v01

INNER JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = v01.mandant_id
   
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

LEFT JOIN (SELECT menge_af.mandant_id
                 ,menge_af.wup_id
                 ,menge_af.art_id
                 ,1 - PERCENT_RANK() OVER (PARTITION BY menge_af.mandant_id, menge_af.wup_id ORDER BY menge_gewichtet_sum DESC) perc_rank
                 ,CASE WHEN perc_rank BETWEEN 0.200000 AND 1.000000 THEN 'A' 
				       WHEN perc_rank BETWEEN 0.150000 AND 0.199999 THEN 'B' 
                                       ELSE 'C' 
                  END AS drehklasse_id
           FROM (SELECT ab.mandant_id
                       ,ab.wup_id
                       ,ab.art_id
                       ,SUM(CASE WHEN akt_wo IN (-1,-2) THEN menge ELSE 0 END) AS menge_2wo_sum
                       ,SUM(CASE WHEN akt_wo < -2 THEN menge ELSE 0 END) AS menge_3b60wo_sum
                       ,menge_2wo_sum*0.2 + menge_3b60wo_sum*0.8 AS menge_gewichtet_sum
                 FROM dbp_view.v_artbew_wo_sum_1 ab
                 INNER JOIN (SELECT DISTINCT kjwo
                                            ,akt_wo
                             FROM dbp_view.v_tag_1) wo
                    ON ab.kjwo_kl = wo.kjwo 
                 INNER JOIN dbp_view.v_art_wup_status_per_1 asp 
				    ON ab.art_id = asp.art_id 
                   AND asp.mandant_id = ab.mandant_id
                   AND asp.wup_id = ab.wup_id
                   AND asp.dat_bis = '9999-12-31'
                 WHERE wo.akt_wo BETWEEN -60 AND -1 
                   AND dispomerkmal IN ( '10','11','12','14','S1','S2') 
                   AND bewart_id = 1001 
                 
                 
                 
                   AND ab.menge > 0          
                 GROUP BY ab.mandant_id
                         ,ab.wup_id
                         ,ab.art_id
                ) menge_af
	      ) v02
 ON v01.mandant_id = v02.mandant_id 
AND v01.wup_id = v02.wup_id 
AND v01.art_id = v02.art_id;