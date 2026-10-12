create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_DT_WANKO_TMS_TOUR(
	MANDANT_ID,
	SYSTEM_ID,
	TMS_TOUR_ID,
	TRANSPORTATION_UNIT_ID,
	KJ_TRANSPORTATION_UNIT,
	TRANSPORTATION_UNIT_ID_EXT,
	TMS_TOUR_BEZ,
	DAT_TOUR,
	TOURART_ID,
	TMS_TOURART_ID,
	TMS_TOURART_BEZ,
	TMS_TOURTYP_ID,
	TMS_TOURSTATUS_ID,
	LIEFERKUNDE_TMS_GP_TYP_CD,
	TMS_STANDORTTYP_ID,
	LIEFERKUNDE_TMS_GP_ID,
	FRACHTZAHLER_ID,
	ANZ_STOPP,
	ANZ_STELLPLATZ,
	TMS_FAHRZEUG_ID,
	TMS_FAHRZEUGTYP_ID,
	TMS_TRAILER_ID,
	TMS_TRAILER_TYP_ID,
	SPEDITION_TMS_GP_ID,
	SPEDITION_TMS_GP_TYP_CD,
	TMS,
	TEMPERATURGRUPPE_ID,
	TMS_SORTIMENT_ID,
	ARTIKELSORTIMENT_ID,
	LAGERNUMMER_LES_ID,
	GUTSCHRIFT_ERSTELLT_FG,
	STARTLAGER_TMS_GP_ID,
	STARTLAGER_TMS_GP_TYP_CD,
	WUP_ID,
	ZIELLAGER_TMS_GP_ID,
	ZIELLAGER_TMS_GP_TYP_CD,
	MAUT_KM,
	LEER_KM,
	ANZ_AENDERUNG,
	WRG_ID,
	BETRAG_FIXKOSTEN,
	BETRAG_NETTO,
	BETRAG_DIESEL,
	BETRAG_STROM,
	BETRAG_GAS,
	BETRAG_MAUT,
	BETRAG_KUEHLUNG,
	RICHTUNG_ID,
	TMS_TREIBSTOFF_ID,
	KOSTEN_UPLOAD_FG,
	TU_COSTS_INCOMPLETE_FG,
	MENGE_LIEF_IST_KOLLI,
	VOLUMEN_GEDECKELT,
	GEWICHT_BRUTTO,
	ANZAHL_STELLPLATZ,
	ANZAHL_STELLPLATZ_GESAMT,
	ANZAHL_KUNDE_SORTIMENT,
	ANTEIL_STELLPLATZ,
	MENGE_GEFAHRGUT,
	RUECKFUEHRUNG_FG,
	EWM_FG,
	NUTZUNG_GRUND_ID,
	ANTRIEBSART_ID
) target_lag = '30 minutes' refresh_mode = AUTO initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_LOG
 as
--AP0230823,SPEC0266004, dknop, initial
--2024-11-05, dknop, correcting wrg
--2024-11-11, nwag, reformatting + anteil stellplatz if SAP+WANKO=0
--2024-11-12, dknop, adjusting tourart_id
--2024-11-12, nwag, use columns from tms_tour instead of view logic
--2024-11-13, nwag, adjustments for FLW tours
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2024-11-15, nwag, switch to dyn. table
--2024-11-21, nwag, move currency conversion to upper MV to save space + bugfix
--2024-11-28, nwag, added NUTZUNG_GRUND_ID
--2024-12-03, nwag, chg. 0->1 STP for pl industrieabholung
--2024-12-09, nwag, default to local currency if only fix costs
--2025-01-22, dknop, update in join besch_lief_wa_hu_sum for EWM-Touren
--2025-01-29, nwag, SYSTEM_ID/FLW
--2025-01-30, nwag, EWM_FG
--2025-02-13, nwag, Bugfix system_id
--2025-02-21, nwag, Bugfix system_id for WA
--2025-03-05, nwag, Bugfix Filialumgliederung
--2025-03-12, nwag, Adding Auslastunggrund from LES, too
--2025-03-13, nwag, Auslastunggrund SAP ID + Überschneidung 6100 CZ
--2025-03-17, nwag, Versandstelle LES KMO
--2025-03-25, nwag, Display manual costs for manual tours
--2025-03-31, nwag, Filialumgliederung nur <> 'DC%'
--2025-04-01, nwag, Change of frachtzahler logic
--2025-04-02, nwag, LIKP KUNNR original value = Lieferkunde
--2025-05-06, nwag, Exclude BELOG by System + test logic for 6997
--2025-05-19, nwag, new _retoure columns
--2025-05-22, nwag, only use the most recent transportation unit ID per transportation unit ID (ext)
--2025-06-26, nwag, mixed tours/shuttle only map unmatched delivery points to DC
--2025-07-01, nwag, shuttle fix for LES
--2025-09-18, nwag, fix EWM dat (lagernummer vs DC)
--2025-10-09, nwag, INC11813112 - TU Kosten only for the correct wup_id
--2026-01-21, dknop, adding fallback value for spedition_tms_gp_id
--2026-02-27, dknop, adding ANTRIEBSART_ID
SELECT 
 tms_tour.mandant_id
