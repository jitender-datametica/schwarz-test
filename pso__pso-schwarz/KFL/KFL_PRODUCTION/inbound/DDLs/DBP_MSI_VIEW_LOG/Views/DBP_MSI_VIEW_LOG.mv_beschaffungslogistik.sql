CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BESCHAFFUNGSLOGISTIK(
	LAD_KOM_FG,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	BELOS_WUP_ID,
	LAGERORT_ID,
	TDL_ORT,
	K_NA_FG,
	BELOS_VORGANGART_ID,
	BELOS_VORGANG_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	SONDERABWICKLUNG_ID,
	DAT_LEISTUNG,
	DAT_ABHOLUNG_BIS,
	DAT_ZUSTELLUNG_BIS,
	DAT_SENDUNG_OFFEN,
	DAT_WARE_VERSANDBEREIT,
	DAT_SENDUNG_BEAUFTRAGT,
	DAT_SYSTEM_ZUGESTELLT,
	DATZEIT_SENDUNG_OFFEN,
	DATZEIT_WARE_VERSANDBEREIT,
	DATZEIT_SENDUNG_BEAUFTRAGT,
	DATZEIT_SYSTEM_ZUGESTELLT,
	DELTA_WARE_VERSANDBEREIT_SENDUNG_OFFEN,
	DELTA_SENDUNG_BEAUFTRAGT_WARE_VERSANDBEREIT,
	DELTA_SYSTEM_ZUGESTELLT_DATZEIT_WARE_VERSANDBEREIT,
	TRANSPORTAUFTRAG_ID,
	TOUR_ID,
	BELOS_ADRESSE_ABSENDER_NUM_ID,
	BELOS_ADRESSE_ABHOLUNG_ID,
	ORT,
	PLZ,
	SAMMEL_LADUNG_FG,
	BELOS_ADRESSE_SPEDITION_ID,
	BELOS_LADUNG_ID,
	ZUSATZ_SPOT,
	MANUELLE_DISPO,
	REFERENZ,
	BELOS_AUFTRAG_ID_EXTERN,
	BELOS_SENDUNG_ID_EXTERN,
	GEWICHT_SENDUNG,
	GEBINDE_ANZ,
	STELLPLATZKATEGORIE,
	ANZ_UNTERVERPACKUNG,
	VOL_STAURAUM,
	ANZ_STELLPLATZ_VORLAUF,
	ANZ_STELLPLATZ_HAUPTLAUF,
	LAND_ID,
	BELOS_BESTELL_BELEG_ID_EXTERN,
	AUFWAND_GESAMT,
	THRESHOLD_FG,
	AUFWAND_VORLAUF,
	AUFWAND_HAUPTLAUF,
	AUFWAND_UMSCHLAG,
	AUFWAND_DIESEL,
	ERTRAG_GESAMT,
	ERTRAG_DIESEL,
	GP_ID,
	BESCH_REGION_ID,
	BESCH_REGION_KOORDINATION_ID,
	TMS
) AS
-- 2022-05-19, AP0112140, SPEC0155506, initial, dknop
-- 2022-07-21, AP0112140, SPEC0155506, updating logic for gp_id, dknop
-- 2022-07-22, AP0112140, SPEC0155506, COALESCE for tour_id, removing duplication because of join to belos_packstueck, correcting logic for gp_id*, adding datzeit_abholung_bis, datzeit_zustellung_bis
																	
-- 2022-08-01, AP0140953, updating logic for zusatz_spot, adding manuelle Dispo
-- 2022-08-04, AP0140953, correcting logic for aufwand_gesamt and ertrag_gesamt by adding soll_ist_fg=1; sendung_fg=1 in join to v_belos_packstueck; adding sammel_ladung_fg=1 in join to v_belos_teilstrecke
-- 2022-08-19, AP0140953, SPEC0164166, adding datzeit_system_zugestellt
-- 2022-09-12, AP0140953, SPEC0164166, adding besch_region
-- 2022-09-21, AP0140953, SPEC0164166, updaing logic for plz and ort for k_na_fg=1, dknop
-- 2022-09-21, AP0140953, SPEC0164166, adding tdl_ort, dknop
-- 2022-12-01, updating  belos_adresse_spedition_id from K-NA to 429458, Coalesce for b_vor.lagerort_id
-- 2022-12-20, AP0140953, SPEC0164166,correcting join to v_gp_plz_besch_region_zu_per (adding CASE WHEN  b_vor.belos_vorgangart_id='K-NA')
-- 2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu -> AKT_MSI_USER_PRJ_WRG_TYP_ZU
-- 2023-01-10, AP0140953, SPEC0164166, updating logic for land for k_na_fg=1, dknop
-- 2023-02-06, dknop, adding condition than when b_vor.belos_vorgangart_id='K-NA' THEN sammel_ladung_fg = '1'  
--2024-10-29, dknop, adding tms logic
--2024-11-19, nwag, *10 instead of RPAD function to avoid SNFL error
SELECT 
 CASE WHEN min_storno_fg=1 THEN 1 ELSE 0 END AS lad_kom_fg
