CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BESCHAFFUNGSLOGISTIK_KOSTENART_2(
	LAD_KOM_FG,
	BELOS_VORGANG_ID,
	MANDANT_ID,
	BELOS_WUP_ID,
	WUP_ID,
	NB_ID,
	K_NA_FG,
	DAT_LEISTUNG,
	BELOS_ADRESSE_SPEDITION_ID,
	ZUSATZ_SPOT,
	MANUELLE_DISPO,
	BELOS_VORGANGART_ID,
	TRANSPORTAUFTRAG_ID,
	TOUR_ID,
	SAMMEL_LADUNG_FG,
	GP_ID,
	VERRECHFALL_KOSTENART_ID,
	AUFWAND_GESAMT,
	ERTRAG_GESAMT,
	THRESHOLD_FG,
	BESCH_REGION_ID,
	BESCH_REGION_KOORDINATION_ID,
	TMS
) AS 
-- 2022-06-07, AP0112140, SPEC0155506, initial, dknop
 --2022-07-22, AP0112140, SPEC0155506,  COALESCE(b_vor.tour_id, -1), updating logic for belos_wup_id  dknop
 --2022-07-25, AP0112140, SPEC0155506, adding LAD_KOM_FG
 --2022-08-01, AP0140953, updating logic for zusatz_spot, adding manuelle Dispo
 --2022-08-04, AP0140953, correcting logic for aufwand_gesamt and ertrag_gesamt by adding soll_ist_fg=1; adding sammel_ladung_fg=1 in join to v_belos_teilstrecke_2
--2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_2 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU
 -- 2022-09-12, AP0140953, SPEC0164166, adding besch_region
 -- 2022-09-13, AP0140953, SPEC0164166, adding stellplatzkategorie*/
 -- 2022-12-01, updating  belos_adresse_spedition_id from K-NA to 429458
--2023-02-06, dknop, adding condition than when b_vor.belos_vorgangart_id='K-NA' THEN sammel_ladung_fg = '1'  
-- INC7606869, change akt_msi_user_wrg_typ_zu_2 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU
--2024-10-29, dknop, adding tms logic
 SELECT
 CASE WHEN min_storno_fg=1 THEN 1 ELSE 0 END AS lad_kom_fg
,b_vor.belos_vorgang_id
,b_vor.mandant_id
,CASE WHEN b_vor.belos_vorgangart_id IN ( 'K-RET' , 'K-LT' , 'K-AV' ) THEN b_vor.wup_id
      ELSE COALESCE(b_ad_wup.wup_id,'-1') END AS belos_wup_id 
,b_vor.wup_id
,b_vor.nb_id
,b_vor.k_na_fg
,b_vor.dat_leistung
,CASE WHEN b_vor.belos_vorgangart_id='K-NA' THEN COALESCE (NULLIF('',b_vor.belos_adresse_spedition_id), '429458') ELSE b_vor.belos_adresse_spedition_id END AS belos_adresse_spedition_id
,CASE WHEN b_lad.zusatz_spot ILIKE 'spot' THEN 'X' ELSE ' ' END AS zusatz_spot
,CASE WHEN b_lad.zusatz_spot ILIKE 'md' THEN 'X' ELSE ' ' END AS manuelle_Dispo
,b_vor.belos_vorgangart_id
,b_vor.transportauftrag_id
,COALESCE(b_vor.tour_id, -1) AS TOUR_ID
,CASE WHEN b_vor.belos_vorgangart_id='K-NA' THEN 1 ELSE b_vor.sammel_ladung_fg END AS sammel_ladung_fg
,CASE WHEN b_vor.gp_id<>'-1' THEN RPAD(b_vor.gp_id,7,0) ELSE b_vor.gp_id END AS gp_id
,aufwand_ertrag.verrechfall_kostenart_id 
,aufwand_ertrag.aufwand_gesamt
,aufwand_ertrag.ertrag_gesamt
,CASE WHEN b_vor.k_na_fg=1 AND thr_fg.thr_fg = 1 THEN 0 
		WHEN b_vor.k_na_fg=1 AND thr_fg.thr_fg IS NULL THEN 1																															
                                             ELSE NULL END AS threshold_fg
,COALESCE(b_reg.besch_region_id,-1)
,COALESCE(b_reg.besch_region_koordination_id,-1)
,'BELOS' AS tms

FROM dbp_view.v_belos_vorgang_2 b_vor

