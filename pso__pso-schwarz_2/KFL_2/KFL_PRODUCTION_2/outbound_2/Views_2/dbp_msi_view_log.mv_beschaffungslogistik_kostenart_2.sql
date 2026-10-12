-- 2022-07-25, AP0112140, SPEC0155506, adding LAD_KOM_FG

-- 2022-07-22, AP0112140, SPEC0155506,  COALESCE(b_vor.tour_id, -1), updating logic for belos_wup_id  dknop

-- 2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_2 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU

-- 2023-02-06, dknop, adding condition than when b_vor.belos_vorgangart_id='K-NA' THEN sammel_ladung_fg = '1'

-- 2022-06-07, AP0112140, SPEC0155506, initial, dknop

-- 2022-08-04, AP0140953, correcting logic for aufwand_gesamt and ertrag_gesamt by adding soll_ist_fg=1; adding sammel_ladung_fg=1 in CROSS JOIN to v_belos_teilstrecke_2

-- 2022-12-01, updating  belos_adresse_spedition_id from K-NA to 429458

-- 2022-08-01, AP0140953, updating logic for zusatz_spot, adding manuelle Dispo

-- 2022-09-12, AP0140953, SPEC0164166, adding besch_region
 -- 2024-10-29, dknop, adding tms logic

-- 2022-09-13, AP0140953, SPEC0164166, adding stellplatzkategorie

-- INC7606869, change akt_msi_user_wrg_typ_zu_2 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_beschaffungslogistik_kostenart_2(USERID STRING) AS
-- dbp_msi.akt_msi_user_wrg_typ_zu_2 wrg_typ_user
 -- dbp_msi.akt_msi_user_wrg_typ_zu_2 wrg_typ_user

-- dbp_msi.akt_msi_user_wrg_typ_zu_2 wrg_typ_user
 SELECT CASE
  WHEN aufwand_ertrag.min_storno_fg = 1
  THEN 1
  ELSE 0
  END AS lad_kom_fg,
 B_VOR.belos_vorgang_id,
 B_VOR.mandant_id,
  CASE
  WHEN B_VOR.belos_vorgangart_id IN ('K-RET', 'K-LT', 'K-AV')
  THEN B_VOR.wup_id
  ELSE COALESCE(B_AD_WUP.wup_id, -1)
  END AS belos_wup_id,
 B_VOR.wup_id,
 B_VOR.nb_id,
 B_VOR.k_na_fg,
 B_VOR.dat_leistung,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN COALESCE(NULLIF('', CAST(B_VOR.belos_adresse_spedition_id AS STRING)), '429458')
  ELSE B_VOR.belos_adresse_spedition_id
  END AS belos_adresse_spedition_id,
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
 B_VOR.belos_vorgangart_id,
 B_VOR.transportauftrag_id,
 COALESCE(B_VOR.tour_id, - 1) AS tour_id,
  CASE
  WHEN B_VOR.belos_vorgangart_id = 'K-NA'
  THEN 1
  ELSE B_VOR.sammel_ladung_fg
  END AS sammel_ladung_fg,
  CASE
  WHEN B_VOR.gp_id <> -1
  THEN RPAD(SUBSTR(CAST(B_VOR.gp_id AS STRING), 1, 39), 7, '0')
  ELSE CAST(B_VOR.gp_id AS STRING)
  END AS gp_id,
 aufwand_ertrag.verrechfall_kostenart_id,
 aufwand_ertrag.aufwand_gesamt,
 aufwand_ertrag.ertrag_gesamt,
  CASE
  WHEN B_VOR.k_na_fg = 1 AND thr_fg.thr_fg = 1
  THEN 0
  WHEN B_VOR.k_na_fg = 1 AND thr_fg.thr_fg IS NULL
  THEN 1
  ELSE NULL
  END AS threshold_fg,
 COALESCE(B_REG.besch_region_id, - 1) AS besch_region_id,
 COALESCE(B_REG.besch_region_koordination_id, - 1) AS besch_region_koordination_id,
 'BELOS' AS tms
