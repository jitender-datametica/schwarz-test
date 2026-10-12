create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ARTBEW_1(
	DAT,
	KJWO,
	KJMO,
	ART_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	VK_MENGE,
	VK_MENGE_OPA,
	VK_MENGE_AF,
	VK_MENGE_SA,
	UMSATZ_NETTO,
	UMSATZ_NETTO_AF,
	UMSATZ_NETTO_SA
) as






SELECT
   artbew.dat,
   t.kjwo,
   t.kjmo,
   artbew.art_id,
   artbew.mandant_id,  
    
   artbew.nb_id,
   
   
   v05.aktuell_wup_id wup_id,
  


      artbew.vk_menge,
   COALESCE(vk_menge, 0)- COALESCE(CASE WHEN artbew.mandant_id = 1 THEN absch_de.menge_preisabschriften ELSE absch_kmo.menge_preisabschriften END, 0) AS vk_menge_opa,
   artbew.vk_menge_af,
   artbew.vk_menge_sa,
        









   artbew.umsatz_netto,
   artbew.umsatz_netto_af,
   artbew.umsatz_netto_sa
FROM
   (SELECT 
   v01.dat,
   v01.art_id,
   v01.mandant_id,
   v01.nb_id,
   v01.wup_id,
   SUM(v01.menge) AS vk_menge,
   SUM(CASE WHEN v01.bewart_id IN (1001, 1010) THEN v01.menge ELSE NULL END) AS vk_menge_af,
   SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END) AS vk_menge_sa,
   
   




    SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto,
    SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto_af,
    SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto_sa
    
    
   FROM dbp_view.v_artbew_1 v01


CROSS JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v02 
    GROUP BY
   v01.dat,
   v01.art_id,
   v01.mandant_id,
   v01.nb_id,
   v01.wup_id) artbew_1
   
 INNER JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = artbew.mandant_id
   
   AND v05.wup_id = artbew.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))
  
  


LEFT JOIN (SELECT
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat
,SUM(CASE WHEN abschrift_menge_einh_id = 'G' THEN menge_abschrift/1000 ELSE menge_abschrift END) menge_preisabschriften 
FROM dbp_view.v_marktabschriften_1 v01 
WHERE v01.MANDANT_ID=1 AND v01.abschriftart_id IN (5,7)
GROUP BY
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat

)absch_de
ON  artbew.mandant_id = absch_de.mandant_id
AND artbew.wup_id = absch_de.wup_id
AND artbew.art_id = absch_de.art_id
AND artbew.dat = absch_de.dat



LEFT JOIN (SELECT absch.mandant_id, absch.wup_id, absch.art_id, DAT_UMBEW AS dat, SUM( MENGE_ERF) menge_preisabschriften
FROM dbp_view.v_art_umbewertung_1 absch
   WHERE ( absch.mandant_id= 6 AND PREIS_AEND_GRUND_ID = 2 ) OR
( absch.mandant_id IN (2,4,5,7,8) AND PREIS_AEND_GRUND_ID = 7 ) OR
( absch.mandant_id= 3 AND PREIS_AEND_GRUND_ID = 11 ) 
GROUP BY 1,2,3,4
)absch_kmo
ON  artbew.mandant_id = absch_kmo.mandant_id
AND artbew.wup_id = absch_kmo.wup_id
AND artbew.art_id = absch_kmo.art_id
AND artbew.dat = absch_kmo.dat  
 
JOIN dbp_view.v_tag_1 t ON artbew.dat = t.dat;