CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BSCH_RECH_DET_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	BSCH_ID,
	BSCH_POS_ID,
	ART_ID,
	BEWART_ID,
	GP_ID,
	BA_ID,
	BA_POS_ID,
	STATUS_2,
	LAGER_BEWART_ID,
	LAGERORT_ID,
	MENGE_RECH,
	BSCH_MENGE,
	BSCH_MENGE_RET
) AS

   -- FAKT Wareneingang/Retouren DEZENTRAL pro Artikel_2/Filiale
   -- Basis AIS view - FWWS Berichte MSC Fisch / Bio Backshop
   -- 2013-06-06 INITIAL
   -- 2014-02-25 bei WEs lager_bewart_id = 916 entfernt, bei Ret lager_bewart_id = 915 entfernt
   -- 2015-07-14 analog AIS_DE Status_2 2 gefiltert (aus Anfo #581040 RPW)
   -- 2015-07-14 Review
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 															      AS wup_id
 , v01.dat
 , v01.bsch_id
 , v01.bsch_pos_id
 , v01.art_id
 , v01.bewart_id
 , v01.gp_id
 , v01.ba_id
 , v01.ba_pos_id
 , v01.status_2
 , v01.lager_bewart_id
 , v01.lagerort_id
 , v01.menge_rech
 , CASE 
   WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906, 913, 915)  
   THEN v01.menge_rech END														      AS Bsch_Menge
 , CASE 
   WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916)  
   THEN v01.menge_rech END 														   AS Bsch_Menge_Ret
FROM dbp_view.v_bsch_rech_det_2 v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id


WHERE v01.nb_id = 0
AND v01.status_2 <> 2
;