FROM kfl_production_dbp_view.v_belos_vorgang_2 AS B_VOR
 LEFT JOIN kfl_production_dbp_view.v_ts_belos_adresse_wup_zu_2 AS B_AD_WUP ON B_VOR.belos_adresse_empfaenger_id = B_AD_WUP
   .belos_adresse_id AND B_VOR.mandant_id = B_AD_WUP.mandant_id
 INNER JOIN ((SELECT VER.belos_vorgang_id,
     VER.mandant_id,
     VER_KOST.verrechfall_kostenart_id,
     MIN(VER.storno_fg) AS min_storno_fg,
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
       WHEN VER.kunde_fg = 1 AND VER_KOST.soll_ist_fg = 1
       THEN CASE
        WHEN WRG_TYP.wrg_typ_id = 0
        THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
        ELSE VER_KOST.betrag_kosten
        END
       ELSE 0
       END) AS ertrag_gesamt
    FROM kfl_production_dbp_view.v_verrechfall_2 AS VER
     INNER JOIN kfl_production_dbp_view.v_verrechfall_kosten_2 AS VER_KOST ON VER.verrechfall_id = VER_KOST.verrechfall_id
         AND VER.mandant_id = VER_KOST.mandant_id AND VER_KOST.verrechfall_status_id NOT IN ('BCC080', 'BCC085',
        'BCC090')
     INNER JOIN kfl_production_dbp_view.v_belos_vorgang_2 AS B_VOR ON VER.belos_vorgang_id = B_VOR.belos_vorgang_id AND
       VER.mandant_id = B_VOR.mandant_id
     LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS KURS_2 ON VER.wrg_id = KURS.von_wrg_id
     INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS WRG_TYP ON VER_KOST.mandant_id = WRG_TYP.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS WRG_TYP_USER ON WRG_TYP.wrg_typ_id =
      WRG_TYP_USER.wrg_typ_id
    WHERE B_VOR.belos_vorgangart_id <> 'K-NA'
    GROUP BY VER.belos_vorgang_id,
     VER.mandant_id,
     VER_KOST.verrechfall_kostenart_id,
     VER.wrg_id
    UNION DISTINCT
    SELECT B_TRANS_AUF.belos_vorgang_id,
     B_TRANS_AUF.mandant_id,
     'K/NA' AS verrechfall_kostenart_id,
     0,
     SUM(CASE
       WHEN WRG_TYP.wrg_typ_id = 0
       THEN B_TRANS_AUF.aufwand_gesamt * KURS.umrechnungskurs
       ELSE B_TRANS_AUF.aufwand_gesamt
       END) AS aufwand_gesamt,
     0 AS ertrag_gesamt
    FROM kfl_production_dbp_view.v_belos_transportauftrag_aufwand_upload_2 AS B_TRANS_AUF
     INNER JOIN kfl_production_dbp_view.v_belos_vorgang_2 AS B_VOR ON B_TRANS_AUF.belos_vorgang_id = B_VOR.belos_vorgang_id
        AND B_TRANS_AUF.mandant_id = B_VOR.mandant_id
     LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS KURS_2 ON B_TRANS_AUF.wrg_id = KURS.von_wrg_id
     INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS WRG_TYP ON B_TRANS_AUF.mandant_id = WRG_TYP.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS WRG_TYP_USER ON WRG_TYP.wrg_typ_id =
      WRG_TYP_USER.wrg_typ_id
    WHERE B_VOR.belos_vorgangart_id = 'K-NA'
    GROUP BY B_TRANS_AUF.belos_vorgang_id,
     B_TRANS_AUF.mandant_id,
     B_TRANS_AUF.wrg_id)
   UNION DISTINCT
   SELECT VER.belos_vorgang_id,
    VER.mandant_id,
    VER_KOST.verrechfall_kostenart_id,
    MIN(VER.storno_fg) AS min_storno_fg,
    0 AS aufwand_gesamt,
    SUM(CASE
      WHEN VER.kunde_fg = 1 AND VER_KOST.soll_ist_fg = 1
      THEN CASE
       WHEN WRG_TYP.wrg_typ_id = 0
       THEN VER_KOST.betrag_kosten * KURS.umrechnungskurs
       ELSE VER_KOST.betrag_kosten
       END
      ELSE 0
      END) AS ertrag_gesamt
   FROM kfl_production_dbp_view.v_verrechfall_2 AS VER
    INNER JOIN kfl_production_dbp_view.v_verrechfall_kosten_2 AS VER_KOST ON VER.verrechfall_id = VER_KOST.verrechfall_id
      AND VER.mandant_id = VER_KOST.mandant_id AND VER_KOST.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090')
    INNER JOIN kfl_production_dbp_view.v_belos_vorgang_2 AS B_VOR ON VER.belos_vorgang_id = B_VOR.belos_vorgang_id AND VER
      .mandant_id = B_VOR.mandant_id
    LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS KURS_2 ON VER.wrg_id = KURS.von_wrg_id
    INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS WRG_TYP ON VER_KOST.mandant_id = WRG_TYP.mandant_id
    INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS WRG_TYP_USER ON WRG_TYP.wrg_typ_id =
     WRG_TYP_USER.wrg_typ_id
   WHERE B_VOR.belos_vorgangart_id = 'K-NA'
   GROUP BY VER.belos_vorgang_id,
    VER.mandant_id,
    VER_KOST.verrechfall_kostenart_id,
    VER.wrg_id) AS aufwand_ertrag ON B_VOR.belos_vorgang_id = aufwand_ertrag.belos_vorgang_id AND B_VOR.mandant_id =
   aufwand_ertrag.mandant_id
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
 LEFT JOIN (SELECT belos_vorgang_id,
   mandant_id,
   1 AS thr_fg
  FROM kfl_production_dbp_view.v_belos_transportauftrag_aufwand_upload_2 AS B_TRANS_AUF) AS thr_fg ON B_VOR.belos_vorgang_id
    = thr_fg.belos_vorgang_id AND B_VOR.mandant_id = thr_fg.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse_2 AS B_AD ON B_VOR.belos_adresse_abholung_id = B_AD.belos_adresse_id
   AND B_VOR.mandant_id = B_AD.mandant_id AND B_AD.spedition_fg = 0
 LEFT JOIN kfl_production_dbp_view.v_gp_plz_besch_region_zu_per_2 AS B_REG ON CAST(CASE
       WHEN B_VOR.gp_id <> -1
       THEN RPAD(SUBSTR(CAST(B_VOR.gp_id AS STRING), 1, 39), 7, '0')
       ELSE CAST(B_VOR.gp_id AS STRING)
       END AS FLOAT64) = B_REG.gp_id AND B_VOR.mandant_id = B_REG.mandant_id AND B_VOR.dat_leistung BETWEEN B_REG.dat_von
    AND B_REG.dat_bis AND B_AD.plz = B_REG.abholung_plz
 LEFT JOIN (SELECT mandant_id,
   belos_vorgang_id,
   SUM(gebinde_anz) AS gebinde_anz
  FROM kfl_production_dbp_view.v_belos_packstueck_2
  WHERE belosart_fg = 0
   AND sendung_fg = 1
  GROUP BY mandant_id,
   belos_vorgang_id) AS b_pack ON B_VOR.belos_vorgang_id = b_pack.belos_vorgang_id AND B_VOR.mandant_id = b_pack.mandant_id
   
WHERE B_VOR.belosart_fg = 0 -- and b_vor.transportauftrag_id='DE13584208'

  -- AND b_vor.dat_leistung='2022-04-20' and b_vor.mandant_id=1 and b_ad_wup.wup_id=6902
;