,b_vor.mandant_id
,b_vor.wup_id
,b_vor.nb_id
,CASE WHEN b_vor.belos_vorgangart_id IN ( 'K-RET' , 'K-LT' , 'K-AV' ) THEN b_vor.wup_id
      ELSE COALESCE(b_ad_wup.wup_id,'-1') END AS belos_wup_id 
,COALESCE(CASE WHEN b_vor.lagerort_id='' THEN NULL ELSE lagerort_id END, '-1')
,CASE WHEN b_vor.k_na_fg=0 THEN COALESCE(b_ad_tdl_ort.ort,'') ELSE 'K-NA' END AS TDL_ort
,b_vor.k_na_fg
,b_vor.belos_vorgangart_id
,b_vor.belos_vorgang_id
,b_vor.belos_adresse_empfaenger_id
,b_vor.sonderabwicklung_id
,b_vor.dat_leistung
,DATE(b_vor.datzeit_abholung_bis) AS abholtermin_bis
,DATE(b_vor.datzeit_zustellung_bis) AS zustelltermin_bis

,DATE(b_vor.datzeit_sendung_offen) AS dat_sendung_offen
,DATE(b_vor.datzeit_ware_versandbereit) AS dat_ware_versandbereit
,DATE(b_vor.datzeit_sendung_beauftragt) AS dat_sendung_beauftragt
,DATE(b_vor.datzeit_system_zugestellt) AS datzeit_system_zugestellt


,b_vor.datzeit_sendung_offen
,b_vor.datzeit_ware_versandbereit
,b_vor.datzeit_sendung_beauftragt
,b_vor.datzeit_system_zugestellt


,DATEDIFF(DAY,b_vor.datzeit_ware_versandbereit,b_vor.datzeit_sendung_offen) AS delta_ware_versandbereit_sendung_offen
,DATEDIFF(DAY,b_vor.datzeit_sendung_beauftragt,b_vor.datzeit_ware_versandbereit) AS delta_sendung_beauftragt_ware_versandbereit
,DATEDIFF(DAY,b_vor.datzeit_system_zugestellt,b_vor.datzeit_zustellung_bis) AS delta_system_zugestellt_datzeit_ware_versandbereit


,b_vor.transportauftrag_id
,COALESCE(b_vor.tour_id,-1)
,b_vor.belos_adresse_absender_num_id
,b_vor.belos_adresse_abholung_id
,CASE WHEN b_vor.k_na_fg=0 THEN b_ad.ort ELSE b_ad_k_na.ort END ort 
,CASE WHEN b_vor.k_na_fg=0 THEN b_ad.plz ELSE b_ad_k_na.plz END plz
,CASE WHEN b_vor.belos_vorgangart_id='K-NA' THEN 1 ELSE b_vor.sammel_ladung_fg END AS sammel_ladung_fg
,CASE WHEN b_vor.belos_vorgangart_id='K-NA' THEN COALESCE (NULLIF('',b_vor.belos_adresse_spedition_id),'429458') ELSE b_vor.belos_adresse_spedition_id END AS belos_adresse_spedition_id
,b_vor_lad.belos_ladung_id
,CASE WHEN b_lad.zusatz_spot ILIKE 'spot' THEN 'X' ELSE ' ' END AS zusatz_spot
,CASE WHEN b_lad.zusatz_spot ILIKE 'md' THEN 'X' ELSE ' ' END AS manuelle_Dispo
,b_vor.referenz
,COALESCE (b_vor.belos_auftrag_id_extern, ' ') AS belos_auftrag_id_extern 
,COALESCE (b_vor.belos_sendung_id_extern, ' ') AS belos_sendung_id_extern
,b_vor.gewicht_sendung
,b_pack.gebinde_anz
,sp_kat.stellplatzkategorie
,b_vor.anz_unterverpackung
,b_vor.vol_stauraum
,b_vor_lad.anz_stellplatz_vorlauf
,b_vor_lad.anz_stellplatz_hauptlauf
,CASE WHEN b_vor.k_na_fg=0 THEN b_ad.land_id ELSE b_ad_k_na.land_id END land_id
,b_vor.belos_bestell_beleg_id_extern
,CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN b_trans_auf.aufwand_gesamt
                                             ELSE ver_agg.aufwand_gesamt END AS aufwand_gesamt	