,tms_tour.SYSTEM_ID
,tms_tour.tms_tour_id
,COALESCE(tu.transportation_unit_id, wa_les.transportation_unit_id, TRY_CAST(TO_CHAR(tms_tour.dat_tour, 'YYYYMMDD') || TO_CHAR(tms_tour.tms_tour_id) AS NUMBER(38)) ) AS TRANSPORTATION_UNIT_ID
,COALESCE(tu.KJ_TRANSPORTATION_UNIT,YEAR(wa_les.dat_tour),YEAR(tms_tour.dat_tour)) AS KJ_TRANSPORTATION_UNIT
,tms_tour.transportation_unit_id_ext
,tms_tour.tms_tour_bez
,tms_tour.dat_tour
,tms_tourart_detail_id AS tourart_id_ 
,COALESCE (tms_tour.tms_tourart_id, -1) AS tms_tourart_id_
,CASE WHEN tms_tourart_id_ = 0 THEN 'K-K'
      WHEN tms_tourart_id_ = 1 THEN 'L-K' 
      WHEN tms_tourart_id_ = 2 THEN 'K-L'
      WHEN tms_tourart_id_ = 3 THEN 'L-L'
      ELSE 'not defined' END AS tms_tourart_bez
,tms_tour.TMS_tourtyp_id
,tms_tour.tms_tourstatus_id
,COALESCE(tms_tour_d.lieferkunde_tms_gp_typ_cd,'-1')
,COALESCE(CASE WHEN tms_tour_d.tms_standorttyp_id = 0 THEN -1 ELSE tms_tour_d.tms_standorttyp_id END ,-1) AS tms_standorttyp_id
--,tms_tour_d.lieferkunde_tms_gp_id
,CASE WHEN COALESCE(w.aktuell_wup_id,0) <> COALESCE(w.wup_id,0) AND tms_tour_d.lieferkunde_tms_gp_id NOT LIKE 'DC%' AND COALESCE(w.wup_id,0) > 0 THEN w.aktuell_wup_id::VARCHAR ELSE tms_tour_d.lieferkunde_tms_gp_id END AS lieferkunde_tms_gp_id
--,COALESCE(CASE WHEN tms_tour.tms_tourtyp_id = '304' THEN tms_tour_d_f.lieferkunde_tms_gp_id ELSE COALESCE(tms_rech.tms_rech_dispostelle_gp_id, tms_dispo.BESTAND_TMS_GP_ID) END, '-1') AS frachtzahler
,COALESCE(tms_rech.frachtzahler_tms_gp_id, tms_dispo.BESTAND_TMS_GP_ID, '-1') AS frachtzahler
,tms_tour.anz_stopp
,tms_tour.anz_stellplatz
,tms_tour.tms_fahrzeug_id
,tms_tour.tms_fahrzeugtyp_id
,tms_tour.tms_trailer_id
,tms_tour.tms_trailer_typ_id
,COALESCE(tms_tour.spedition_tms_gp_id, '-1') AS spedition_tms_gp_id
,tms_tour.spedition_tms_gp_typ_cd
,'WANKO' AS tms
,CASE WHEN sortiment_temperaturgruppe_id = 1 THEN 'TK'
	  WHEN sortiment_temperaturgruppe_id = 2 THEN 'GK'
	  WHEN sortiment_temperaturgruppe_id = 3 THEN 'TE' ELSE 'UK' END AS temperaturgruppe_id
