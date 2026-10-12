create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_DT_LIEFERANTENMANAGEMENT_2(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	DAT_BUCH,
	ENDLIEF_FG,
	ZEIT_ENDLIEF_FG,
	BEST_MENGE_ORIG_FG,
	ANNAHMEVERWEIGERUNG_ID,
	NB_ID,
	ART_ID,
	BELEG_GP_ID,
	WUP_ID,
	BESTELLART_ID,
	DAT_BEST_BELEG,
	DAT_LIEF_WUNSCH,
	DAT_LIEF_BEWERTUNG,
	MENGE_LIEF,
	BETRAG_LAGERBEW_EK_N,
	BETRAG_BEST_EK_N,
	MENGE_BEST_BME,
	MENGE_BEST_ORIG,
	MENGE_BEST_KOLLI_ORIG,
	EKBE_WE_MENGE_KOLLI,
	MENGE_IST_KOLLI_ORIG,
	LAGERORT_ID,
	GP_ID,
	LOESCH_FG_EKKO,
	LOESCH_FG_EKPO,
	SELBSTABHOL_FG,
	ANZAHL_LIEF,
	ANZAHL_LIEF_POS,
	LAGER_BEWART_ID,
	MENGE_GESAMT,
	KOLLIFAKTOR,
	MENGE_IWT,
	MENGE_WERBUNG,
	MENGE_NONWBS,
	MENGE_NORMAL,
	WERBUNG_FG,
	WRG_ID,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI,
	SOLL_IST_LIEFERDATUM_DIFF_ABS,
	SOLL_IST_LIEFERDATUM_DIFF,
	IWT_ID,
	NEUER_ARTIKEL_FG,
	PLANLIEFERZEIT,
	GP_TEILSORTIMENT_ID,
	REICHWEITE,
	GP_DISPO_MULTI_ID,
	RATIO,
	BEDARFSNUMMER,
	ENDLIEF_FG_EKPO
) target_lag = '1 hour' refresh_mode = AUTO initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_LOG
 as
SELECT --DISTINCT
v01.mandant_id
,v01.best_beleg_id
,v01.best_beleg_pos_id
--,CASE WHEN v01.dat_buch = '1900-01-01' THEN DATE '9999-12-31' ELSE v01.dat_buch END AS dat_buch_
,v01.dat_buch AS dat_buch_
,v01.endlief_fg
,CASE WHEN v01.dat_buch IN ('1900-01-01', '9999-12-31'    ) THEN -2 ELSE v01.zeit_endlief_fg END AS zeit_endlief_fg

,CASE WHEN v01.mandant_id = 1 THEN v01.best_menge_orig_fg
WHEN v01.mandant_id > 1 AND ROW_NUMBER() OVER ( PARTITION BY v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id ORDER BY CASE WHEN v01.dat_buch = '1900-01-01' THEN DATE '9999-12-31' ELSE v01.dat_buch END , v01.lager_bewart_id) = 1 THEN 1 
ELSE 0 END AS BEST_MENGE_ORIG_FG_ 

--,v01.best_menge_orig_fg  AS BEST_MENGE_ORIG_FG_ 
,v01.annahmeverweigerung_id
,v01.nb_id
,v01.art_id
,v01.gp_id AS beleg_gp_id
,v01.wup_id
,v01.bestellart_id
,v01.dat_best_beleg
,v01.dat_lief_wunsch
,v01.dat_lief_bewertung
,v01.menge_lief
,v01.betrag_lagerbew_ek_n
,v01.betrag_best_ek_n
,v01.menge_best_bme
,v01.menge_best_bme * best_menge_orig_fg_   AS menge_best_orig
,v01.menge_lief_soll_kolli *  best_menge_orig_fg_ AS menge_best_kolli_orig
,CASE WHEN (v01.mandant_id, v01.art_id ) IN (SELECT MANDANT_ID, ART_ID FROM DBP_DATA.ART_2 WHERE BASISMENGE_EINH_ID = 'KG'  AND MANDANT_ID = 1) THEN NULL ELSE EKBE.we_menge_kolli END AS EKBE_we_menge_kolli
,COALESCE(EKBE_we_menge_kolli, v01.menge_lief_ist_kolli ) *  best_menge_orig_fg_ AS menge_ist_kolli_orig
,v01.lagerort_id
,v01.gp_id
,v01.loesch_fg_ekko
,v01.loesch_fg_ekpo
,v01.selbstabhol_fg
,v01.anzahl_lief
,v01.anzahl_lief_pos
,v01.lager_bewart_id
/*
,CASE WHEN v03.menge_normal IS NOT NULL THEN v03.menge_normal ELSE 0.000 END AS menge_gesamt
,CASE WHEN v03.menge_normal IS NOT NULL THEN (v03.menge_normal-v03.menge_iwt-v03.menge_werbung-v03.menge_bevorratung)* best_menge_orig_fg_ ELSE 0.000 END AS menge_normal
,CASE WHEN v03.menge_iwt IS NOT NULL THEN v03.menge_iwt * best_menge_orig_fg_ ELSE 0.000 END AS menge_iwt
,CASE WHEN v03.menge_werbung IS NOT NULL THEN v03.menge_werbung * best_menge_orig_fg_ ELSE 0.000 END AS menge_werbung
,CASE WHEN v03.menge_bevorratung IS NOT NULL THEN v03.menge_bevorratung * best_menge_orig_fg_ ELSE 0.000 END AS menge_bevorratung
*/
,v01.menge_lief_soll_kolli *  best_menge_orig_fg_ AS menge_gesamt_
, CASE WHEN (v001.menge_best_bme/ CASE WHEN COALESCE(v001.menge_best_kolli,1) = 0 THEN 1 ELSE v001.menge_best_kolli END) = 0 THEN 1
     ELSE (v001.menge_best_bme/ CASE WHEN COALESCE(v001.menge_best_kolli,1) = 0 THEN 1 ELSE v001.menge_best_kolli END) END *  best_menge_orig_fg_ AS kollifaktor
