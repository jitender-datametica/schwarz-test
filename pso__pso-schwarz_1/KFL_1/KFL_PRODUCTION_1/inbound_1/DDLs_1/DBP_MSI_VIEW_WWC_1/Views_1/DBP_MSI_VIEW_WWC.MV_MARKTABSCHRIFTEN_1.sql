create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_WWC.MV_MARKTABSCHRIFTEN_1(
	MANDANT_ID,
	WUP_ID,
	WUP_ABSCHRIFT_ID,
	POSITIONSNUMMER,
	ABSCHRIFTART_ID,
	NB_ID,
	DAT,
	ART_ID,
	ABSCHRIFTBETRAG_BRUTTO,
	ABSCHRIFTBETRAG_NETTO,
	MENGE_ABSCHRIFT,
	VK_BRUTTO,
	VK_AKTION_BRUTTO,
	WRG_ID
) as
  
  
  
   SELECT
   v01.mandant_id, 
   v01.wup_id, 
   v01.wup_abschrift_id, 
   v01.positionsnummer_id, 
   v01.abschriftart_id, 
   v01.nb_id, 
   v01.dat, 
   v01.art_id, 
   v01.abschriftbetrag_brutto, 
   v01.abschriftbetrag_netto, 
   CASE
  	WHEN v01.abschrift_menge_einh_id IS NULL AND v04.gewart_id = 'KG' AND v01.abschriftart_id <> '-1' THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
	  WHEN v01.abschrift_menge_einh_id = 'G' AND v01.abschriftart_id <> '-1'  THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
	 ELSE CAST (v01.menge_abschrift  AS DECIMAL(13,4)) END AS menge_abschrift,
   v01.vk_brutto, 
   v01.vk_aktion_brutto, 
   v02.default_wrg AS wrg_id
   FROM dbp_view.v_marktabschriften_1 v01
   INNER JOIN dbp_view.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id
   INNER JOIN DBP_VIEW.V_art_wg_zu_per_1 V03
   ON v01.Art_ID=v03.art_id
   AND v01.mandant_id = v03.mandant_id
   
   AND V03.wg_id!=961
   
   AND (v03.MANDANT_ID != 5
     
      OR (v03.MANDANT_ID =5 AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(v03.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
    )       
   AND V03.arthiertyp_id = 2
   AND V03.dat_bis = '9999-12-31'
   INNER JOIN
  (SELECT
   art_id
  ,gewart_id
   FROM dbp_view.v_art_1
   WHERE mandant_id = 1
  ) v04
  ON v01.art_id = v04.art_id
  WHERE v01.mandant_id=1;
