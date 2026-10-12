-- 2022-12-01, updating  belos_adresse_spedition_id from K-NA to 429458, Coalesce for b_vor.lagerort_id

-- 2024-11-19, nwag, *10 instead of RPAD function to avoid SNFL error

-- 2022-05-19, AP0112140, SPEC0155506, initial, dknop

-- 2022-07-21, AP0112140, SPEC0155506, updating logic for gp_id, dknop

-- 2022-12-20, AP0140953, SPEC0164166,correcting CROSS JOIN to v_gp_plz_besch_region_zu_per_2 (adding CASE WHEN  b_vor.belos_vorgangart_id='K-NA')

-- 2022-08-04, AP0140953, correcting logic for aufwand_gesamt and ertrag_gesamt by adding soll_ist_fg=1; sendung_fg=1 in CROSS JOIN to v_belos_packstueck_2; adding sammel_ladung_fg=1 in CROSS JOIN to v_belos_teilstrecke_2

-- 2022-09-21, AP0140953, SPEC0164166, updaing logic for plz and ort for k_na_fg=1, dknop

-- 2022-09-12, AP0140953, SPEC0164166, adding besch_region

-- 2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_2 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU

-- 2023-01-10, AP0140953, SPEC0164166, updating logic for land_2 for k_na_fg=1, dknop

-- 2022-08-19, AP0140953, SPEC0164166, adding datzeit_system_zugestellt

-- 2022-09-21, AP0140953, SPEC0164166, adding tdl_ort, dknop

-- 2023-02-06, dknop, adding condition than when b_vor.belos_vorgangart_id='K-NA' THEN sammel_ladung_fg = '1'

-- 2024-10-29, dknop, adding tms logic

-- 2022-07-22, AP0112140, SPEC0155506, COALESCE for tour_id, removing duplication because of CROSS JOIN to belos_packstueck_2, correcting logic for gp_id*, adding datzeit_abholung_bis, datzeit_zustellung_bis