,-1 AS tms_sortiment_id  
,COALESCE(wa.artikelsortiment_id,wa_les.artikelsortiment_id, -1) AS artikelsortiment_id
,COALESCE(wa_les.lagernummer_id,'-1') AS lagernummer_les_id
,tms_tour.gutschrift_erstellt_fg
,tms_dispo.BESTAND_TMS_GP_ID AS startlager_tms_gp_id
,tms_dispo.BESTAND_TMS_GP_TYP_CD AS startlager_tms_gp_typ_cd
,TRY_CAST(tms_dispo.BESTAND_TMS_GP_ID AS NUMBER) AS wup_id
,tms_tour.ziellager_tms_gp_id
,tms_tour.ziellager_tms_gp_typ_cd
,tms_tour.maut_km
,tms_tour.leer_km
,tms_tour.anz_aenderung
--,CASE WHEN w_typ.wrg_typ_id = 0 THEN 'EUR' ELSE COALESCE(COALESCE(tms_rech.wrg_id,tu_k.wrg_id), CASE WHEN w_typ.wrg_typ_id = 0 THEN 'EUR' ELSE w_typ.wrg_id END) END AS wrg_id_
,COALESCE(tms_rech.wrg_id,tu_k.wrg_id,w_typ.wrg_id) AS wrg_id_
--fixkosten nur anzeigen wenn sonst keine abrechnung vorliegt:
/*,(CASE WHEN w_typ.wrg_typ_id = 0 THEN tms_tour.betrag_fixkosten * k.umrechnungskurs ELSE tms_tour.betrag_fixkosten END) * (CASE WHEN konto_700_vorh = 1 THEN 0 ELSE 1 END) AS betrag_fixkosten 
,CASE WHEN w_typ.wrg_typ_id = 0 THEN tms_rech.betrag_netto * k.umrechnungskurs ELSE tms_rech.betrag_netto END AS betrag_netto
,CASE WHEN w_typ.wrg_typ_id = 0 THEN tu_k.betrag_diesel * k.umrechnungskurs ELSE tu_k.betrag_diesel END AS betrag_diesel
,CASE WHEN w_typ.wrg_typ_id = 0 THEN tu_k.betrag_strom * k.umrechnungskurs ELSE tu_k.betrag_strom END AS betrag_strom
,CASE WHEN w_typ.wrg_typ_id = 0 THEN tu_k.betrag_gas * k.umrechnungskurs ELSE tu_k.betrag_gas END AS betrag_gas
,CASE WHEN w_typ.wrg_typ_id = 0 THEN tu_k.betrag_maut * k.umrechnungskurs ELSE tu_k.betrag_maut END AS betrag_maut
,CASE WHEN w_typ.wrg_typ_id = 0 THEN tu_k.betrag_kuehlung * k.umrechnungskurs ELSE tu_k.betrag_kuehlung END AS betrag_kuehlung*/
,((tms_tour.betrag_fixkosten) * (CASE WHEN konto_700_vorh = 1 THEN 0 ELSE 1 END)) AS betrag_fixkosten 
,tms_rech.betrag_netto AS betrag_netto
,tu_k.betrag_diesel AS betrag_diesel
,tu_k.betrag_strom AS betrag_strom
,tu_k.betrag_gas AS betrag_gas
,tu_k.betrag_maut AS betrag_maut
,tu_k.betrag_kuehlung AS betrag_kuehlung
,tms_tour_richtungsart_id AS richtung_id
,tms_f.tms_treibstoff_id 
,COALESCE(ts_wup_k.kosten_upload_fg,-1) AS kosten_upload_fg_
,CASE WHEN kosten_upload_fg_=1 
	  AND ZEROIFNULL(tu_k.betrag_diesel)=0
	  AND ZEROIFNULL(tu_k.betrag_strom)=0
	  AND ZEROIFNULL(tu_k.betrag_gas)=0
	  AND ZEROIFNULL(tu_k.betrag_maut)=0
	  AND ZEROIFNULL(tu_k.betrag_kuehlung)=0
	  AND ZEROIFNULL(tu_k.betrag_sonstiges)=0
	  THEN 1 
	  ELSE 0 END 
	  AS tu_costs_incomplete_fg   
,COALESCE(wa.menge_lief_ist_kolli, wa_les.MENGE_LIEF_IST_KOLLI) AS MENGE_LIEF_IST_KOLLI
,CASE WHEN wa_les.brtvol_ladung_gedeckelt IS NOT NULL THEN brtvol_ladung_gedeckelt
      WHEN tu.mandant_id IS NOT NULL THEN brtvol_hu_gedeckelt_oa
      WHEN tms_tour_d.volumen_cbm = 0 AND tms_tour_d.volumen_cbm_retoure > 0 THEN tms_tour_d.volumen_cbm_retoure
      ELSE tms_tour_d.volumen_cbm END 
	  AS volumen_gedeckelt
,CASE WHEN wa_les.brtgew_ladung IS NOT NULL THEN brtgew_ladung
      WHEN tu.mandant_id IS NOT NULL THEN brtgew_hu_oa
      WHEN tms_tour_d.gewicht_kg_retoure > 0 AND tms_tour_d.gewicht_kg = 0 THEN tms_tour_d.gewicht_kg_retoure
      ELSE tms_tour_d.gewicht_kg  END 
	  AS gewicht_brutto
,CASE WHEN wa_les.anzahl_stellplatz IS NOT NULL THEN wa_les.anzahl_stellplatz
      WHEN tu.mandant_id IS NULL THEN 
        CASE WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz=0 THEN tms_tour_d.anz_stellplatz_retoure
        WHEN tms_tour_d.anz_stellplatz=0 THEN 1 ELSE tms_tour_d.anz_stellplatz END 
      ELSE ANZAHL_STELLPLATZ_EWM END 
	  AS ANZAHL_STELLPLATZ_    
,SUM (ANZAHL_STELLPLATZ_) OVER (PARTITION BY  tms_tour.mandant_id, tms_tour.system_id,tms_tour.tms_tour_id,tms_tour.dat_tour) 
	  AS ANZAHL_STELLPLATZ_GESAMT