,CASE WHEN b_vor.k_na_fg=1 AND thr_fg.thr_fg = 1 THEN 0 
		WHEN b_vor.k_na_fg=1 AND thr_fg.thr_fg IS NULL THEN 1																															
                                             ELSE NULL END AS threshold_fg
,CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN b_trans_auf.aufwand_vorlauf 
                                             ELSE CASE WHEN b_vor.sammel_ladung_fg=1 THEN ver_agg.aufwand_vorlauf ELSE 0 END END AS aufwand_vorlauf
,CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN b_trans_auf.aufwand_hauptlauf
                                             ELSE CASE WHEN b_vor.sammel_ladung_fg=1 THEN ver_agg.aufwand_hauptlauf ELSE 0 END END AS aufwand_hauptlauf
,CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN b_trans_auf.aufwand_umschlag
                                             ELSE CASE WHEN b_vor.sammel_ladung_fg=1 THEN ver_agg.aufwand_umschlag ELSE 0 END END AS aufwand_umschlag
,CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN b_trans_auf.aufwand_diesel 
                                             ELSE ver_agg.aufwand_diesel  END AS aufwand_diesel
,ver_agg.ertrag_gesamt
,ver_agg.ertrag_diesel

,CASE WHEN b_vor.gp_id =-1 
      THEN COALESCE(CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN bb_kna.gp_id ELSE bb.gp_id END ,'-1') 
      ELSE  b_vor.gp_id*10 END AS gp_comp_id 
,COALESCE(b_reg.besch_region_id,-1)
,COALESCE(b_reg.besch_region_koordination_id,-1)
,'BELOS'    AS TMS 
FROM dbp_view.v_belos_vorgang b_vor

LEFT JOIN dbp_view.v_ts_belos_adresse_wup_zu b_ad_wup
ON b_vor.belos_adresse_empfaenger_id= b_ad_wup.belos_adresse_id
AND b_vor.mandant_id = b_ad_wup.mandant_id

