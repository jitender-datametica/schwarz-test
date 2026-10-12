create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_VERRECHFALL_KOSTEN_DL_1(
	MANDANT_ID,
	VERRECHFALL_KOSTEN_ID,
	WRG_ID,
	WRG_TYP_ID,
	VERRECHFALL_ID,
	VERRECHFALL_KOSTENART_ID,
	BETRAG_KOSTEN,
	DT_VERECHNUNG_INTERN,
	VORZEICHEN_FG
) as 






WITH  m_kostenart AS (
SELECT 'MDIES' AS verrechfall_kostenart_id UNION 
SELECT 'MSTRO' AS verrechfall_kostenart_id UNION
SELECT 'MGAS' AS verrechfall_kostenart_id UNION
SELECT 'MMAUT' AS verrechfall_kostenart_id UNION
SELECT 'MKUEH' AS verrechfall_kostenart_id 
)

SELECT
 mandant_id
,verrechfall_kosten_id




,CASE WHEN v04.wrg_typ_id=0 THEN 'EUR' ELSE v03.wrg_id END AS wrg_id_
,v03.wrg_typ_id
,verrechfall_id


,verrechfall_kostenart_id

,betrag_kosten


,dt_verechnung_intern
,vorzeichen_fg
 FROM DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_VERRECHFALL_KOSTEN_DL_1 v03
 INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v04 
 ON v03.wrg_typ_id = v04.wrg_typ_id 
 WHERE verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090') AND soll_ist_fg = 1 AND belosart_fg =1
   
 UNION

  SELECT 
 tu_k_up.mandant_id
,vk.verrechfall_kosten_id 
,CASE WHEN v05.wrg_typ_id=0 THEN 'EUR' ELSE tu_k_up.wrg_id END AS wrg_id_
,v05.wrg_typ_id
,vf.verrechfall_id
,m_kostenart.verrechfall_kostenart_id
,SUM(CASE WHEN m_kostenart.verrechfall_kostenart_id = 'MDIES' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_diesel * v03.umrechnungskurs ELSE betrag_diesel END  
          WHEN m_kostenart.verrechfall_kostenart_id = 'MSTRO' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_strom * v03.umrechnungskurs ELSE betrag_strom END 
          WHEN m_kostenart.verrechfall_kostenart_id = 'MGAS'  THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_gas * v03.umrechnungskurs ELSE betrag_gas END
          WHEN m_kostenart.verrechfall_kostenart_id = 'MMAUT' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_maut * v03.umrechnungskurs ELSE betrag_maut END
          WHEN m_kostenart.verrechfall_kostenart_id = 'MKUEH' THEN CASE WHEN v04.wrg_typ_id = 0 THEN betrag_kuehlung * v03.umrechnungskurs ELSE betrag_kuehlung END 
          ELSE 0 END) AS betrag_kosten_
,TIMESTAMP_FROM_PARTS(vk.dat_verrechnung_intern,COALESCE(vk.zeit_verrechnung_intern,'00:00:00')) AS dt_verechnung_intern
,CASE WHEN betrag_kosten_ < 0 THEN 1 ELSE 0 END AS vorzeichen_fg
 
FROM dbp_view.v_transportation_unit_kosten_1 tu_k_up

 JOIN ( SELECT mandant_id, tour_id, MAX(belos_vorgang_id) AS belos_vorgang_id, MAX(belos_adresse_absender_num_id) AS belos_adresse_absender_num_id 
       FROM dbp_view.v_belos_vorgang_1 
       GROUP BY  mandant_id, tour_id ) bv  
ON tu_k_up.mandant_id = bv.mandant_id
AND tu_k_up.transportation_unit_id = bv.tour_id
AND tu_k_up.wup_id = bv.belos_adresse_absender_num_id

JOIN ( 
       SELECT mandant_id, belos_vorgang_id , verrechfall_id, MAX(belos_adresse_rechnung_id) AS belos_adresse_rechnung_id , MAX(belos_adresse_steuerung_id) AS belos_adresse_steuerung_id 
       FROM dbp_view.v_verrechfall_1 bv  
       WHERE STORNO_FG=0 AND BELOSART_FG=1
       GROUP BY mandant_id, belos_vorgang_id, verrechfall_id
       ) vf_1
ON vf.mandant_id = bv.mandant_id
AND vf.belos_vorgang_id = bv.belos_vorgang_id

JOIN (SELECT mandant_id, verrechfall_id, MAX(verrechfall_kosten_id) AS verrechfall_kosten_id, MAX(dat_verrechnung_intern) AS dat_verrechnung_intern, MAX(zeit_verrechnung_intern) AS zeit_verrechnung_intern  
      FROM dbp_view.v_verrechfall_kosten_1 GROUP BY mandant_id, verrechfall_id)vk_1
ON vf.verrechfall_id = vk.verrechfall_id
AND vf.mandant_id=vk.mandant_id

LEFT JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs_1 v03 ON tu_k_up.wrg_id = v03.von_wrg_id
INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v04 ON bv.mandant_id = v04.mandant_id 
INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v05 
ON v04.wrg_typ_id = v05.wrg_typ_id

CROSS JOIN m_kostenart  

GROUP BY  tu_k_up.mandant_id,vk.verrechfall_kosten_id ,tu_k_up.wrg_id ,v05.wrg_typ_id,vf.verrechfall_id,m_kostenart.verrechfall_kostenart_id, vk.dat_verrechnung_intern, vk.zeit_verrechnung_intern
HAVING betrag_kosten_ > 0;