 CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_ANLIEFERPUENKTLICHKEIT_OUG(
	MANDANT_ID,
	WUP_ID,
	DAT_TOUR,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	LAGERNUMMER_ID,
	DISTRIBUTION_ABR_FG,
	DAT_PLAN_ANKUNFT_ORIG,
	ZEIT_PLAN_ANKUNFT_ORIG,
	VORLIEFERUNG_FG,
	DAT_PLAN_ANKUNFT,
	ZEIT_ANLIEFERUNG_OG,
	DATZEIT_ANLIEFERUNG_OG,
	DAT_SCAN,
	ZEIT_SCAN,
	DATZEIT_SCAN,
	DATZEIT_SCAN_KARENZ,
	ZEIT_SCAN_KARENZ,
	DIFF_PLAN_SCAN_MINUTEN_KARENZ,
	OG_INTIME_FG,
	PUNKTLICHKEIT_ANKUNFT_MARKT,
	PUNKTLICHKEIT_ANKUNFT_VZ,
	PUNKTLICHKEIT_ABFAHRT_VZ,
	DATZEIT_START_PLAN,
	DATZEIT_START_IST,
	DATZEIT_ENDE_PLAN,
	DATZEIT_ENDE_IST,
	AKTIVITAET_RICHTUNG_ID,
	TMS,
    BELOS_ADRESSE_SPEDITION_ID,
	TDL_ID,
	TOUR_SERVICE_ID,
	PLOMBE_PROZESS_ID,
	TRANSPORTATION_UNIT_ANZAHL,
	ANZAHL_STELLPLATZ_EWM_PARENT_LSORT2,
	FG,
	RANK_1,
	RANK_2
) AS	
--2023-11-02,AP0194349,SPEC0222332 dknop, initial	
--2024-07-19,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic	
--2024-09-18, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit duplication
--2024-10-22, AP0210954_SPEC0239355, dknop, also display TDL+tourart for WANKO Tours	
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2024-11-20, AP0240092, dat tour TRANSPORTATION_UNIT_KUNDE can differ
--2025-09-19, nwag, INC11675222
SELECT 	
 hu_s.mandant_id 	