LEFT JOIN
(SELECT
 ver.belos_vorgang_id
,ver.mandant_id
,ver.wrg_id 
,SUM(CASE WHEN (ver.kunde_fg=0) AND ver_kost.soll_ist_fg=1 THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS aufwand_gesamt
,SUM(CASE WHEN (ver.kunde_fg=0 AND ver_kost.soll_ist_fg=1 AND ver_kost.verrechfall_kostenart_id<>'KLTSZ' AND ver.belos_leistungsart_id=1) THEN ver_kost.betrag_kosten ELSE 0 END) AS aufwand_vorlauf
,SUM(CASE WHEN (ver.kunde_fg=0 AND ver_kost.soll_ist_fg=1 AND ver_kost.verrechfall_kostenart_id<>'KLTSZ' AND ver.belos_leistungsart_id=2) THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS aufwand_hauptlauf
,SUM(CASE WHEN (ver.kunde_fg=0 AND ver_kost.soll_ist_fg=1 AND ver_kost.verrechfall_kostenart_id= 'KLUMS') THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS aufwand_umschlag
,SUM(CASE WHEN (ver.kunde_fg=0 AND ver_kost.soll_ist_fg=1 AND ver_kost.verrechfall_kostenart_id='KLTSZ') THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS aufwand_diesel
,SUM(CASE WHEN (ver.kunde_fg=1) AND ver_kost.soll_ist_fg=1 THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS ertrag_gesamt
,SUM(CASE WHEN (ver.kunde_fg=1 AND ver_kost.soll_ist_fg=1 AND ver_kost.verrechfall_kostenart_id='KLTSZ') THEN CASE WHEN wrg_typ.wrg_typ_id=0 THEN ver_kost.betrag_kosten*kurs.umrechnungskurs ELSE ver_kost.betrag_kosten END ELSE 0 END) AS ertrag_diesel
,MIN(ver.storno_fg) AS min_storno_fg
FROM dbp_view.v_verrechfall ver
JOIN dbp_view.v_verrechfall_kosten ver_kost 
ON ver.verrechfall_id=ver_kost .verrechfall_id 
AND ver.mandant_id=ver_kost.mandant_id  
AND ver_kost.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090') 
 
LEFT JOIN dbp_msi_view_log.mv_kurs kurs 
ON ver.wrg_id = kurs.von_wrg_id

INNER JOIN dbp_view.v_mandant_wrg_typ_zu wrg_typ 
ON ver_kost.mandant_id = wrg_typ.mandant_id 
INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU  wrg_typ_user 
ON wrg_typ.wrg_typ_id = wrg_typ_user.wrg_typ_id
 
 GROUP BY 
 ver.belos_vorgang_id
,ver.mandant_id
,ver.wrg_id 

) ver_agg

ON b_vor.belos_vorgang_id=ver_agg.belos_vorgang_id
AND b_vor.mandant_id=ver_agg.mandant_id

LEFT JOIN 
(SELECT
 b_trans_auf.belos_vorgang_id
,b_trans_auf.mandant_id
,CASE WHEN wrg_typ.wrg_typ_id=0 THEN b_trans_auf.aufwand_gesamt*kurs.umrechnungskurs ELSE b_trans_auf.aufwand_gesamt END AS aufwand_gesamt
,CASE WHEN wrg_typ.wrg_typ_id=0 THEN b_trans_auf.aufwand_vorlauf*kurs.umrechnungskurs ELSE b_trans_auf.aufwand_vorlauf END AS aufwand_vorlauf
,CASE WHEN wrg_typ.wrg_typ_id=0 THEN b_trans_auf.aufwand_hauptlauf *kurs.umrechnungskurs ELSE b_trans_auf.aufwand_hauptlauf END AS aufwand_hauptlauf
,CASE WHEN wrg_typ.wrg_typ_id=0 THEN b_trans_auf.aufwand_umschlag*kurs.umrechnungskurs ELSE b_trans_auf.aufwand_umschlag END AS aufwand_umschlag
,CASE WHEN wrg_typ.wrg_typ_id=0 THEN b_trans_auf.aufwand_diesel*kurs.umrechnungskurs ELSE b_trans_auf.aufwand_diesel END AS aufwand_diesel
FROM
dbp_view.v_belos_transportauftrag_aufwand_upload b_trans_auf
LEFT JOIN dbp_msi_view_log.mv_kurs kurs 
ON b_trans_auf.wrg_id = kurs.von_wrg_id
INNER JOIN dbp_view.v_mandant_wrg_typ_zu wrg_typ 
ON b_trans_auf.mandant_id= wrg_typ.mandant_id 
INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU  wrg_typ_user 
ON wrg_typ.wrg_typ_id = wrg_typ_user.wrg_typ_id
)b_trans_auf
ON b_vor.belos_vorgang_id=b_trans_auf.belos_vorgang_id
AND b_vor.mandant_id=b_trans_auf.mandant_id

LEFT JOIN 
(SELECT
 mandant_id
,belos_vorgang_id
,SUM(gebinde_anz) AS gebinde_anz FROM dbp_view.v_belos_packstueck
WHERE belosart_fg = 0
AND sendung_fg=1
GROUP BY
 mandant_id
,belos_vorgang_id
) b_pack

ON b_vor.belos_vorgang_id=b_pack.belos_vorgang_id
AND b_vor.mandant_id= b_pack.mandant_id


LEFT JOIN 
(SELECT b_teil.belos_vorgang_id
 ,b_teil.mandant_id
,MAX(b_teil.belos_ladung_id) AS belos_ladung_id
,SUM(CASE WHEN b_teil.teilstrecke_nr=1 AND b_vor.sammel_ladung_fg=1 THEN b_teil.anz_stellplatz ELSE 0 END) AS anz_stellplatz_vorlauf
,SUM(CASE WHEN b_teil.teilstrecke_nr=2 AND b_vor.sammel_ladung_fg=1 THEN b_teil.anz_stellplatz ELSE 0 END) AS anz_stellplatz_hauptlauf
FROM dbp_view.v_belos_teilstrecke b_teil
JOIN dbp_view.v_belos_vorgang b_vor
 ON b_vor.belos_vorgang_id=b_teil.belos_vorgang_id
AND b_vor.mandant_id=b_teil.mandant_id

GROUP BY
 b_teil.belos_vorgang_id
 ,b_teil.mandant_id) b_vor_lad
ON b_vor.belos_vorgang_id=b_vor_lad.belos_vorgang_id
AND b_vor.mandant_id=b_vor_lad.mandant_id


LEFT JOIN dbp_view.v_belos_ladung b_lad
ON b_vor_lad.belos_ladung_id=b_lad.belos_ladung_id
AND b_vor_lad.mandant_id=b_lad.mandant_id

LEFT JOIN dbp_view.v_belos_adresse b_ad
ON b_vor.belos_adresse_abholung_id=b_ad.belos_adresse_id
AND b_vor.mandant_id=b_ad.mandant_id
AND b_ad.spedition_fg = 0 AND b_vor.k_na_fg=0 

LEFT JOIN dbp_view.v_belos_adresse b_ad_k_na
ON b_vor.belos_adresse_absender_num_id=b_ad_k_na.belos_adresse_num_id
AND b_vor.mandant_id=b_ad_k_na.mandant_id
AND b_ad_k_na.spedition_fg = 0 AND b_vor.k_na_fg=1

LEFT JOIN dbp_view.v_belos_adresse b_ad_tdl_ort
ON b_vor.belos_adresse_spedition_id=b_ad_tdl_ort.belos_adresse_id
AND b_vor.mandant_id=b_ad_tdl_ort.mandant_id
AND b_ad_tdl_ort.spedition_fg = 1 

LEFT JOIN dbp_view.v_besch_best bb_kna
ON TRY_CAST(b_vor.belos_bestell_beleg_id_extern AS DECIMAL(18,0)) =bb_kna.best_beleg_id
AND b_vor.mandant_id=bb_kna.mandant_id
AND b_vor.gp_id =-1 

LEFT JOIN (SELECT 
           belos_vorgang_id, 
           mandant_id, 
           MIN(best_beleg_id) AS best_beleg_id 
           FROM dbp_view.v_besch_best_belos_vorgang_zu GROUP BY belos_vorgang_id, mandant_id) bbb_vor
ON b_vor.belos_vorgang_id=bbb_vor.belos_vorgang_id
AND b_vor.mandant_id=bbb_vor.mandant_id
AND b_vor.gp_id =-1 

LEFT JOIN dbp_view.v_besch_best bb
ON bbb_vor.best_beleg_id =bb.best_beleg_id
AND bbb_vor.mandant_id=bb.mandant_id

LEFT JOIN (SELECT belos_vorgang_id, mandant_id, 1 AS thr_fg FROM dbp_view.v_belos_transportauftrag_aufwand_upload b_trans_auf) thr_fg
    
    ON  b_vor.belos_vorgang_id=thr_fg.belos_vorgang_id
    AND b_vor.mandant_id=thr_fg.mandant_id

LEFT JOIN dbp_view.v_gp_plz_besch_region_zu_per b_reg
ON CASE WHEN b_vor.gp_id =-1 
      THEN COALESCE(CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN bb_kna.gp_id ELSE bb.gp_id END ,'-1') 
      ELSE b_vor.gp_id * 10 END = b_reg.gp_id 
AND b_vor.mandant_id=b_reg.mandant_id
AND b_vor.dat_leistung BETWEEN b_reg.dat_von AND b_reg.dat_bis
AND (CASE WHEN  b_vor.belos_vorgangart_id='K-NA' THEN b_ad_k_na.plz ELSE b_ad.plz END)=b_reg.abholung_plz

LEFT JOIN dbp_msi_data.ts_l_stellplatzkategorie sp_kat
ON b_pack.gebinde_anz BETWEEN anz_stellplatz_von AND anz_stellplatz_bis
AND b_vor.sammel_ladung_fg=sp_kat.sammel_ladung_fg

WHERE b_vor.belosart_fg=0;