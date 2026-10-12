CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_belos_vorgang_2 (mandant_id, belos_vorgang_id,
komplettlieferung_fg, transportsortiment_id, loesch_fg, in_time_fg, av_fg, sammel_ladung_fg, nb_id, sendung_gew_einh_id
, sendung_vol_einh_id, dat_leistung, dat_zustellung, sendung_id, wup_id, lagerort_id, gp_id, gewicht_sendung,
zustellart_id, belos_vorgangart_id, transportauftrag_id, belos_adresse_absender_num_id, belos_adresse_abholung_id,
belos_adresse_empfaenger_id, belos_adresse_empfaenger_id_num, belos_adresse_spedition_id, vol_stauraum, debitor_id,
anz_unterverpackung, unterverpackung_menge_einh_id, lagernummer_id, system_id, tour_id, kj_transportation_unit,
belosart_fg, leergut_abh_fg, retouren_fg, industrie_abh_fg, anz_stellplatz, anz_kolli, belos_sendungsstatus_id,
distribution_abr_fg, brtgew_sendung, brtvol_stauraum, anz_stellplatz_belos, k_na_fg, belos_auftrag_id_extern,
belos_lieferschein_id, belos_sendung_id_extern, belos_bestell_beleg_id_extern, mandant_id_debitor, referenz,
belos_adresse_steuerung_id) AS SELECT V01.mandant_id,
 V01.belos_vorgang_id,
 V01.komplettlieferung_fg,
 v05.transportsortiment_id,
 V01.loesch_fg,
 V01.in_time_fg,
 V01.av_fg,
 V01.sammel_ladung_fg,
 V01.nb_id,
 V01.sendung_gew_einh_id,
 V01.sendung_vol_einh_id,
 V01.dat_leistung,
 V01.dat_zustellung,
 V01.sendung_id,
 V01.wup_id,
 V01.lagerort_id,
 V01.gp_id,
 V01.gewicht_sendung,
 V01.zustellart_id,
 V01.belos_vorgangart_id,
 V01.transportauftrag_id,
 V01.belos_adresse_absender_num_id,
 V01.belos_adresse_abholung_id,
 COALESCE(CAST(V02.aktuell_wup_id AS STRING), V01.belos_adresse_empfaenger_id) AS belos_adresse_empfaenger_id_,
 COALESCE(CASE
   WHEN ROUND(SAFE_CAST(V01.belos_adresse_empfaenger_id AS BIGNUMERIC), 0) = 0
   THEN NULL
   ELSE SAFE_CAST(V02.aktuell_wup_id AS BIGNUMERIC)
   END, ROUND(SAFE_CAST(LEFT(V01.belos_adresse_empfaenger_id, 4) AS BIGNUMERIC), 0)) AS belos_adresse_empfaenger_id_num
 ,
 V01.belos_adresse_spedition_id,
 V01.vol_stauraum,
 V01.debitor_id,
 V01.anz_unterverpackung,
 V01.unterverpackung_menge_einh_id,
 COALESCE(CASE
   WHEN V04.lagernummer_id = ''
   THEN NULL
   ELSE V04.lagernummer_id
   END, '-1') AS lagernummer_id,
 V01.system_id,
 V01.tour_id,
 EXTRACT(YEAR FROM V01.dat_leistung) AS kj_transportation_unit,
 V01.belosart_fg,
 V01.leergut_abh_fg,
 V01.retouren_fg,
 V01.industrie_abh_fg,
 V01.anz_stellplatz,
 V01.anz_kolli,
 V01.belos_sendungsstatus_id,
 V01.distribution_abr_fg,
 V01.brtgew_sendung,
 V01.brtvol_stauraum,
 V01.anz_stellplatz_belos,
 V01.k_na_fg,
 V01.belos_auftrag_id_extern,
 V01.belos_lieferschein_id,
 V01.belos_sendung_id_extern,
 V01.belos_bestell_beleg_id_extern,
 V01.mandant_id_debitor,
 V01.referenz,
 MAX(V03.belos_adresse_steuerung_id) AS belos_adresse_steuerung_id
FROM kfl_production_dbp_view.v_belos_vorgang_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V02.wup_id = CASE
     WHEN ROUND(SAFE_CAST(V01.belos_adresse_empfaenger_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(V01.belos_adresse_empfaenger_id AS BIGNUMERIC), 0)
     END AND (V02.nb_id IN (2, 0, - 111) AND V02.wup_id > 0 OR V02.nb_id = - 1 AND V02.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_verrechfall_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.belos_vorgang_id =
    V03.belos_vorgang_id AND V03.storno_fg = 0
 INNER JOIN kfl_production_dbp_view.v_l_lagernummer_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.lagernummer_id =
   LEFT(V04.lagernummer_id, 3)
 LEFT JOIN (SELECT belos_vorgang_id,
   mandant_id,
   MAX(transportsortiment_id) AS transportsortiment_id
  FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum_2
  GROUP BY belos_vorgang_id,
   mandant_id) AS v05 ON V01.belos_vorgang_id = v05.belos_vorgang_id AND V01.mandant_id = v05.mandant_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   MIN(COALESCE(dat_tms_wanko, DATE '9999-12-31')) AS dat_wanko_von
  FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm_2
  GROUP BY mandant_id,
   wup_id) AS dw ON V01.belos_adresse_absender_num_id = dw.wup_id AND V01.mandant_id = dw.mandant_id
WHERE EXTRACT(YEAR FROM V01.dat_leistung) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
 AND (CAST(V03.belos_adresse_steuerung_id AS INTEGER) NOT IN (6921, 6922) OR V01.dat_leistung < DATE '2025-02-17')
 AND V01.dat_leistung < COALESCE(dw.dat_wanko_von, DATE '9999-12-31')
GROUP BY V01.mandant_id,
 V01.belos_vorgang_id,
 V01.komplettlieferung_fg,
 v05.transportsortiment_id,
 V01.loesch_fg,
 V01.in_time_fg,
 V01.av_fg,
 V01.sammel_ladung_fg,
 V01.nb_id,
 V01.sendung_gew_einh_id,
 V01.sendung_vol_einh_id,
 V01.dat_leistung,
 V01.dat_zustellung,
 V01.sendung_id,
 V01.wup_id,
 V01.lagerort_id,
 V01.gp_id,
 V01.gewicht_sendung,
 V01.zustellart_id,
 V01.belos_vorgangart_id,
 V01.transportauftrag_id,
 V01.belos_adresse_absender_num_id,
 V01.belos_adresse_abholung_id,
 belos_adresse_empfaenger_id_,
 belos_adresse_empfaenger_id_num,
 V01.belos_adresse_spedition_id,
 V01.vol_stauraum,
 V01.debitor_id,
 V01.anz_unterverpackung,
 V01.unterverpackung_menge_einh_id,
 V04.lagernummer_id,
 V01.system_id,
 V01.tour_id,
 V01.belosart_fg,
 V01.leergut_abh_fg,
 V01.retouren_fg,
 V01.industrie_abh_fg,
 V01.anz_stellplatz,
 V01.anz_kolli,
 V01.belos_sendungsstatus_id,
 V01.distribution_abr_fg,
 V01.brtgew_sendung,
 V01.brtvol_stauraum,
 V01.anz_stellplatz_belos,
 V01.k_na_fg,
 V01.belos_auftrag_id_extern,
 V01.belos_lieferschein_id,
 V01.belos_sendung_id_extern,
 V01.belos_bestell_beleg_id_extern,
 V01.mandant_id_debitor,
 V01.referenz;