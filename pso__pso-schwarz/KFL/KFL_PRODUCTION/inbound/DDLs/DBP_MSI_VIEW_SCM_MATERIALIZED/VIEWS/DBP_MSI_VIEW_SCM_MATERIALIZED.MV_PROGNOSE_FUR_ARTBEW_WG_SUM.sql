create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_PROGNOSE_FUR_ARTBEW_WG_SUM(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	DAT_PROGNOSELAUF,
	DIAGNOSE_ID,
	PROGNOSE_BEZ,
	KJWO,
	KJMO,
	PROGNOSE_KENNZEICHEN_FUR,
	PROGNOSE_HORIZONT_FUR,
	WG_ID,
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
) as



SELECT
 fur_pass.mandant_id
 
, v05.aktuell_wup_id wup_id_

,fur_pass.nb_id
,fur_pass.dat
,fur_pass.dat_prognoselauf
,fur_pass.diagnose_id
,fur_pass.prognose_bez
,fur_pass.kjwo
,fur_pass.kjmo
,fur_pass.prognose_kennzeichen_fur
,fur_pass.prognose_horizont_fur

,awg.wg_id

,SUM(fur_pass.menge_prognose_sa_fur) AS menge_prognose_sa_fur
,SUM(fur_pass.menge_prognose_af_fur) AS menge_prognose_af_fur
,SUM(fur_pass.menge_prognose_fur) AS menge_prognose_fur
,SUM(fur_pass.menge_prognose_max_fur) AS menge_prognose_max_fur
,SUM(fur_pass.vk_menge_fur) AS vk_menge_fur
,SUM(fur_pass.vk_menge_fur_opa) AS vk_menge_fur_opa
,SUM(fur_pass.vk_menge_sa_fur) AS vk_menge_sa_fur
,SUM(fur_pass.vk_menge_af_fur) AS vk_menge_af_fur
,SUM(fur_pass.abs_diff_fur) AS abs_diff_fur
,SUM(fur_pass.abs_diff_sa_fur) AS abs_diff_sa_fur
,SUM(fur_pass.abs_diff_af_fur) AS abs_diff_af_fur

FROM
( 
SELECT
 p_fur.mandant_id
,p_fur.wup_id
,p_fur.nb_id
,p_fur.art_id
,p_fur.dat
,CASE WHEN p_fur.dat <= CURRENT_DATE THEN p_fur.dat- 1 ELSE CURRENT_DATE END AS dat_prognoselauf
,'    ' AS diagnose_id
,'LEGACY_ATTR_DO_NOT_USE' AS prognose_bez
,t.kjwo
,t.kjmo
,CASE WHEN p_fur.menge_prognose_aktion > 0 THEN 'SA' ELSE 'AF' END AS prognose_kennzeichen_fur
,p_fur.prognose_horizont AS prognose_horizont_fur
,p_fur.menge_prognose_aktion AS menge_prognose_sa_fur
,CASE WHEN p_fur.menge_prognose_aktion > 0 THEN 0 ELSE p_fur.menge_prognose END AS menge_prognose_af_fur
,CASE WHEN p_fur.menge_prognose_aktion > 0 THEN p_fur.menge_prognose_aktion ELSE p_fur.menge_prognose END AS menge_prognose_fur
,p_fur.menge_prognose_max AS menge_prognose_max_fur         
,COALESCE(artbew.vk_menge, 0) AS vk_menge_fur
,COALESCE(artbew.vk_menge, 0)- COALESCE(CASE WHEN artbew.mandant_id = 1 THEN absch_de.menge_preisabschriften ELSE absch_kmo.menge_preisabschriften END, 0) AS vk_menge_fur_opa
,COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_fur
,COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_fur
,ABS(menge_prognose_fur - vk_menge_fur) AS abs_diff_fur
,ABS(menge_prognose_sa_fur - vk_menge_sa_fur) AS abs_diff_sa_fur
,ABS(menge_prognose_af_fur - vk_menge_af_fur) AS abs_diff_af_fur

FROM DBP_VIEW.v_fur_prognose p_fur
LEFT OUTER JOIN ( 
                 SELECT v01.dat
                       ,v01.art_id
                       ,v01.mandant_id
                       ,v01.nb_id
                       ,v01.wup_id
                       ,SUM(v01.menge) AS vk_menge
                       ,SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END) vk_menge_sa
                       ,SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END) vk_menge_af
                 FROM DBP_VIEW.v_artbew v01
                 GROUP BY v01.dat
                         ,v01.art_id
                         ,v01.mandant_id
                         ,v01.nb_id
                         ,v01.wup_id
                 ) artbew
 ON p_fur.mandant_id = artbew.mandant_id
AND p_fur.wup_id     = artbew.wup_id 
AND p_fur.dat        = artbew.dat 
AND p_fur.art_id     = artbew.art_id

JOIN DBP_VIEW.v_tag t
ON p_fur.dat = t.dat

 

LEFT JOIN (SELECT
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat
,SUM(CASE WHEN abschrift_menge_einh_id = 'G' THEN menge_abschrift/1000 ELSE menge_abschrift END) menge_preisabschriften 
FROM dbp_view.v_marktabschriften v01 
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



LEFT JOIN (SELECT absch.mandant_id, absch.wup_id, absch.art_id, DAT_UMBEW AS dat, SUM( MENGE_ERF) menge_preisabschriften
FROM dbp_view.v_art_umbewertung absch
   WHERE ( absch.mandant_id= 6 AND PREIS_AEND_GRUND_ID = 2 ) OR
( absch.mandant_id IN (2,4,5,7,8) AND PREIS_AEND_GRUND_ID = 7 ) OR
( absch.mandant_id= 3 AND PREIS_AEND_GRUND_ID = 11 ) 
GROUP BY 1,2,3,4
)absch_kmo
ON  p_fur.mandant_id = absch_kmo.mandant_id
AND p_fur.wup_id = absch_kmo.wup_id
AND p_fur.art_id = absch_kmo.art_id
AND p_fur.dat = absch_kmo.dat

) fur_pass

JOIN DBP_VIEW.v_art_wg_zu_per awg
  ON fur_pass.mandant_id = awg.mandant_id 
 AND fur_pass.art_id     = awg.art_id 

INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = fur_pass.mandant_id 
   
   AND v05.wup_id = fur_pass.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))


WHERE awg.arthiertyp_id = 2
  AND awg.dat_bis = '9999-12-31'

GROUP BY fur_pass.mandant_id
        
        ,wup_id_
        ,fur_pass.nb_id
        ,fur_pass.dat
        ,fur_pass.dat_prognoselauf
        ,fur_pass.diagnose_id
        ,fur_pass.prognose_bez
        ,fur_pass.kjwo
        ,fur_pass.kjmo
        ,fur_pass.prognose_kennzeichen_fur
        ,fur_pass.prognose_horizont_fur

        ,awg.wg_id;