,COUNT (DISTINCT tms_tour_d.lieferkunde_tms_gp_id || '_' || COALESCE(wa.artikelsortiment_id,wa_les.artikelsortiment_id, -1) ) OVER (PARTITION BY tms_tour.mandant_id,tms_tour.system_id,tms_tour.tms_tour_id,tms_tour.dat_tour)  AS ANZAHL_KUNDE_SORTIMENT      
, (CASE WHEN ANZAHL_STELLPLATZ_GESAMT IS NULL OR ANZAHL_STELLPLATZ_GESAMT=0 THEN 1
      WHEN wa_les.anzahl_stellplatz IS NOT NULL THEN anzahl_stellplatz
      WHEN tu.mandant_id IS NULL THEN (CASE WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz=0 THEN tms_tour_d.anz_stellplatz_retoure WHEN tms_tour_d.anz_stellplatz=0 THEN 1 ELSE tms_tour_d.anz_stellplatz END  ) ELSE ANZAHL_STELLPLATZ_EWM END)
      /
      (CASE WHEN COALESCE(ANZAHL_STELLPLATZ_GESAMT,0)=0 
	  --AND tms_tour.anz_stopp > 0 THEN tms_tour.anz_stopp 
      THEN ANZAHL_KUNDE_SORTIMENT
      WHEN ANZAHL_STELLPLATZ_GESAMT > 0 THEN ANZAHL_STELLPLATZ_GESAMT ELSE 1 END) AS ANTEIL_STELLPLATZ
,COALESCE(wa.menge_gefahrgut, wa_les.menge_gefahrgut) AS menge_gefahrgut
,CASE WHEN rf.tour_id IS NOT NULL THEN  '1' ELSE '0' END 
	  AS RUECKFUEHRUNG_FG
,CASE WHEN LEFT(s.KL_SYSTEM_BEZ,3)  = 'FLW' THEN 2
      WHEN tu.transportation_unit_id IS NOT NULL THEN 1 
      WHEN (LEFT(tms_tour.transportation_unit_id_ext,3) = 'SAP' OR ewm.dat_ewm_von > tms_tour.dat_tour) THEN 0
      ELSE 1 END  
	  AS EWM_FG 
      ,COALESCE(tu_a.nutzung_grund_id, wa_les.SAP_AUSLASTUNGSGRUND) AS nutzung_grund_id --, TMS_TOUR_STRATEGISCH_ID
, COALESCE(antriebsart_id,-1) AS antriebsart_id
FROM dbp_view.v_tms_tour tms_tour

JOIN dbp_view.v_l_system s
   ON tms_tour.system_id = s.system_id  

INNER JOIN dbp_view.v_tms_dispostelle tms_dispo
	ON tms_dispo.mandant_id = tms_tour.mandant_id
	AND tms_dispo.TMS_DISPOSTELLE_ID = tms_tour.TMS_TOUR_DISPOSTELLE_ID
    AND tms_dispo.SYSTEM_ID = tms_tour.SYSTEM_ID
    
INNER JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat, DATE'9999-12-31')) AS dat_ewm_von FROM DBP_MSI_data.ts_lagerort_ewm_dat GROUP BY mandant_id, wup_id) ewm
	ON tms_dispo.MANDANT_ID = ewm.MANDANT_ID 
	AND tms_dispo.BESTAND_TMS_GP_ID = ewm.wup_id

--TMS Rechnung
LEFT JOIN (
	SELECT tms_rech_d.mandant_id, tms_rech_d.system_id
	,TRY_CAST(tms_rech_d.tms_tour_id AS NUMBER(38)) AS tms_tour_id
	,tms_dispo.BESTAND_TMS_GP_ID AS tms_rech_dispostelle_gp_id
    ,tms_rech.ersteller_tms_gp_id AS frachtzahler_tms_gp_id
	,tms_rech_d.dat_tour
	,wrg_id
	,MAX(CASE WHEN tms_rech_d.TMS_KONTO_ID = 700 THEN 1 ELSE 0 END) AS konto_700_vorh
	,SUM(tms_rech_d.betrag_netto) AS betrag_netto 
	FROM dbp_view.v_tms_rechnung_det tms_rech_d
    JOIN dbp_view.v_tms_rechnung tms_rech
		ON tms_rech_d.tms_rech_beleg_id = tms_rech.tms_rech_beleg_id
		AND tms_rech_d.mandant_id = tms_rech.mandant_id
        AND tms_rech_d.system_id = tms_rech.system_id
    LEFT JOIN dbp_view.v_tms_dispostelle tms_dispo
		ON tms_dispo.mandant_id = tms_rech.mandant_id
        AND tms_dispo.TMS_DISPOSTELLE_ID = tms_rech.tms_dispostelle_id
        AND tms_dispo.system_id = tms_rech.system_id
	WHERE tms_rech.storno_fg = 0
	GROUP BY tms_rech_d.mandant_id, tms_rech_d.system_id, tms_rech_d.tms_tour_id, tms_dispo.BESTAND_TMS_GP_ID, tms_rech_d.dat_tour,wrg_id, frachtzahler_tms_gp_id
	) tms_rech
	ON tms_tour.mandant_id = tms_rech.mandant_id
	AND tms_tour.tms_tour_id = tms_rech.tms_tour_id
	AND tms_tour.dat_tour = tms_rech.dat_tour
    AND tms_tour.system_id = tms_rech.system_id