,CASE WHEN v001.best_menge_einh_id <> 'KG' THEN iwt.menge_block / NULLIFZERO(kollifaktor) ELSE iwt.menge_block END *  best_menge_orig_fg_ AS menge_block_iwt
,CASE WHEN v001.best_menge_einh_id <> 'KG' THEN block.menge_block / NULLIFZERO(kollifaktor) ELSE block.menge_block END *  best_menge_orig_fg_ AS menge_block_werbung
,CASE WHEN v001.best_menge_einh_id <> 'KG' THEN nonwbs.menge_block / NULLIFZERO(kollifaktor) ELSE nonwbs.menge_block END *  best_menge_orig_fg_ AS menge_block_nonwbs
, menge_gesamt_ - COALESCE(menge_block_iwt,0) - COALESCE(menge_block_werbung,0) - COALESCE(menge_block_nonwbs,0) AS menge_normal
, CASE WHEN block.menge_block > 0 THEN 1 ELSE 0 END AS werbung_fg
,v01.wrg_id 
,v01.vk_netto_lief_soll
,v01.vk_netto_lief_ist
,v01.menge_lief_soll_kolli
--,v01.menge_lief_ist_kolli
,COALESCE(EKBE_we_menge_kolli, v01.menge_lief_ist_kolli) AS menge_lief_ist_kolli
,CASE WHEN v01.dat_buch IN ('1900-01-01', '9999-12-31') AND v001.endlief_fg = 0 THEN Abs((CURRENT_DATE-1) - v01.dat_lief_bewertung)
WHEN v01.dat_buch IN ('1900-01-01', '9999-12-31') AND v001.endlief_fg = 1 THEN 0 
ELSE Abs(v01.dat_buch - v01.dat_lief_bewertung) END AS soll_ist_lieferdatum_diff_abs
,CASE WHEN v01.dat_buch IN ('1900-01-01', '9999-12-31') AND v001.endlief_fg = 0 THEN (CURRENT_DATE-1) - v01.dat_lief_bewertung
WHEN v01.dat_buch IN ('1900-01-01', '9999-12-31') AND v001.endlief_fg = 1 THEN 0
ELSE (v01.dat_buch - v01.dat_lief_bewertung) END AS soll_ist_lieferdatum_diff
,COALESCE(v045.iwt_id,'') AS iwt_id
,COALESCE(v045.neuer_artikel_fg,0) AS neuer_artikel_fg
,COALESCE(v045.planlieferzeit,-1) AS planlieferzeit
,CASE WHEN v045.gp_teilsortiment_id = '999999' THEN '' ELSE COALESCE(v045.gp_teilsortiment_id,'') END AS gp_teilsortiment_id
,COALESCE(v045.reichweite,-1) AS reichweite
,COALESCE(v045.gp_dispo_multi_id,-1) AS gp_dispo_multi_id
,COALESCE(v045.ratio,-1) AS ratio
,v001.bedarfsnummer
,v001.endlief_fg AS endlief_fg_ekpo 

FROM --DBP_VIEW.v_besch_best_lief_lbs_2 