,hu_s.wup_id	
,t_unit.dat_tour	
,hu_s.transportation_unit_id	
,t_unit.kj_transportation_unit
,hu_s.mandant_id_kunde	
--,CASE WHEN TRY_CAST(hu_s.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id_
,aktuell_wup_id	AS kunde_id_
--,hu_s.kunde_id	
	
,hu_s.lagernummer_id	
,COALESCE(bv.distribution_abr_fg,v021.distribution_abr_fg,1) AS distribution_abr_fg	
	
,tu_k.dat_tour AS dat_plan_ankunft_orig	
,tu_k.zeit_plan_ankunft AS zeit_plan_ankunft_orig	
	
,CASE WHEN tu_k.zeit_plan_ankunft BETWEEN '19:00:00'  AND '23:59:59' THEN 1 ELSE 0 END AS vorlieferung_fg	
,CASE WHEN vorlieferung_fg = 1 THEN dat_plan_ankunft_orig +1 ELSE dat_plan_ankunft_orig END AS dat_plan_ankunft	
,COALESCE(ts_w_za.zeit_anlieferung, '06:00:00') AS zeit_anlieferung_og_	
,TIMESTAMP_NTZ_FROM_PARTS(dat_plan_ankunft, zeit_anlieferung_og_) AS datzeit_anlieferung_og----	
,CASE WHEN t_pz.mandant_id IN (4,7,8) AND COALESCE(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(t_pz.zeit_scan) ,0 )>= 230000 THEN t_pz.dat_scan + INTERVAL '1 day' ELSE t_pz.dat_scan END AS dat_scan_	
,CASE WHEN t_pz.mandant_id IN (4,7,8) THEN  CASE WHEN COALESCE(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(t_pz.zeit_scan) ,0 )>= 230000 	
      THEN SNOWCONVERT.PUBLIC.INT_TO_TIME_UDF(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(t_pz.zeit_scan) - 230000)  	
      ELSE SNOWCONVERT.PUBLIC.INT_TO_TIME_UDF(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(t_pz.zeit_scan) + 10000) END ELSE t_pz.zeit_scan END AS zeit_scan	
,MIN(TIMESTAMP_NTZ_FROM_PARTS(dat_scan_, t_pz.zeit_scan)) AS datzeit_scan 	
,DATEADD(MINUTE,-15,TIMESTAMP_NTZ_FROM_PARTS(dat_scan_, t_pz.zeit_scan)) AS datzeit_scan_karenz	
,TIME(datzeit_scan_karenz) AS zeit_scan_karenz	
,DATEDIFF(MINUTE, datzeit_scan_karenz, datzeit_anlieferung_og) AS diff_plan_scan_minuten_karenz	
	
,CASE WHEN diff_plan_scan_minuten_karenz >= 0 OR t_pz.zeit_scan IS NULL THEN 1 ELSE 0 END AS og_intime_fg	
,CASE WHEN og_intime_fg=1 THEN 1 ELSE 0 END AS punktlichkeit_ankunft_markt	
	
,CASE WHEN TIMESTAMPDIFF('SECOND',t_unit.datzeit_start_ist,t_unit.datzeit_start_plan)>= 0 THEN '1'	
      WHEN TIMESTAMPDIFF('SECOND',t_unit.datzeit_start_ist,t_unit.datzeit_start_plan) IS NULL THEN '-1' 	
      ELSE 0 END AS punktlichkeit_ankunft_VZ	
,CASE WHEN TIMESTAMPDIFF('SECOND',t_unit.datzeit_ende_ist,t_unit.datzeit_ende_plan)>= 0 THEN '1'	
      WHEN TIMESTAMPDIFF('SECOND',t_unit.datzeit_ende_ist,t_unit.datzeit_ende_plan) IS NULL THEN '-1' 	
      ELSE 0 END AS punktlichkeit_abfahrt_VZ	
,TO_TIMESTAMP(t_unit.datzeit_start_plan) AS datzeit_start_plan	
,TO_TIMESTAMP(t_unit.datzeit_start_ist) AS datzeit_start_ist	
,TO_TIMESTAMP(t_unit.datzeit_ende_plan) AS datzeit_ende_plan	
,TO_TIMESTAMP(t_unit.datzeit_ende_ist) AS datzeit_ende_ist	
,t_unit.aktivitaet_richtung_id	
--,t_unit.belos_adresse_spedition_id ---to be removed
,CASE WHEN t_unit.dat_tour >= b_w_sw.dat_tms_wanko THEN 'WANKO' ELSE 'BELOS' END AS tms
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.spedition_tms_gp_id, '-1') ELSE COALESCE (t_unit.belos_adresse_spedition_id, '-1') END AS belos_adresse_spedition_id
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.spedition_tms_gp_id, '-1') ELSE COALESCE (t_unit.belos_adresse_spedition_id, '-1') END AS tdl_id
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.TEMPERATURGRUPPE_ID, t_unit.belos_sonderabwicklung_id, '-1') ELSE COALESCE (t_unit.belos_sonderabwicklung_id, '-1') END AS tour_service_id
,COALESCE(CASE WHEN plombe_prozess_id IN (1,3) THEN 1 	
               WHEN plombe_prozess_id = 2  THEN 2 ELSE -1 END, -1) AS plombe_prozess_id_	
	
	