LEFT JOIN ( SELECT mandant_id, transportation_unit_id_ext, KJ_TRANSPORTATION_UNIT, MAX(transportation_unit_id) AS transportation_unit_id 
            FROM dbp_view.v_transportation_unit 
            GROUP BY mandant_id, transportation_unit_id_ext, KJ_TRANSPORTATION_UNIT ) tu
	ON tms_tour.mandant_id = tu.mandant_id
	AND tms_tour.transportation_unit_id_ext = tu.transportation_unit_id_ext

LEFT JOIN dbp_view.v_transportation_unit_aktivitaet tu_a
	ON tu_a.mandant_id = tu.mandant_id
	AND tu_a.transportation_unit_id = tu.transportation_unit_id
    AND tu_a.KJ_TRANSPORTATION_UNIT = tu.KJ_TRANSPORTATION_UNIT
    AND tu_a.aktivitaet_richtung_id='2'

INNER JOIN dbp_view.v_mandant_wrg_typ_zu w_typ 
	ON tms_tour.mandant_id = w_typ.mandant_id 
    AND w_typ.wrg_typ_id = 1 


JOIN (
	SELECT 
	tms_tour_det.mandant_id, tms_tour_det.system_id
	,tms_tour_id
	,dat_tour
    ,lieferkunde_tms_gp_id,lieferkunde_tms_gp_typ_cd
	,COALESCE(tms_standorttyp_id,-1) AS tms_standorttyp_id
	,SUM(gewicht_kg) AS gewicht_kg, SUM(volumen_cbm) AS volumen_cbm, SUM(anz_stellplatz) AS anz_stellplatz
    ,SUM(gewicht_kg_retoure) AS gewicht_kg_retoure, SUM(volumen_cbm_retoure) AS volumen_cbm_retoure, SUM(anz_stellplatz_retoure) AS anz_stellplatz_retoure
    FROM dbp_view.v_tms_tour_det tms_tour_det
	LEFT JOIN dbp_view.v_tms_gp tms_gp
	ON tms_tour_det.mandant_id = tms_gp.mandant_id 
	AND tms_tour_det.lieferkunde_tms_gp_id = tms_gp.tms_gp_id
	AND tms_tour_det.lieferkunde_tms_gp_typ_cd = tms_gp.tms_gp_typ_cd 
    AND tms_tour_det.system_id = tms_gp.system_id
    GROUP BY tms_tour_det.mandant_id, tms_tour_det.system_id, tms_tour_id, dat_tour , lieferkunde_tms_gp_id, lieferkunde_tms_gp_typ_cd, tms_standorttyp_id
	) tms_tour_d
	ON tms_tour.mandant_id = tms_tour_d.mandant_id
	AND tms_tour.tms_tour_id = tms_tour_d.tms_tour_id
	AND tms_tour.dat_tour = tms_tour_d.dat_tour
    AND tms_tour.system_id = tms_tour_d.system_id

LEFT JOIN (
	SELECT tms_tour_det.mandant_id, tms_tour_det.system_id, tms_tour_id, dat_tour, lieferkunde_tms_gp_id
    FROM dbp_view.v_tms_tour_det tms_tour_det
    WHERE tms_tour_pos_id = 1 
	) tms_tour_d_f
	ON tms_tour.mandant_id = tms_tour_d_f.mandant_id
	AND tms_tour.tms_tour_id = tms_tour_d_f.tms_tour_id
	AND tms_tour.dat_tour = tms_tour_d_f.dat_tour
    AND tms_tour.system_id = tms_tour_d_f.system_id

