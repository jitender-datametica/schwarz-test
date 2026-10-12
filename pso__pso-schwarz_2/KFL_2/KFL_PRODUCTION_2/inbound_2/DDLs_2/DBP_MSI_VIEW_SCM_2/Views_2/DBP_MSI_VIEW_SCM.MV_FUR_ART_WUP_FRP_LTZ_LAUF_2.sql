CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_fur_art_wup_frp_ltz_lauf_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	FUR_STANDARDABWEICHUNG,
	FUR_KLASSIFIKATIONSMITTELWERT,
	DREHKLASSE_KZ,
	VERBRAUCHSKONSTANZ_KZ
) AS
--nfis0811: Auslagerung Drehklassenbestimmung von BE in View:
--2024-08-06,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
SELECT
v01.mandant_id,
--v01.wup_id,
--CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id, 
v05.aktuell_wup_id wup_id, 
v01.nb_id,
v01.art_id,
v01.standardabweichung AS fur_standardabweichung,
v01.klassifikationsmittelwert AS fur_klassifikationsmittelwert,
v02.drehklasse_id AS drehklasse_kz,
CASE WHEN standardabweichung = 0 THEN 'nicht ermittelbar'
 WHEN standardabweichung/ NullIfZero (klassifikationsmittelwert) < 0.25 THEN 'X' --01.10.2020 sgro2903 nullifzero eingefügt
            WHEN standardabweichung/ NullIfZero (klassifikationsmittelwert) >= 0.5 THEN 'Z' --01.10.2020 sgro2903 nullifzero eingefügt
	        ELSE 'Y' 
	   END AS verbrauchskonstanz_kz
FROM dbp_view.v_fur_art_wup_frp_ltz_lauf_2 v01
--Subselect für Ermittlung der Drehklasse
INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id
   --AND v05.wup_id = CASE WHEN TRY_CAST(v01.wup_id  AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v01.wup_id  AS INTEGER) END
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
                 FROM dbp_view.v_artbew_wo_sum_2 ab
                 INNER JOIN (SELECT DISTINCT kjwo
                                            ,akt_wo
                             FROM dbp_view.v_tag_2) wo
                    ON ab.kjwo_kl = wo.kjwo 
                 INNER JOIN dbp_view.v_art_wup_status_per_2 asp 
				    ON ab.art_id = asp.art_id 
                   AND asp.mandant_id = ab.mandant_id
                   AND asp.wup_id = ab.wup_id
                   AND asp.dat_bis = '9999-12-31'
                 WHERE wo.akt_wo BETWEEN -60 AND -1 --Letzte 60 Wochen
                   AND dispomerkmal IN ( '10','11','12','14','S1','S2') --nur Autodispo-Artikel_2
                   AND bewart_id = 1001 -- nur Absatz AF            
                 --debug
                 --and ab.wup_id = 3000 and ab.mandant_id=1 
                 --ganz DE läuft ca. 30 sek, ein Markt ca. 10 sek 
                   AND ab.menge > 0          
                 GROUP BY ab.mandant_id
                         ,ab.wup_id
                         ,ab.art_id
                ) menge_af
	      ) v02
 ON v01.mandant_id = v02.mandant_id 
AND v01.wup_id = v02.wup_id 
AND v01.art_id = v02.art_id;