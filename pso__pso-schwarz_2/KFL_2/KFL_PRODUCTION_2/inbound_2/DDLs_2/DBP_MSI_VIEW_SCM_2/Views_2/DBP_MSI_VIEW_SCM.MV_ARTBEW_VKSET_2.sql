CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTBEW_VKSET_2(
	DAT,
	KJWO,
	KJMO,
	ART_ID,
	ART_ID_BESTELLARTIKEL,
	FAKTOR,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	VK_MENGE,
	VK_MENGE_BESTELLARTIKEL,
	VK_MENGE_AF,
	VK_MENGE_AF_BESTELLARTIKEL,
	VK_MENGE_SA,
	VK_MENGE_SA_BESTELLARTIKEL,
	UMSATZ_NETTO_BESTELLARTIKEL,
	UMSATZ_NETTO_AF_BESTELLARTIKEL,
	UMSATZ_NETTO_SA_BESTELLARTIKEL,
	UMSATZ_NETTO,
	UMSATZ_NETTO_AF,
	UMSATZ_NETTO_SA
) AS

--2025-04-07,AP0261080,dknop, initial
WITH VKS AS (
SELECT 
mast.mandant_id
,mast.stueckliste_id
--,t.dat
,a.hwg_id
,mast.art_id AS art_id_vkset 

,stpo.art_id AS art_id_komponente

,stpo.komponentenmenge
,stpo.komponentenmenge_einh_id
,mara.gewart_id AS menge_einh_komp
,mara_komp.gewart_id AS menge_einh_vkset
,marm_st.bruttogew AS brtgew_komp
,marm_komp.umrech_faktor
,marm_st.umrech_faktor
,--Gleiche ME, z. B. ST in ST:
CASE WHEN stpo.komponentenmenge_einh_id = mara.gewart_id  THEN stpo.komponentenmenge 
--G in ST/KG:
WHEN stpo.komponentenmenge_einh_id = 'G' AND mara_komp.gewart_id IN ('KG', 'ST') THEN (stpo.komponentenmenge) / marm_komp.umrech_faktor --CASE WHEN marm_st.bruttogew <> 0 THEN (marm_st.bruttogew*1000) 
ELSE 1 END AS faktor_vkset_zu_komponente
FROM dbp_view.v_stueckliste_2 mast_2

JOIN dbp_view.v_art_2 mara_2
ON mara.mandant_id = mast.mandant_id
AND mara.art_id = mast.art_id
AND mara.artikeltyp_id=10
/*
JOIN dbp_view.v_tag_2 t
ON t.dat BETWEEN mast.dat_von AND mast.dat_bis
*/
JOIN dbp_view.v_stueckliste_det_2 stpo_2
ON mast.mandant_id = stpo.mandant_id 
AND mast.stueckliste_id = stpo.stueckliste_id

JOIN dbp_view.v_art_2 mara_komp
ON mara_komp.mandant_id = stpo.mandant_id
AND mara_komp.art_id = stpo.art_id

JOIN dbp_msi_view_scm.mv_art_denorm_2 a
ON a.mandant_id = stpo.mandant_id
AND a.art_id = stpo.art_id

--umrechnung von G in KG
JOIN dbp_view.v_art_umrechnung_faktor_per_2 marm_komp
ON stpo.mandant_id = marm_komp.mandant_id  
AND stpo.art_id = marm_komp.art_id
--AND t.dat BETWEEN marm_komp.dat_von AND marm_komp.dat_bis
AND marm_komp.dat_bis = '9999-12-31'
AND stpo.komponentenmenge_einh_id = marm_komp.altnv_menge_einh_id

--umrechnung von KG in ST
JOIN dbp_view.v_art_umrechnung_faktor_per_2 marm_st
ON stpo.mandant_id = marm_st.mandant_id  
AND stpo.art_id = marm_st.art_id
--AND t.dat BETWEEN marm_st.dat_von AND marm_komp.dat_bis
AND marm_st.dat_bis = '9999-12-31'
AND mara_komp.gewart_id = marm_st.altnv_menge_einh_id

WHERE mast.stueckliste_verwendung_id=3 AND stpo.stueckliste_typ_id = 'M'
AND mara.mandant_id=1
--AND t.dat = CURRENT_DATE --
AND a.hwg_id NOT IN (82) --ohne Imbiss
QUALIFY COUNT(DISTINCT art_id_komponente) OVER (PARTITION BY mast.mandant_id,  art_id_vkset --, t.dat
) = 1
AND COUNT(DISTINCT art_id_vkset) OVER (PARTITION BY mast.mandant_id,  art_id_komponente --, t.dat
) = 1

)


SELECT
   artbew.dat,
   t.kjwo,
   t.kjmo,
   artbew.art_id,
   COALESCE(vks_komp.art_id_komponente,vks_vks.art_id_komponente) AS art_id_bestellartikel,
   CASE WHEN vks_vks.mandant_id IS NOT NULL THEN vks_vks.FAKTOR_VKSET_ZU_KOMPONENTE ELSE 1 END AS faktor,
   artbew.mandant_id,  
   artbew.nb_id,
   v05.aktuell_wup_id wup_id,
        artbew.vk_menge,
      artbew.vk_menge*faktor AS vk_menge_bestellartikel,
     artbew.vk_menge_af,
     artbew.vk_menge_af*faktor AS vk_menge_af_bestellartikel,
    artbew.vk_menge_sa,
   artbew.vk_menge_sa*faktor AS vk_menge_sa_bestellartikel,
   artbew.umsatz_netto*faktor AS umsatz_netto_bestellartikel,
   artbew.umsatz_netto_af*faktor AS umsatz_netto_af_bestellartikel,
   artbew.umsatz_netto_sa*faktor AS umsatz_netto_sa_bestellartikel,
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
   FROM dbp_view.v_artbew_2 v01

CROSS JOIN dbp_msi_view_scm.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v02 
    GROUP BY
   v01.dat,
   v01.art_id,
   v01.mandant_id,
   v01.nb_id,
   v01.wup_id) artbew_2
   JOIN dbp_view.v_tag_2 t ON artbew.dat = t.dat
   
 INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = artbew.mandant_id
   AND v05.wup_id = artbew.wup_id
   AND v05.nb_id = 0
  
LEFT JOIN vks vks_komp ON --artbew.dat = vks_komp.dat AND
artbew.mandant_id = vks_komp.mandant_id AND artbew.art_id = vks_komp.art_id_komponente
LEFT JOIN vks vks_vks  ON --artbew.dat = vks_vks.dat AND    
artbew.mandant_id = vks_vks.mandant_id AND artbew.art_id = vks_vks.art_id_vkset

WHERE vks_vks.mandant_id IS NOT NULL OR vks_komp.mandant_id IS NOT NULL
;