-- 2022-08-01, AP0140953, updating logic for zusatz_spot, adding manuelle Dispo

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_beschaffungslogistik_2(USERID STRING) AS SELECT CASE
  WHEN ver_agg.min_storno_fg = 1
  THEN 1
  ELSE 0
  END AS lad_kom_fg,
 B_VOR.mandant_id,
 B_VOR.wup_id,
 B_VOR.nb_id,
  CASE
  WHEN B_VOR.belos_vorgangart_id IN ('K-RET', 'K-LT', 'K-AV')
  THEN B_VOR.wup_id
  ELSE COALESCE(B_AD_WUP.wup_id, -1)
  END AS belos_wup_id,
 COALESCE(CASE
   WHEN B_VOR.lagerort_id = ''
   THEN NULL
   ELSE B_VOR.lagerort_id
   END, '-1') AS lagerort_id,
  CASE
  WHEN B_VOR.k_na_fg = 0
  THEN COALESCE(B_AD_TDL_ORT.ort, '')
  ELSE 'K-NA'
  END AS tdl_ort,
 B_VOR.k_na_fg,
 B_VOR.belos_vorgangart_id,
 B_VOR.belos_vorgang_id,
 B_VOR.belos_adresse_empfaenger_id,
 B_VOR.sonderabwicklung_id,
 B_VOR.dat_leistung,
 DATE(B_VOR.datzeit_abholung_bis) AS abholtermin_bis,
 DATE(B_VOR.datzeit_zustellung_bis) AS zustelltermin_bis,
 DATE(B_VOR.datzeit_sendung_offen) AS dat_sendung_offen,
 DATE(B_VOR.datzeit_ware_versandbereit) AS dat_ware_versandbereit,
 DATE(B_VOR.datzeit_sendung_beauftragt) AS dat_sendung_beauftragt,
 DATE(B_VOR.datzeit_system_zugestellt) AS datzeit_system_zugestellt0,
 B_VOR.datzeit_sendung_offen,
 B_VOR.datzeit_ware_versandbereit,
 B_VOR.datzeit_sendung_beauftragt,
 B_VOR.datzeit_system_zugestellt,
 DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(B_VOR.datzeit_sendung_offen AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(B_VOR.datzeit_ware_versandbereit AS TIMESTAMP)
    ) AS DATETIME), DAY) AS delta_ware_versandbereit_sendung_offen,
 DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(B_VOR.datzeit_ware_versandbereit AS TIMESTAMP)) AS DATETIME)
  ,CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(B_VOR.datzeit_sendung_beauftragt AS TIMESTAMP)) AS DATETIME), DAY) AS
 delta_sendung_beauftragt_ware_versandbereit,
 DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(B_VOR.datzeit_zustellung_bis AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(B_VOR.datzeit_system_zugestellt AS TIMESTAMP)
    ) AS DATETIME), DAY) AS delta_system_zugestellt_datzeit_ware_versandbereit,
 B_VOR.transportauftrag_id,
 COALESCE(B_VOR.tour_id, - 1) AS tour_id,
 B_VOR.belos_adresse_absender_num_id,
 B_VOR.belos_adresse_abholung_id,
  CASE
  WHEN B_VOR.k_na_fg = 0
  THEN B_AD.ort
  ELSE B_AD_K_NA.ort
  END AS ort,
  CASE
  WHEN B_VOR.k_na_fg = 0
  THEN B_AD.plz
  ELSE B_AD_K_NA.plz
  END AS plz,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN 1
  ELSE B_VOR.sammel_ladung_fg
  END AS sammel_ladung_fg,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN COALESCE(NULLIF('', CAST(B_VOR.belos_adresse_spedition_id AS STRING)), '429458')
  ELSE B_VOR.belos_adresse_spedition_id
  END AS belos_adresse_spedition_id,
 b_vor_lad.belos_ladung_id,
  CASE
  WHEN LOWER(B_LAD.zusatz_spot) LIKE LOWER('spot')
  THEN 'X'
  ELSE ' '
  END AS zusatz_spot,
  CASE
  WHEN LOWER(B_LAD.zusatz_spot) LIKE LOWER('md')
  THEN 'X'
  ELSE ' '
  END AS manuelle_dispo,
 B_VOR.referenz,
 COALESCE(B_VOR.belos_auftrag_id_extern, ' ') AS belos_auftrag_id_extern,
 COALESCE(B_VOR.belos_sendung_id_extern, ' ') AS belos_sendung_id_extern,
 B_VOR.gewicht_sendung,
 b_pack.gebinde_anz,
 SP_KAT.stellplatzkategorie,
 B_VOR.anz_unterverpackung,
 B_VOR.vol_stauraum,
 b_vor_lad.anz_stellplatz_vorlauf,
 b_vor_lad.anz_stellplatz_hauptlauf,
  CASE
  WHEN B_VOR.k_na_fg = 0
  THEN B_AD.land_id
  ELSE B_AD_K_NA.land_id
  END AS land_id,
 B_VOR.belos_bestell_beleg_id_extern,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN b_trans_auf.aufwand_gesamt
  ELSE ver_agg.aufwand_gesamt
  END AS aufwand_gesamt,
  CASE
  WHEN B_VOR.k_na_fg = 1 AND thr_fg.thr_fg = 1
  THEN 0
  WHEN B_VOR.k_na_fg = 1 AND thr_fg.thr_fg IS NULL
  THEN 1
  ELSE NULL
  END AS threshold_fg,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN b_trans_auf.aufwand_vorlauf
  ELSE CASE
   WHEN B_VOR.sammel_ladung_fg = 1
   THEN ver_agg.aufwand_vorlauf
   ELSE 0
   END
  END AS aufwand_vorlauf,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN b_trans_auf.aufwand_hauptlauf
  ELSE CASE
   WHEN B_VOR.sammel_ladung_fg = 1
   THEN ver_agg.aufwand_hauptlauf
   ELSE 0
   END
  END AS aufwand_hauptlauf,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN b_trans_auf.aufwand_umschlag
  ELSE CASE
   WHEN B_VOR.sammel_ladung_fg = 1
   THEN ver_agg.aufwand_umschlag
   ELSE 0
   END
  END AS aufwand_umschlag,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN b_trans_auf.aufwand_diesel
  ELSE ver_agg.aufwand_diesel
  END AS aufwand_diesel,
 ver_agg.ertrag_gesamt,
 ver_agg.ertrag_diesel,
  CASE
  WHEN B_VOR.gp_id = - 1
  THEN COALESCE(CASE
    WHEN B_VOR.belos_vorgangart_id = 'K-NA'
    THEN BB_KNA.gp_id
    ELSE BB.gp_id
    END, -1)
  ELSE B_VOR.gp_id * 10
  END AS gp_comp_id,
 COALESCE(B_REG.besch_region_id, - 1) AS besch_region_id,
 COALESCE(B_REG.besch_region_koordination_id, - 1) AS besch_region_koordination_id,
 'BELOS' AS tms