LEFT JOIN dbp_view.v_wup w
	ON tms_tour_d.mandant_id = w.mandant_id 
	AND TRY_CAST(REPLACE(TRANSLATE(tms_tour_d.lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS NUMBER) = w.wup_id
	AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

LEFT JOIN dbp_view.v_tms_fahrzeug tms_f
	ON tms_tour.tms_fahrzeugtyp_id = tms_f.tms_fahrzeugtyp_id 
	AND tms_tour.mandant_id = tms_f.mandant_id
	AND tms_tour.tms_fahrzeug_id = tms_f.tms_fahrzeug_id
    AND tms_tour.system_id = tms_f.system_id

-- EWM-Touren
LEFT JOIN (
	SELECT v01.mandant_id
	,v01.transportation_unit_id
	,v01.dat_tour
	,CASE WHEN TRY_CAST(v02.kunde_id AS NUMBER) IS NULL THEN v02.kunde_id ELSE TRY_CAST(v02.kunde_id AS NUMBER)::VARCHAR END AS KUNDE_ID_
    ,w.system_id
	,w.tms_standorttyp_id AS tms_standorttyp_id_kunde
    ,w.tms_gp_typ_cd
    ,CASE WHEN LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) = '5' THEN '1'WHEN LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) = '7' THEN '2'ELSE LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) END AS artikelsortiment_id
    ,COALESCE(kd_exist,0) AS kd_exist
	,SUM(v01.menge_lief_ist_kolli) AS  menge_lief_ist_kolli
	,SUM(v01.brtvol_hu_gedeckelt_oa) AS brtvol_hu_gedeckelt_oa
	,SUM(v01.brtgew_hu_oa) AS brtgew_hu_oa
	,SUM(v01.ANZAHL_STELLPLATZ_EWM) AS ANZAHL_STELLPLATZ_EWM
	,SUM(v01.menge_gefahrgut)  AS menge_gefahrgut
	FROM dbp_view.v_besch_lief_wa_hu_sum v01 
    JOIN dbp_view.v_besch_lief v02 ON v01.mandant_id=v02.mandant_id AND v01.lief_beleg_id=v02.lief_beleg_id AND v01.dat_lief_soll=v02.dat_lief_soll
    LEFT JOIN dbp_view.v_wup w1 ON TRY_CAST(v02.kunde_id AS NUMBER)=w1.wup_id AND v01.mandant_id_kunde=w1.mandant_id 
	LEFT JOIN dbp_view.v_tms_gp w ON w.mandant_id=v01.mandant_id AND --v01.kunde_id = TRY_CAST(w.tms_gp_id AS NUMBER) 
    CASE WHEN TRY_CAST(v02.kunde_id AS NUMBER) IS NULL THEN v02.kunde_id ELSE TRY_CAST(v02.kunde_id AS NUMBER)::VARCHAR END = w.tms_gp_id
    AND CASE WHEN w1.nb_id IS NULL THEN w.tms_gp_typ_cd WHEN COALESCE(w1.nb_id,0) <> 0 THEN 'L' ELSE '0' END = w.tms_gp_typ_cd
    LEFT JOIN (SELECT mandant_id, system_id, tms_tour_id, dat_tour, lieferkunde_tms_gp_id , 1 AS kd_exist FROM dbp_view.v_tms_tour_det  GROUP BY 1,2,3,4,5) ttd
    ON v01.mandant_id = ttd.mandant_id AND w.system_id = ttd.system_id AND v01.tms_tour_id = ttd.tms_tour_id AND v01.dat_tour = ttd.dat_tour AND KUNDE_ID_ = lieferkunde_tms_gp_id
	JOIN dbp_view.v_tag t ON v01.dat_lief_soll = t.dat AND t.akt_kj BETWEEN -2 AND 0 --performance
    GROUP BY v01.mandant_id, v01.transportation_unit_id, v01.dat_tour, v02.kunde_id, w.tms_standorttyp_id, ARTIKELSORTIMENT_ID , w.system_id, w.tms_gp_typ_cd,COALESCE(kd_exist,0)
) wa 
	ON tms_tour.mandant_id = wa.mandant_id
	AND tu.transportation_unit_id = wa.transportation_unit_id
    AND wa.system_id = tms_tour.system_id
	AND tms_tour.dat_tour = wa.dat_tour 
	AND --spezialfall shuttle:
	CASE WHEN tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> tms_dispo.BESTAND_TMS_GP_ID	AND tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' 
    AND wa.kd_exist = 0 THEN '1' 
	WHEN tms_tourart_detail_id = 6 AND wa.tms_standorttyp_id_kunde IN (1,2) AND w.nb_id = -111 THEN '1'
	ELSE --TRY_CAST(REPLACE(TRANSLATE(tms_tour_d.lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS NUMBER) 
    tms_tour_d.lieferkunde_tms_gp_id
    END
	= 
	CASE WHEN tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> tms_dispo.BESTAND_TMS_GP_ID AND tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' 
    AND wa.kd_exist = 0 THEN '1'
	WHEN tms_tourart_detail_id = 6 AND wa.tms_standorttyp_id_kunde IN (1,2) AND w.nb_id = -111 THEN '1'
	ELSE wa.kunde_id_ END
    --spezialfall überschneidung marktnummer mit VZ-nummer:
    AND CASE WHEN tms_tourart_detail_id  IN (1,2) AND wa.kd_exist = 1 THEN tms_tour_d.lieferkunde_tms_gp_typ_cd ELSE '0' END =
    CASE WHEN tms_tourart_detail_id  IN (1,2) AND wa.kd_exist = 1 THEN wa.tms_gp_typ_cd ELSE '0' END


-- LES-Touren
LEFT JOIN --DBP_MSI_VIEW_LOG.MV_DYN_TMS_LES_LIEF
    (
     SELECT 
	td.mandant_id
    ,w.system_id
	,t.tour_id AS transportation_unit_id
	,t.dat_tour
    ,agr.SAP_AUSLASTUNGSGRUND
	,TRY_CAST(bl.kunde_id AS NUMBER) AS kunde_id_
	,w.tms_standorttyp_id AS tms_standorttyp_id_kunde
    ,w.tms_gp_typ_cd
	,bl.lagernummer_id
	,CASE WHEN td.mandant_id <> 1 THEN  --KMO-Logik
	    CASE WHEN RIGHT(bl.VERSANDSTELLE_ID,1) = '5' THEN '1'
			 WHEN RIGHT(bl.VERSANDSTELLE_ID,1) = '7' THEN '2'
			 ELSE RIGHT(bl.VERSANDSTELLE_ID,1) END 
		  WHEN td.mandant_id = 1 THEN  --DE-Logik
		CASE WHEN RIGHT(bl.lagernummer_id,1) IN ('6','7') THEN '2'
			 WHEN RIGHT(bl.lagernummer_id,1) = '4' THEN '4'
			 WHEN RIGHT(bl.lagernummer_id,1) IN ('1','0') THEN '3'
			 WHEN RIGHT(bl.lagernummer_id,1) = '3' THEN '1'
			 WHEN RIGHT(bl.lagernummer_id,1) = '9' THEN '8'  
			 ELSE '-1' END 
	 ELSE '-1' END AS artikelsortiment_id
     ,COALESCE(kd_exist,0) AS kd_exist
	,SUM(hud.menge_handling_kolli) AS  menge_lief_ist_kolli
	,SUM(hu.brtvol_ladung_gedeckelt) AS brtvol_ladung_gedeckelt
	,SUM(CASE WHEN hu.versandeinheit_id IN (1, -1) THEN hu.anzahl_stellplatz ELSE 0 END) AS anzahl_stellplatz
	,SUM(hu.menge_gefahrgut) AS menge_gefahrgut
	,SUM(hu.brtgew_ladung) AS brtgew_ladung
	FROM dbp_view.v_tour t
    LEFT JOIN  dbp_view.v_l_auslastungsgrund agr  
        ON t.mandant_id=agr.mandant_id AND t.AUSLASTUNGSGRUND_ID = agr.AUSLASTUNGSGRUND_ID 
    JOIN dbp_view.v_tms_tour tt 
        ON t.mandant_id=tt.mandant_id AND t.tour_id=TRY_CAST( RIGHT(tt.transportation_unit_id_ext, LENGTH(TRIM(tt.transportation_unit_id_ext) ) -6 ) AS NUMBER) AND t.dat_tour=tt.dat_tour --filter
        AND LEFT(tt.transportation_unit_id_ext,3) = 'SAP'
	JOIN dbp_view.v_tour_det td
        ON t.mandant_id=td.mandant_id AND t.tour_id=td.tour_id AND t.wup_id=td.wup_id AND loesch_fg = 0
	JOIN (SELECT mandant_id, kj, lief_beleg_id, SUM(menge_lief_ist_kolli) AS menge_lief_ist_kolli FROM dbp_view.v_besch_lief_det WHERE kj BETWEEN YEAR(CURRENT_DATE) - 2 AND YEAR(CURRENT_DATE) + 1 GROUP BY  mandant_id, kj, lief_beleg_id) bld 
	   ON td.mandant_id=bld.mandant_id AND td.lief_beleg_id=bld.lief_beleg_id AND td.kj_lief_beleg=bld.kj
	JOIN dbp_view.v_besch_lief bl 
        ON bl.mandant_id=bld.mandant_id AND bl.lief_beleg_id=bld.lief_beleg_id AND bl.kj=bld.kj
    LEFT JOIN dbp_view.v_wup w1 
        ON w1.mandant_id=bl.mandant_id AND TRY_CAST(bl.kunde_id AS NUMBER) = w1.wup_id
        AND w1.nb_id=-111
    LEFT JOIN dbp_view.v_tms_gp w 
        ON w.mandant_id=bl.mandant_id AND TRY_CAST(bl.kunde_id AS NUMBER) = TRY_CAST(w.tms_gp_id AS NUMBER)
        AND CASE WHEN COALESCE(w1.nb_id,0) = 0 THEN '0' ELSE w.tms_gp_typ_cd END = w.tms_gp_typ_cd
        AND w.system_id = tt.system_id
    LEFT JOIN (SELECT mandant_id, system_id, tms_tour_id, dat_tour, lieferkunde_tms_gp_id , 1 AS kd_exist FROM dbp_view.v_tms_tour_det  GROUP BY 1,2,3,4,5) ttd
    ON tt.mandant_id = ttd.mandant_id AND w.system_id = ttd.system_id AND tt.tms_tour_id = ttd.tms_tour_id AND tt.dat_tour = ttd.dat_tour AND KUNDE_ID_ = TRY_CAST(ttd.lieferkunde_tms_gp_id AS NUMBER)
    
	JOIN (	SELECT mandant_id, wup_id, handling_unit_id, kj_lief_beleg, lief_beleg_id, SUM(menge_handling_kolli) AS menge_handling_kolli  
			FROM dbp_view.v_handling_unit_det 
			WHERE kj_lief_beleg BETWEEN YEAR(CURRENT_DATE) - 2 AND YEAR(CURRENT_DATE) + 1
			GROUP BY  mandant_id, wup_id, handling_unit_id, kj_lief_beleg, lief_beleg_id) hud 
	ON hud.mandant_id=bld.mandant_id AND hud.lief_beleg_id=bld.lief_beleg_id AND hud.kj_lief_beleg=bld.kj AND t.wup_id = hud.wup_id
	JOIN dbp_view.v_handling_unit hu ON hud.mandant_id=hu.mandant_id AND hud.handling_unit_id=hu.handling_unit_id AND hu.wup_id=hud.wup_id AND hu.kj_lief_beleg=hud.kj_lief_beleg
	JOIN dbp_view.v_tag tag ON t.dat_tour = tag.dat AND tag.akt_kj BETWEEN -2 AND 0 --performance
    JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat_tms_wanko, DATE'9999-12-31')) AS dat_wanko_von FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM GROUP BY mandant_id, wup_id) dw
    ON t.mandant_id = dw.mandant_id AND t.wup_id = dw.wup_id AND t.dat_tour >= dw.dat_wanko_von 
    JOIN (SELECT mandant_id, wup_id, lagernummer_id, MIN(COALESCE(dat, DATE'9999-12-31')) AS dat_ewm_von FROM DBP_MSI_data.ts_lagerort_ewm_dat GROUP BY mandant_id, wup_id, lagernummer_id) ewm
    ON t.mandant_id = ewm.mandant_id AND t.wup_id = ewm.wup_id AND t.dat_tour < ewm.dat_ewm_von AND bl.lagernummer_id = ewm.lagernummer_id
             GROUP BY 1,2,3,4,5,6,7,8,9,10,11
    )  wa_les 	ON tms_tour.mandant_id = wa_les.mandant_id AND tms_tour.system_id = wa_les.system_id
	AND TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER) = wa_les.transportation_unit_id
	AND tms_tour.dat_tour = wa_les.dat_tour 
	AND
	--spezialfälle flw-tour & shuttle:
	CASE WHEN tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> tms_dispo.BESTAND_TMS_GP_ID AND tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' AND wa_les.kd_exist = 0  THEN 1 
	WHEN tms_tourart_detail_id = 6 AND wa_les.tms_standorttyp_id_kunde IN (1,2) AND w.nb_id = -111 THEN 1
	ELSE TRY_CAST(REPLACE(TRANSLATE(tms_tour_d.lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS NUMBER) END
	= 
	CASE WHEN tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> tms_dispo.BESTAND_TMS_GP_ID AND tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' AND wa_les.kd_exist = 0  THEN 1 
	WHEN tms_tourart_detail_id = 6 AND wa_les.tms_standorttyp_id_kunde IN (1,2) AND w.nb_id = -111 THEN 1
	ELSE wa_les.kunde_id_ END
    --spezialfall überschneidung 6100 CZ:
    --AND CASE WHEN tms_tourart_detail_id = 1 THEN tms_tour_d.lieferkunde_tms_gp_typ_cd ELSE '0' END = CASE WHEN tms_tourart_detail_id = 1 THEN wa_les.tms_gp_typ_cd ELSE '0' END
    AND CASE WHEN tms_tourart_detail_id IN (1,2) AND wa_les.kd_exist = 1 THEN tms_tour_d.lieferkunde_tms_gp_typ_cd ELSE '0' END = 
    CASE WHEN tms_tourart_detail_id  IN (1,2) AND wa_les.kd_exist = 1 THEN wa_les.tms_gp_typ_cd ELSE '0' END

    
LEFT JOIN dbp_view.v_transportation_unit_kosten tu_k
	ON  tms_tour.mandant_id = tu_k.mandant_id
	AND tms_dispo.BESTAND_TMS_GP_ID = tu_k.wup_id
	AND tu_k.transportation_unit_id = COALESCE(tu.transportation_unit_id, wa_les.transportation_unit_id, TRY_CAST(TO_CHAR(tms_tour.dat_tour, 'YYYYMMDD') || TO_CHAR(tms_tour.tms_tour_id) AS NUMBER(38)) )
    AND CASE WHEN tu.KJ_TRANSPORTATION_UNIT IS NOT NULL THEN tu.KJ_TRANSPORTATION_UNIT ELSE 1 END = CASE WHEN tu.KJ_TRANSPORTATION_UNIT IS NOT NULL THEN tu_k.KJ_TRANSPORTATION_UNIT ELSE 1 END
      
LEFT JOIN dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per ts_wup_k
	ON tms_tour.spedition_tms_gp_id = ts_wup_k.tms_gp_id
	AND tms_tour.mandant_id = ts_wup_k.mandant_id
	AND tms_dispo.BESTAND_TMS_GP_ID = ts_wup_k.wup_id
	AND tms_tour.dat_tour BETWEEN ts_wup_k.dat_von AND ts_wup_k.dat_bis
    --no system ID needed - TS table
    
LEFT JOIN (
	SELECT
	l_t.mandant_id
	,l_t.tour_id
	,MIN(YEAR(dat_buch)) AS kj
	FROM dbp_view.v_rueckfuehrung_lt l_t
	JOIN dbp_view.v_tag t ON l_t.dat_buch = t.dat
	WHERE t.akt_kj >= -2
	GROUP BY  mandant_id, tour_id
	
) rf 
	ON COALESCE(tu.transportation_unit_id,wa_les.transportation_unit_id) = rf.tour_id 
	AND tms_tour.mandant_id=rf.mandant_id 
    AND YEAR(tms_tour.dat_tour)=rf.kj

WHERE s.system_gruppe = 'WANKO TMS'
;