LEFT JOIN dbp_view.v_ts_belos_adresse_wup_zu_2 b_ad_wup
ON b_vor.belos_adresse_empfaenger_id= b_ad_wup.belos_adresse_id
AND b_vor.mandant_id = b_ad_wup.mandant_id

JOIN  
(SELECT
 ver.belos_vorgang_id
,ver.mandant_id
,ver_kost.verrechfall_kostenart_id 
,MIN(ver.storno_fg) AS min_storno_fg
,SUM(CASE WHEN ver.kunde_fg=0 AND ver_kost.soll_ist_fg=1 THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS aufwand_gesamt
,SUM(CASE WHEN ver.kunde_fg=1 AND ver_kost.soll_ist_fg=1 THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS ertrag_gesamt

FROM dbp_view.v_verrechfall_2 ver

JOIN dbp_view.v_verrechfall_kosten_2 ver_kost 
ON ver.verrechfall_id=ver_kost .verrechfall_id 
AND ver.mandant_id=ver_kost.mandant_id  
AND ver_kost.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090')

JOIN dbp_view.v_belos_vorgang_2 b_vor
ON b_vor.belos_vorgang_id=ver.belos_vorgang_id
AND b_vor.mandant_id=ver.mandant_id

LEFT JOIN dbp_msi_view_log.mv_kurs_2 kurs_2 ON ver.wrg_id = kurs.von_wrg_id
INNER JOIN dbp_view.v_mandant_wrg_typ_zu_2 wrg_typ ON ver_kost.mandant_id = wrg_typ.mandant_id 
INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 wrg_typ_user -- dbp_msi.akt_msi_user_wrg_typ_zu_2 wrg_typ_user
 ON wrg_typ.wrg_typ_id = wrg_typ_user.wrg_typ_id
 
WHERE b_vor.belos_vorgangart_id<>'K-NA'

 GROUP BY 
 ver.belos_vorgang_id
,ver.mandant_id
,ver_kost.verrechfall_kostenart_id 
,ver.wrg_id

   UNION         
 (       
    SELECT
     b_trans_auf.belos_vorgang_id
    ,b_trans_auf.mandant_id
    ,'K/NA' AS verrechfall_kostenart_id 
    ,0
    ,SUM(CASE WHEN wrg_typ.wrg_typ_id=0 THEN b_trans_auf.aufwand_gesamt*kurs.umrechnungskurs ELSE b_trans_auf.aufwand_gesamt END) AS aufwand_gesamt
    ,0 AS ertrag_gesamt
    FROM dbp_view.v_belos_transportauftrag_aufwand_upload_2 b_trans_auf
    JOIN dbp_view.v_belos_vorgang_2 b_vor
    ON  b_vor.belos_vorgang_id=b_trans_auf.belos_vorgang_id
    AND b_vor.mandant_id=b_trans_auf.mandant_id
    LEFT JOIN dbp_msi_view_log.mv_kurs_2 kurs_2 ON b_trans_auf.wrg_id = kurs.von_wrg_id
    INNER JOIN dbp_view.v_mandant_wrg_typ_zu_2 wrg_typ ON b_trans_auf.mandant_id= wrg_typ.mandant_id 
    INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 wrg_typ_user -- dbp_msi.akt_msi_user_wrg_typ_zu_2 wrg_typ_user 
     ON wrg_typ.wrg_typ_id = wrg_typ_user.wrg_typ_id
    WHERE b_vor.belos_vorgangart_id='K-NA'
    GROUP BY 
     b_trans_auf.belos_vorgang_id
    ,b_trans_auf.mandant_id
    ,b_trans_auf.wrg_id
   
   
    UNION
 
    SELECT
     ver.belos_vorgang_id
    ,ver.mandant_id
    ,ver_kost.verrechfall_kostenart_id 
    ,MIN(ver.storno_fg) AS min_storno_fg
    ,0 AS aufwand_gesamt
    ,SUM(CASE WHEN ver.kunde_fg=1 AND ver_kost.soll_ist_fg=1 THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS ertrag_gesamt
    FROM dbp_view.v_verrechfall_2 ver
    JOIN dbp_view.v_verrechfall_kosten_2 ver_kost 
    ON ver.verrechfall_id=ver_kost.verrechfall_id 
    AND ver.mandant_id=ver_kost.mandant_id  
    AND ver_kost.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090')
    JOIN dbp_view.v_belos_vorgang_2 b_vor
    ON b_vor.belos_vorgang_id=ver.belos_vorgang_id
    AND b_vor.mandant_id=ver.mandant_id
    LEFT JOIN dbp_msi_view_log.mv_kurs_2 kurs_2 ON ver.wrg_id = kurs.von_wrg_id
    INNER JOIN dbp_view.v_mandant_wrg_typ_zu_2 wrg_typ ON ver_kost.mandant_id = wrg_typ.mandant_id 
    INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 wrg_typ_user -- dbp_msi.akt_msi_user_wrg_typ_zu_2 wrg_typ_user 
     ON wrg_typ.wrg_typ_id = wrg_typ_user.wrg_typ_id
    WHERE b_vor.belos_vorgangart_id='K-NA'
    GROUP BY 
     ver.belos_vorgang_id
    ,ver.mandant_id
    ,ver_kost.verrechfall_kostenart_id
    ,ver.wrg_id )
 ) aufwand_ertrag
           
            
ON b_vor.belos_vorgang_id=aufwand_ertrag.belos_vorgang_id
AND b_vor.mandant_id=aufwand_ertrag.mandant_id
            
LEFT JOIN 
(SELECT b_teil.belos_vorgang_id
 ,b_teil.mandant_id
,MAX(b_teil.belos_ladung_id) AS belos_ladung_id
,SUM(CASE WHEN b_teil.teilstrecke_nr=1 AND b_vor.sammel_ladung_fg=1 THEN b_teil.anz_stellplatz ELSE 0 END) AS anz_stellplatz_vorlauf
,SUM(CASE WHEN b_teil.teilstrecke_nr=2 AND b_vor.sammel_ladung_fg=1 THEN b_teil.anz_stellplatz ELSE 0 END) AS anz_stellplatz_hauptlauf
FROM dbp_view.v_belos_teilstrecke_2 b_teil
JOIN dbp_view.v_belos_vorgang_2 b_vor
 ON b_vor.belos_vorgang_id=b_teil.belos_vorgang_id
AND b_vor.mandant_id=b_teil.mandant_id

GROUP BY
 b_teil.belos_vorgang_id
 ,b_teil.mandant_id) b_vor_lad
ON b_vor.belos_vorgang_id=b_vor_lad.belos_vorgang_id
AND b_vor.mandant_id=b_vor_lad.mandant_id

LEFT JOIN dbp_view.v_belos_ladung_2 b_lad
ON b_vor_lad.belos_ladung_id=b_lad.belos_ladung_id
AND b_vor_lad.mandant_id=b_lad.mandant_id

LEFT JOIN (SELECT belos_vorgang_id, mandant_id, 1 AS thr_fg FROM dbp_view.v_belos_transportauftrag_aufwand_upload_2 b_trans_auf) thr_fg
    
    ON  b_vor.belos_vorgang_id=thr_fg.belos_vorgang_id
    AND b_vor.mandant_id=thr_fg.mandant_id

LEFT JOIN dbp_view.v_belos_adresse_2 b_ad
ON b_vor.belos_adresse_abholung_id=b_ad.belos_adresse_id
AND b_vor.mandant_id=b_ad.mandant_id
AND spedition_fg = 0

LEFT JOIN dbp_view.v_gp_plz_besch_region_zu_per_2 b_reg
ON CASE WHEN b_vor.gp_id<>'-1' THEN RPAD(b_vor.gp_id,7,0) ELSE b_vor.gp_id END = b_reg.gp_id 
AND b_vor.mandant_id=b_reg.mandant_id
AND b_vor.dat_leistung BETWEEN b_reg.dat_von AND b_reg.dat_bis
AND b_ad.plz=b_reg.abholung_plz

LEFT JOIN 
(SELECT
 mandant_id
,belos_vorgang_id
,SUM(gebinde_anz) AS gebinde_anz FROM dbp_view.v_belos_packstueck_2
WHERE belosart_fg = 0
AND sendung_fg=1
GROUP BY
 mandant_id
,belos_vorgang_id
) b_pack

ON b_vor.belos_vorgang_id=b_pack.belos_vorgang_id
AND b_vor.mandant_id= b_pack.mandant_id



WHERE b_vor.belosart_fg=0 --and b_vor.transportauftrag_id='DE13584208'

 --AND b_vor.dat_leistung='2022-04-20' and b_vor.mandant_id=1 and b_ad_wup.wup_id=6902
;