(SELECT 
lbs.mandant_id
,lbs.best_beleg_id
,lbs.best_beleg_pos_id
,CASE WHEN lbs.dat_buch = '1900-01-01' THEN DATE '9999-12-31' ELSE lbs.dat_buch END AS dat_buch
,lbs.annahmeverweigerung_id
,lbs.nb_id
,lbs.art_id
,lbs.gp_id AS beleg_gp_id
,lbs.wup_id
,lbs.bestellart_id
,lbs.dat_best_beleg
,lbs.dat_lief_wunsch
,lbs.dat_lief_bewertung
,lbs.lagerort_id
,lbs.gp_id
,lbs.loesch_fg_ekko
,lbs.loesch_fg_ekpo
,lbs.selbstabhol_fg
--,COALESCE(marc.SELBSTABHOLUNG_FG, lbs.selbstabhol_fg) AS selbstabhol_fg --workaround KMO/derzeit nicht in EKPO_2 beladen!
,lbs.wrg_id 

,MAX(lbs.zeit_endlief_fg) AS zeit_endlief_fg
,MIN(lbs.lager_bewart_id) AS lager_bewart_id
,MAX(lbs.lager_bewart_id) AS lager_bewart_id_max
,MAX(lbs.endlief_fg) AS endlief_fg
,MAX(lbs.best_menge_orig_fg) AS best_menge_orig_fg
,MAX(lbs.menge_best_bme) AS menge_best_bme
,SUM(lbs.menge_lief) AS menge_lief
,SUM(lbs.MENGE_LIEF_IST_KOLLI) AS MENGE_LIEF_IST_KOLLI
,SUM(lbs.betrag_lagerbew_ek_n) AS betrag_lagerbew_ek_n
,MAX(lbs.betrag_best_ek_n) AS betrag_best_ek_n
,MAX(lbs.vk_netto_lief_soll) AS vk_netto_lief_soll
,MAX(lbs.vk_netto_lief_ist) AS vk_netto_lief_ist
,MAX(lbs.menge_lief_soll_kolli) AS menge_lief_soll_kolli
,MAX(lbs.anzahl_lief) AS anzahl_lief
,MAX(lbs.anzahl_lief_pos) AS anzahl_lief_pos

FROM DBP_VIEW.v_besch_best_lief_lbs_2 lbs
/*
LEFT JOIN DBP_VIEW.v_art_wup_status_per_2 marc_2
ON lbs.mandant_id=marc.mandant_id
AND lbs.wup_id=marc.wup_id
AND lbs.dat_best_beleg BETWEEN marc.dat_von AND marc.dat_bis
AND lbs.art_id=marc.art_id
AND marc.mandant_id > 1
*/
WHERE lbs.nb_id <> 99
AND lbs.bestellart_id IN ('ZLLF', 'ZBCZ', 'ZBPL', 'ZBSK', 'ZBHR', 'ZBRO', 'ZBBG','ZNL','ZNLP','ZNLS','ZNLW')
AND lbs.LAGER_BEWART_ID IN ('101','102','-1','915','916')
AND YEAR(lbs.dat_lief_bewertung) >= YEAR(CURRENT_DATE) - 1 --perf.+content
AND YEAR(lbs.dat_best_beleg) >= YEAR(CURRENT_DATE) - 2 --perf.

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19) v01

--Wird später ggfs. ins Backend verlagert:
LEFT JOIN (SELECT MANDANT_ID_,  BEST_BELEG_ID_,  BEST_BELEG_POS_ID_ , DAT_BUCH_, SUM(CASE WHEN SOLL_HABEN_KZ='H' THEN -1 ELSE 1 END * MENGE_BASIS) AS WE_MENGE_KOLLI FROM (
SELECT EKBE.MANDANT_ID MANDANT_ID_,  EKBE.BEST_BELEG_ID BEST_BELEG_ID_, EKBE.BEST_BELEG_POS_ID BEST_BELEG_POS_ID_,
MIN( EKBE.DAT_BUCH) OVER ( PARTITION BY  EKBE.MANDANT_ID , EKBE.BEST_BELEG_ID , EKBE.BEST_BELEG_POS_ID ) AS DAT_BUCH_LIEF,
CASE WHEN LAGER_BEWART_ID IN ('916','915') AND check_101 IS NULL
  THEN COALESCE(DAT_BUCH_LIEF, EKBE.DAT_BUCH)
  ELSE  EKBE.DAT_BUCH END AS DAT_BUCH_, SOLL_HABEN_KZ, MENGE_BASIS FROM DBP_DATA.BEST_BELEGFLUSS_2 EKBE
  LEFT JOIN (SELECT MANDANT_ID , BEST_BELEG_ID , BEST_BELEG_POS_ID, DAT_BUCH, 1 AS check_101  FROM DBP_DATA.BEST_BELEGFLUSS_2 WHERE  BEST_ENTW_TYP_ID='E'  
AND MANDANT_ID = 1 AND LAGER_BEWART_ID = '101' GROUP BY MANDANT_ID , BEST_BELEG_ID , BEST_BELEG_POS_ID, DAT_BUCH) check_101
ON  EKBE.MANDANT_ID = check_101.MANDANT_ID AND EKBE.BEST_BELEG_ID =  check_101.BEST_BELEG_ID AND EKBE.BEST_BELEG_POS_ID = check_101.BEST_BELEG_POS_ID AND EKBE.DAT_BUCH = check_101.DAT_BUCH
WHERE  BEST_ENTW_TYP_ID='E'  
AND EKBE.MANDANT_ID = 1 --für KMO bereits im backend aus EKBE!
AND LAGER_BEWART_ID IN ('916','915','101','102')
AND YEAR( EKBE.DAT_BUCH) >= YEAR(CURRENT_DATE) - 1
) EKBE_I
GROUP BY 1,2,3,4
) EKBE