,COUNT(DISTINCT hu_s.transportation_unit_id)	
,AVG(a_st_lsort2.anzahl_stellplatz_ewm_ext_parent_lsort2) AS anzahl_stellplatz_ewm_ext_parent_lsort2_	
,CASE WHEN (SUM(anzahl_stellplatz_ewm_ext_parent_lsort2_) OVER (PARTITION BY a_st_lsort2.mandant_id, a_st_lsort2.kunde_id, a_st_lsort2.transportation_unit_id, t_unit.dat_tour))/2 = anzahl_stellplatz_ewm_ext_parent_lsort2_ THEN 1 ELSE 0 END AS FG	
,CASE WHEN FG=1 THEN 1 ELSE ROW_NUMBER()OVER(PARTITION BY a_st_lsort2.mandant_id, a_st_lsort2.kunde_id, t_unit.dat_tour ORDER BY anzahl_stellplatz_ewm_ext_parent_lsort2_ DESC) END AS rank_1	
,CASE WHEN FG=1 THEN ROW_NUMBER()OVER(PARTITION BY a_st_lsort2.mandant_id, a_st_lsort2.kunde_id, a_st_lsort2.transportation_unit_id ORDER BY tu_k.zeit_plan_ankunft ASC) ELSE 1 END AS rank_2	
	
FROM dbp_view.v_besch_lief_wa_hu_sum hu_s	
	
INNER JOIN dbp_view.v_wup w	
ON w.mandant_id = CASE WHEN hu_s.mandant_id_kunde IS NULL OR hu_s.mandant_id_kunde = 0 THEN hu_s.mandant_id ELSE hu_s.mandant_id_kunde END	
--AND w.wup_id = CASE WHEN TRY_CAST(hu_s.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(hu_s.kunde_id AS INTEGER) END	
AND w.wup_id = hu_s.kunde_id
AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))	
	
JOIN (	
SELECT	
 mandant_id	
,lagernummer_id	
,transportation_unit_id	
,dat_tour
,kunde_id	
,SUM( CASE WHEN lagersortiment_id='2' THEN anzahl_stellplatz_ewm_ext_parent ELSE 0 END) AS anzahl_stellplatz_ewm_ext_parent_lsort2 FROM dbp_view.v_besch_lief_wa_hu_sum	
GROUP BY  mandant_id	
,lagernummer_id	
,transportation_unit_id	
,dat_tour
,kunde_id) a_st_lsort2	
ON  hu_s.mandant_id = a_st_lsort2.mandant_id	
AND hu_s.lagernummer_id = a_st_lsort2.lagernummer_id	
AND hu_s.transportation_unit_id = a_st_lsort2.transportation_unit_id	
AND hu_s.dat_tour = a_st_lsort2.dat_tour	
AND hu_s.kunde_id=a_st_lsort2.kunde_id	
AND a_st_lsort2.anzahl_stellplatz_ewm_ext_parent_lsort2>0	
	
JOIN dbp_view.v_transportation_unit_aktivitaet t_unit	
ON  t_unit.aktivitaet_richtung_id = '2'	
AND hu_s.handling_unit_id > 0	
AND t_unit.mandant_id = hu_s.mandant_id	
AND t_unit.transportation_unit_id = hu_s.transportation_unit_id	
AND t_unit.dat_tour = hu_s.dat_tour	
 -- if there's any delivery for this store on a given date, this is considered an normal day (not sunday/holiday)	
LEFT JOIN ( SELECT mandant_id, lagernummer_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, lagernummer_id ) b_w_sw
            ON b_w_sw.mandant_id = t_unit.mandant_id
            AND b_w_sw.lagernummer_id = t_unit.lagernummer_id
 
LEFT JOIN (
SELECT DISTINCT t.mandant_id , tu.transportation_unit_id, t.dat_tour, CASE WHEN t.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg, t.spedition_tms_gp_id, t.TEMPERATURGRUPPE_ID, t.tms_tourtyp_id
,t.tms_tourart_id
FROM dbp_data.tms_tour t
JOIN dbp_view.v_tag d ON d.dat = t.dat_tour AND d.akt_kj >= -2
JOIN dbp_view.v_transportation_unit tu
ON t.mandant_id=tu.mandant_id
AND t.transportation_unit_id_ext=tu.transportation_unit_id_ext
) v021
ON t_unit.mandant_id=v021.mandant_id
AND t_unit.transportation_unit_id=v021.transportation_unit_id
AND t_unit.dat_tour=v021.dat_tour
 
 
LEFT JOIN (SELECT 	
            mandant_id	
           ,tour_id 	
           ,dat_leistung
           ,MAX(distribution_abr_fg) AS distribution_abr_fg	
           FROM dbp_view.v_belos_vorgang	
           GROUP BY	
            mandant_id	
           ,tour_id	
           ,dat_leistung
          ) bv	
