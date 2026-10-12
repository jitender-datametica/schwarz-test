CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_PROGNOSE_FUR_2 (
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	DAT_PROGNOSELAUF,
	DIAGNOSE_ID,
	PROGNOSE_BEZ,
	KJWO,
	KJMO,
	PROGNOSE_KENNZEICHEN_FUR,
	PROGNOSE_HORIZONT_FUR,
	MENGE_PROGNOSE_SA_FUR,
	MENGE_PROGNOSE_AF_FUR,
	MENGE_PROGNOSE_FUR,
	MENGE_PROGNOSE_MAX_FUR,
	VK_MENGE_FUR,
	VK_MENGE_FUR_OPA,
	VK_MENGE_SA_FUR,
	VK_MENGE_AF_FUR,
	ABS_DIFF_FUR,
	ABS_DIFF_SA_FUR,
	ABS_DIFF_AF_FUR
) AS
-- AP0063264 | nwag2310 | 2020-09-22 | prognose bez attr = legacy
-- Prognosen FuR + ggfs. Absatz
-- AP0082929 | nwag2310 | 2021-03-24 | +menge_prognose_max_fur
-- AP0138978 |dknop | adding vk_menge_fur_opa
--2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
SELECT
 p_fur.mandant_id
--,p_fur.wup_id
--,CASE WHEN TRY_CAST(p_fur.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id
,v05.aktuell_wup_id wup_id
,p_fur.nb_id
,p_fur.art_id
,p_fur.dat
,CASE
 WHEN p_fur.dat <= CURRENT_DATE THEN p_fur.dat- 1
 ELSE CURRENT_DATE END AS dat_prognoselauf
,'    ' AS diagnose_id
,'LEGACY_ATTR_DO_NOT_USE' AS prognose_bez
,t.kjwo
,t.kjmo
,CASE
 WHEN p_fur.menge_prognose_aktion > 0 THEN 'SA'
  ELSE 'AF' END AS prognose_kennzeichen_fur
,p_fur.prognose_horizont AS prognose_horizont_fur
,p_fur.menge_prognose_aktion AS menge_prognose_sa_fur
,CASE
 WHEN p_fur.menge_prognose_aktion > 0 THEN 0
  ELSE p_fur.menge_prognose END AS menge_prognose_af_fur
,CASE
 WHEN p_fur.menge_prognose_aktion > 0
  THEN p_fur.menge_prognose_aktion ELSE p_fur.menge_prognose END AS menge_prognose_fur
,p_fur.menge_prognose_max AS menge_prognose_max_fur         
,COALESCE(artbew.vk_menge, 0) AS vk_menge_fur
,COALESCE(artbew.vk_menge, 0)- COALESCE(CASE WHEN artbew.mandant_id = 1 THEN absch_de.menge_preisabschriften ELSE absch_kmo.menge_preisabschriften END, 0) AS vk_menge_fur_opa
,COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_fur
,COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_fur
,ABS(menge_prognose_fur - vk_menge_fur) AS abs_diff_fur
,ABS(menge_prognose_sa_fur - vk_menge_sa_fur) AS abs_diff_sa_fur
,ABS(menge_prognose_af_fur - vk_menge_af_fur) AS abs_diff_af_fur

FROM dbp_view.v_fur_prognose_2 p_fur
LEFT OUTER JOIN (SELECT v01.dat
                       ,v01.art_id
                       ,v01.mandant_id
                       ,v01.nb_id
                       ,v01.wup_id
                       ,SUM(v01.menge) AS vk_menge
                       ,SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END) vk_menge_sa
                       ,SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END) vk_menge_af
                FROM dbp_view.v_artbew_2 v01 
		        GROUP BY v01.dat
                        ,v01.art_id
                        ,v01.mandant_id
                        ,v01.nb_id
                        ,v01.wup_id
) artbew_2
 ON p_fur.mandant_id = artbew.mandant_id
AND p_fur.wup_id     = artbew.wup_id 
AND p_fur.dat        = artbew.dat 
AND p_fur.art_id     = artbew.art_id

--marktabschriften_2 de

INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = p_fur.mandant_id 
   AND v05.wup_id = p_fur.wup_id
   --AND v05.wup_id = CASE WHEN TRY_CAST(p_fur.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(p_fur.wup_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

LEFT JOIN (SELECT
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat
,SUM(CASE WHEN abschrift_menge_einh_id = 'G' THEN menge_abschrift/1000 ELSE menge_abschrift END) menge_preisabschriften 
FROM dbp_view.v_marktabschriften_2 v01 
WHERE v01.MANDANT_ID=1 AND v01.abschriftart_id IN (5,7)
GROUP BY
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat

)absch_de
ON  p_fur.mandant_id = absch_de.mandant_id
AND p_fur.wup_id = absch_de.wup_id
AND p_fur.art_id = absch_de.art_id
AND p_fur.dat = absch_de.dat

--marktabschriften_2 kmo 

LEFT JOIN (SELECT absch.mandant_id, absch.wup_id, absch.art_id, DAT_UMBEW AS dat, SUM( MENGE_ERF) menge_preisabschriften
FROM dbp_view.v_art_umbewertung_2 absch
   WHERE ( absch.mandant_id= 6 AND PREIS_AEND_GRUND_ID = 2 ) OR
( absch.mandant_id IN (2,4,5,7,8) AND PREIS_AEND_GRUND_ID = 7 ) OR
( absch.mandant_id= 3 AND PREIS_AEND_GRUND_ID = 11 ) 
GROUP BY 1,2,3,4
)absch_kmo
ON  p_fur.mandant_id = absch_kmo.mandant_id
AND p_fur.wup_id = absch_kmo.wup_id
AND p_fur.art_id = absch_kmo.art_id
AND p_fur.dat = absch_kmo.dat

JOIN DBP_VIEW.v_tag_2 t
ON p_fur.dat = t.dat;