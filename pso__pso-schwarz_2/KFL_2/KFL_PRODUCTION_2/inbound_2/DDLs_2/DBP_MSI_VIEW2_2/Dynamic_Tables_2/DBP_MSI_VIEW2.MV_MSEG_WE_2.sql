CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_MSEG_WE_2
(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT,
	MSEG_MENGE_WE_WWC,
	MSEG_VK_BRUTTO_WE_WWC,
	MSEG_VK_NETTO_WE_WWC
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
  
  SELECT
   v01.mandant_id, 
   v01.art_id,
   v01.wup_id,               
   v01.nb_id, 
   v01.dat_buch AS dat,                 
   SUM(v01.menge_lagerbew_bme) AS MSEG_MENGE_WE_WWC,
   SUM(v01.betrag_verkauf) AS MSEG_VK_BRUTTO_WE_WWC,
   SUM(v01.betrag_vk_netto) AS MSEG_VK_NETTO_WE_WWC
  
   FROM dbp_view.v_lagerbew_det_2 v01
   JOIN dbp_view.v_lagerbew_det_wwc_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
   AND v01.lagerbew_beleg_pos_id = v02.lagerbew_beleg_pos_id
   AND v01.kj = v02.kj
   AND v01.dat_buch = v02.dat_buch
   WHERE v01.mandant_id = 1  
   AND v01.lager_bewart_id IN ('901', '902', '905', '906', '907', '908', '915', '916', '301', '302', '303', '304', '317', '318', '319', '320')
   GROUP BY 
   v01.mandant_id, 
   v01.art_id,
   v01.wup_id,               
   v01.nb_id, 
   v01.dat_buch
 
   UNION ALL
   
   SELECT
   mandant_id, 
   art_id,
   wup_id,               
   nb_id, 
   dat_buch AS dat,                 
   SUM(menge_lagerbew_bme) AS MSEG_MENGE_WE_WWC,
   SUM(betrag_verkauf) AS MSEG_VK_BRUTTO_WE_WWC,
   SUM(betrag_vk_netto) AS MSEG_VK_NETTO_WE_WWC
   FROM dbp_view.v_lagerbew_det_delta_2
   WHERE MANDANT_ID = 1 
   AND lager_bewart_id IN ('901', '902', '905', '906', '907', '908', '915', '916', '301', '302', '303', '304', '317', '318', '319', '320')
   GROUP BY  
   mandant_id, 
   art_id,
   wup_id,               
   nb_id, 
   dat_buch;