ON t_unit.mandant_id=bv.mandant_id	
AND t_unit.transportation_unit_id=bv.tour_id	
AND t_unit.dat_tour=bv.dat_leistung	
	
LEFT JOIN dbp_view.v_transportation_unit_kunde tu_k	
ON hu_s.transportation_unit_id = tu_k.transportation_unit_id	
AND ABS ( DATEDIFF ( days, hu_s.dat_tour , tu_k.dat_tour )) < 90
AND hu_s.mandant_id = tu_k.mandant_id	
AND hu_s.kunde_id = TRY_CAST(tu_k.kunde_id AS INT)	
		
LEFT JOIN (SELECT mandant_id, wup_id, tour_id,dat_scan,	
           MIN(zeit_scan) AS zeit_scan	
           FROM  dbp_view.v_tour_plombe_ziel 	
           WHERE dat_scan IS NOT NULL AND NOT (plombe_aktivitaet = 13 AND info_code > 0)	
           GROUP BY  mandant_id, wup_id, tour_id, dat_scan	
          ) t_pz	
ON hu_s.transportation_unit_id = t_pz.tour_id	
AND hu_s.mandant_id = t_pz.mandant_id	
AND hu_s.kunde_id = t_pz.wup_id	
AND hu_s.dat_tour = t_pz.DAT_SCAN --keine diff?
	
LEFT JOIN  dbp_view.v_tour_plombe_ziel t_pz_pr	
ON  t_pz.tour_id = t_pz_pr.tour_id	
AND t_pz.mandant_id = t_pz_pr.mandant_id	
AND t_pz.wup_id = t_pz_pr.wup_id   
AND t_pz.DAT_SCAN = t_pz_pr.DAT_SCAN	
AND t_pz.zeit_scan = t_pz_pr.zeit_scan	
	
LEFT JOIN dbp_msi_data.ts_wup_zeit_anlieferung_per ts_w_za	
ON  hu_s.mandant_id = ts_w_za.mandant_id	
AND hu_s.kunde_id = ts_w_za.wup_id	
AND ts_w_za.transportsortiment_id = 27	
AND t_unit.dat_tour BETWEEN ts_w_za.dat_von AND ts_w_za.dat_bis	
	
WHERE YEAR(t_unit.dat_tour) >= YEAR(CURRENT_DATE)-2

GROUP BY hu_s.mandant_id	
,hu_s.wup_id	
,t_unit.dat_tour	
,hu_s.transportation_unit_id	
,t_unit.kj_transportation_unit
,hu_s.mandant_id_kunde	
,kunde_id_	
,hu_s.lagernummer_id	
,COALESCE(bv.distribution_abr_fg,v021.distribution_abr_fg,1)
,tu_k.dat_tour	
,tu_k.zeit_plan_ankunft	
,ts_w_za.zeit_anlieferung	
,t_pz.dat_scan	
,t_pz.mandant_id	
,t_pz.zeit_scan	
,punktlichkeit_abfahrt_vz	
,punktlichkeit_ankunft_VZ	
,t_unit.datzeit_start_plan	
,t_unit.datzeit_start_ist	
,t_unit.datzeit_ende_plan	
,t_unit.datzeit_ende_ist	
,t_unit.aktivitaet_richtung_id	
,t_unit.belos_adresse_spedition_id	
,tms
,tdl_id
,tour_service_id
,t_pz_pr.plombe_prozess_id	
,a_st_lsort2.mandant_id	
,a_st_lsort2.kunde_id	
,a_st_lsort2.transportation_unit_id	
	
QUALIFY  rank_1=1 AND rank_2=1	
;