ON v01.mandant_id = EKBE.mandant_id_
AND v01.best_beleg_id = EKBE.best_beleg_id_
AND v01.best_beleg_pos_id = EKBE.best_beleg_pos_id_
AND v01.dat_buch = EKBE.dat_buch_
--AND (v01.mandant_id, v01.art_id ) NOT IN (SELECT MANDANT_ID, ART_ID FROM DBP_DATA.ART_2 WHERE BASISMENGE_EINH_ID = 'KG'  AND MANDANT_ID = 1) 

JOIN DBP_VIEW.v_besch_best_det_2 v001
ON v01.mandant_id = v001.mandant_id
AND v01.best_beleg_id = v001.best_beleg_id
AND v01.best_beleg_pos_id = v001.best_beleg_pos_id
AND v01.dat_best_beleg = v001.dat_best_beleg
AND YEAR(v001.dat_best_beleg) >= YEAR(CURRENT_DATE) - 2 --perf.
--omit display components!
AND NOT ( v001.pos_kostenlos_fg = 1 AND RIGHT(v001.best_beleg_pos_id::VARCHAR,1) > 0 AND v001.mandant_id > 1 )

LEFT JOIN dbp_view.v_best_blockbestand_2 block
ON block.mandant_id = v001.mandant_id
AND block.best_beleg_id = v001.best_beleg_id
AND block.best_beleg_pos_id = v001.best_beleg_pos_id
AND block.prozess_id=1

LEFT JOIN dbp_view.v_best_blockbestand_2 iwt
ON iwt.mandant_id = v001.mandant_id
AND iwt.best_beleg_id = v001.best_beleg_id
AND iwt.best_beleg_pos_id = v001.best_beleg_pos_id
AND iwt.prozess_id=2

LEFT JOIN dbp_view.v_best_blockbestand_2 nonwbs
ON nonwbs.mandant_id = v001.mandant_id
AND nonwbs.best_beleg_id = v001.best_beleg_id
AND nonwbs.best_beleg_pos_id = v001.best_beleg_pos_id
AND nonwbs.prozess_id=3


/*
LEFT JOIN DBP_VIEW.v_vz_best_split_2 v03
   ON v01.best_beleg_id = v03.best_beleg_id
  AND v01.best_beleg_pos_id = v03.best_beleg_pos_id
  AND v01.mandant_id = v03.mandant_id
  AND v01.gp_id = v03.gp_id
*/
LEFT JOIN (SELECT v04.mandant_id
                 ,v04.dat_plan
                 ,v04.art_id
                 ,v05.wup_id
,v05.gp_id
,CASE WHEN v05.gp_teilsortiment_id = '' THEN '999999' ELSE v05.gp_teilsortiment_id END AS gp_teilsortiment_id
                 ,MAX(v04.iwt_id) iwt_id
                 ,MAX(v04.neuer_artikel_fg) neuer_artikel_fg
                 ,MAX(v05.planlieferzeit) planlieferzeit
                 ,MAX(v04.reichweite ) reichweite 
                 ,MAX(v04.ratio) ratio
                 ,MAX(v04.gp_dispo_multi_id) gp_dispo_multi_id

           FROM DBP_VIEW.v_art_gp_dispo_tag_2 v04 
JOIN DBP_VIEW.v_tag_2 v06 ON v04.dat_plan=v06.dat AND v06.akt_kj BETWEEN -1 AND 0
           JOIN DBP_VIEW.v_gp_dispo_vz_tag_2 v05
             ON v04.mandant_id = v05.mandant_id
             AND v04.dat_plan = v05.dat_plan
             AND v04.gp_dispo_id = v05.gp_dispo_id
WHERE v04.augeblendet_fg=0 
--AND v04.dat_plan >= CURRENT_DATE - 90
GROUP BY v04.mandant_id
                 ,v04.dat_plan
                 ,v04.art_id
                 ,v05.wup_id
,v05.gp_id
,v05.gp_teilsortiment_id) v045

ON v01.mandant_id=v045.mandant_id

  AND v01.art_id = v045.art_id
  AND v01.wup_id = v045.wup_id
  AND v01.dat_lief_bewertung = v045.dat_plan
  AND v01.gp_id = v045.gp_id
  AND v001.gp_teilsortiment_id = v045.gp_teilsortiment_id 
;