FROM kfl_production_dbp_view.v_belos_vorgang_2 AS B_VOR
 LEFT JOIN kfl_production_dbp_view.v_ts_belos_adresse_wup_zu_2 AS B_AD_WUP ON B_VOR.belos_adresse_empfaenger_id = B_AD_WUP
   .belos_adresse_id AND B_VOR.mandant_id = B_AD_WUP.mandant_id
 LEFT JOIN (SELECT VER.belos_vorgang_id,
   VER.mandant_id,
   VER.wrg_id,
   SUM(CASE
     WHEN VER.kunde_fg = 0 AND VER_KOST.soll_ist_fg = 1
     THEN CASE
      WHEN WRG_TYP.wrg_typ_id = 0
      THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
      ELSE VER_KOST.betrag_kosten
      END
     ELSE 0
     END) AS aufwand_gesamt,
   SUM(CASE
     WHEN VER.kunde_fg = 0 AND VER_KOST.soll_ist_fg = 1 AND VER_KOST.verrechfall_kostenart_id <> 'KLTSZ' AND VER.belos_leistungsart_id
        = 1
     THEN VER_KOST.betrag_kosten
     ELSE 0
     END) AS aufwand_vorlauf,
   SUM(CASE
     WHEN VER.kunde_fg = 0 AND VER_KOST.soll_ist_fg = 1 AND VER_KOST.verrechfall_kostenart_id <> 'KLTSZ' AND VER.belos_leistungsart_id
        = 2
     THEN CASE
      WHEN WRG_TYP.wrg_typ_id = 0
      THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
      ELSE VER_KOST.betrag_kosten
      END
     ELSE 0
     END) AS aufwand_hauptlauf,
   SUM(CASE
     WHEN VER.kunde_fg = 0 AND VER_KOST.soll_ist_fg = 1 AND VER_KOST.verrechfall_kostenart_id = 'KLUMS'
     THEN CASE
      WHEN WRG_TYP.wrg_typ_id = 0
      THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
      ELSE VER_KOST.betrag_kosten
      END
     ELSE 0
     END) AS aufwand_umschlag,
   SUM(CASE
     WHEN VER.kunde_fg = 0 AND VER_KOST.soll_ist_fg = 1 AND VER_KOST.verrechfall_kostenart_id = 'KLTSZ'
     THEN CASE
      WHEN WRG_TYP.wrg_typ_id = 0
      THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
      ELSE VER_KOST.betrag_kosten
      END
     ELSE 0
     END) AS aufwand_diesel,
   SUM(CASE
     WHEN VER.kunde_fg = 1 AND VER_KOST.soll_ist_fg = 1
     THEN CASE
      WHEN WRG_TYP.wrg_typ_id = 0
      THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
      ELSE VER_KOST.betrag_kosten
      END
     ELSE 0
     END) AS ertrag_gesamt,
   SUM(CASE
     WHEN VER.kunde_fg = 1 AND VER_KOST.soll_ist_fg = 1 AND VER_KOST.verrechfall_kostenart_id = 'KLTSZ'
     THEN CASE
      WHEN WRG_TYP.wrg_typ_id = 0
      THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
      ELSE VER_KOST.betrag_kosten
      END
     ELSE 0
     END) AS ertrag_diesel,
   MIN(VER.storno_fg) AS min_storno_fg
  FROM kfl_production_dbp_view.v_verrechfall_2 AS VER
   INNER JOIN kfl_production_dbp_view.v_verrechfall_kosten_2 AS VER_KOST ON VER.verrechfall_id = VER_KOST.verrechfall_id
     AND VER.mandant_id = VER_KOST.mandant_id AND VER_KOST.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090')
   LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS KURS_2 ON VER.wrg_id = KURS.von_wrg_id
   INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS WRG_TYP ON VER_KOST.mandant_id = WRG_TYP.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS WRG_TYP_USER ON WRG_TYP.wrg_typ_id =
    WRG_TYP_USER.wrg_typ_id
  GROUP BY VER.belos_vorgang_id,
   VER.mandant_id,
   VER.wrg_id) AS ver_agg ON B_VOR.belos_vorgang_id = ver_agg.belos_vorgang_id AND B_VOR.mandant_id = ver_agg.mandant_id
   
 LEFT JOIN (SELECT B_TRANS_AUF.belos_vorgang_id,
   B_TRANS_AUF.mandant_id,
    CASE
    WHEN WRG_TYP0.wrg_typ_id = 0
    THEN B_TRANS_AUF.aufwand_gesamt * KURS0.umrechnungskurs
    ELSE B_TRANS_AUF.aufwand_gesamt
    END AS aufwand_gesamt,
    CASE
    WHEN WRG_TYP0.wrg_typ_id = 0
    THEN B_TRANS_AUF.aufwand_vorlauf * KURS0.umrechnungskurs
    ELSE B_TRANS_AUF.aufwand_vorlauf
    END AS aufwand_vorlauf,
    CASE
    WHEN WRG_TYP0.wrg_typ_id = 0
    THEN B_TRANS_AUF.aufwand_hauptlauf * KURS0.umrechnungskurs
    ELSE B_TRANS_AUF.aufwand_hauptlauf
    END AS aufwand_hauptlauf,
    CASE
    WHEN WRG_TYP0.wrg_typ_id = 0
    THEN B_TRANS_AUF.aufwand_umschlag * KURS0.umrechnungskurs
    ELSE B_TRANS_AUF.aufwand_umschlag
    END AS aufwand_umschlag,
    CASE
    WHEN WRG_TYP0.wrg_typ_id = 0
    THEN B_TRANS_AUF.aufwand_diesel * KURS0.umrechnungskurs
    ELSE B_TRANS_AUF.aufwand_diesel
    END AS aufwand_diesel
  FROM kfl_production_dbp_view.v_belos_transportauftrag_aufwand_upload_2 AS B_TRANS_AUF
   LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS KURS0 ON B_TRANS_AUF.wrg_id = KURS0.von_wrg_id
   INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS WRG_TYP0 ON B_TRANS_AUF.mandant_id = WRG_TYP0.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS WRG_TYP_USER0 ON WRG_TYP0.wrg_typ_id =
    WRG_TYP_USER0.wrg_typ_id) AS b_trans_auf ON B_VOR.belos_vorgang_id = b_trans_auf.belos_vorgang_id AND B_VOR.mandant_id
    = b_trans_auf.mandant_id
 LEFT JOIN (SELECT mandant_id,
   belos_vorgang_id,
   SUM(gebinde_anz) AS gebinde_anz
  FROM kfl_production_dbp_view.v_belos_packstueck_2
  WHERE belosart_fg = 0
   AND sendung_fg = 1
  GROUP BY mandant_id,
   belos_vorgang_id) AS b_pack ON B_VOR.belos_vorgang_id = b_pack.belos_vorgang_id AND B_VOR.mandant_id = b_pack.mandant_id
   
 LEFT JOIN (SELECT B_TEIL.belos_vorgang_id,
   B_TEIL.mandant_id,
   MAX(B_TEIL.belos_ladung_id) AS belos_ladung_id,
   SUM(CASE
     WHEN B_TEIL.teilstrecke_nr = 1 AND B_VOR0.sammel_ladung_fg = 1
     THEN B_TEIL.anz_stellplatz
     ELSE 0
     END) AS anz_stellplatz_vorlauf,
   SUM(CASE
     WHEN B_TEIL.teilstrecke_nr = 2 AND B_VOR0.sammel_ladung_fg = 1
     THEN B_TEIL.anz_stellplatz
     ELSE 0
     END) AS anz_stellplatz_hauptlauf
  FROM kfl_production_dbp_view.v_belos_teilstrecke_2 AS B_TEIL
   INNER JOIN kfl_production_dbp_view.v_belos_vorgang_2 AS B_VOR0 ON B_TEIL.belos_vorgang_id = B_VOR0.belos_vorgang_id AND
     B_TEIL.mandant_id = B_VOR0.mandant_id
  GROUP BY B_TEIL.belos_vorgang_id,
   B_TEIL.mandant_id) AS b_vor_lad ON B_VOR.belos_vorgang_id = b_vor_lad.belos_vorgang_id AND B_VOR.mandant_id =
   b_vor_lad.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_belos_ladung_2 AS B_LAD ON b_vor_lad.belos_ladung_id = B_LAD.belos_ladung_id AND
   b_vor_lad.mandant_id = B_LAD.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse_2 AS B_AD ON B_VOR.belos_adresse_abholung_id = B_AD.belos_adresse_id
    AND B_VOR.mandant_id = B_AD.mandant_id AND B_AD.spedition_fg = 0 AND B_VOR.k_na_fg = 0
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse_2 AS B_AD_K_NA ON B_VOR.belos_adresse_absender_num_id = B_AD_K_NA.belos_adresse_num_id
      AND B_VOR.mandant_id = B_AD_K_NA.mandant_id AND B_AD_K_NA.spedition_fg = 0 AND B_VOR.k_na_fg = 1
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse_2 AS B_AD_TDL_ORT ON B_VOR.belos_adresse_spedition_id = B_AD_TDL_ORT.belos_adresse_id
     AND B_VOR.mandant_id = B_AD_TDL_ORT.mandant_id AND B_AD_TDL_ORT.spedition_fg = 1
 LEFT JOIN kfl_production_dbp_view.v_besch_best_2 AS BB_KNA ON ROUND(SAFE_CAST(B_VOR.belos_bestell_beleg_id_extern AS
      BIGNUMERIC), 0) = BB_KNA.best_beleg_id AND B_VOR.mandant_id = BB_KNA.mandant_id AND B_VOR.gp_id = - 1
 LEFT JOIN (SELECT belos_vorgang_id,
   mandant_id,
   MIN(best_beleg_id) AS best_beleg_id
  FROM kfl_production_dbp_view.v_besch_best_belos_vorgang_zu_2
  GROUP BY mandant_id,
   belos_vorgang_id) AS bbb_vor ON B_VOR.belos_vorgang_id = bbb_vor.belos_vorgang_id AND B_VOR.mandant_id = bbb_vor.mandant_id
     AND B_VOR.gp_id = - 1
 LEFT JOIN kfl_production_dbp_view.v_besch_best_2 AS BB ON bbb_vor.best_beleg_id = BB.best_beleg_id AND bbb_vor.mandant_id
    = BB.mandant_id
 LEFT JOIN (SELECT belos_vorgang_id,
   mandant_id,
   1 AS thr_fg
  FROM kfl_production_dbp_view.v_belos_transportauftrag_aufwand_upload_2 AS B_TRANS_AUF) AS thr_fg ON B_VOR.belos_vorgang_id
    = thr_fg.belos_vorgang_id AND B_VOR.mandant_id = thr_fg.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_gp_plz_besch_region_zu_per_2 AS B_REG ON CASE
      WHEN B_VOR.gp_id = - 1
      THEN COALESCE(CASE
        WHEN B_VOR.belos_vorgangart_id = 'K-NA'
        THEN BB_KNA.gp_id
        ELSE BB.gp_id
        END, -1)
      ELSE B_VOR.gp_id * 10
      END = B_REG.gp_id AND B_VOR.mandant_id = B_REG.mandant_id AND B_VOR.dat_leistung BETWEEN B_REG.dat_von AND B_REG.dat_bis
     AND CASE
    WHEN B_VOR.belos_vorgangart_id = 'K-NA'
    THEN B_AD_K_NA.plz
    ELSE B_AD.plz
    END = B_REG.abholung_plz
 LEFT JOIN kfl_production_dbp_msi_data.ts_l_stellplatzkategorie_2 AS SP_KAT ON b_pack.gebinde_anz BETWEEN SP_KAT.anz_stellplatz_von
   AND SP_KAT.anz_stellplatz_bis AND B_VOR.sammel_ladung_fg = SP_KAT.sammel_ladung_fg
WHERE B_VOR.belosart_fg = 0;