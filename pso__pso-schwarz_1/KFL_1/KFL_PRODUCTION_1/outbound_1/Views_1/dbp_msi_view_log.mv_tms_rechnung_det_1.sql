
CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_tms_rechnung_det_1 (USERID STRING) AS select 
mandant_id,
 system_id,
 tms_tour_id,
tms_tour_bez,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_id_ext,
 dat_tour,
 tms_konto_id,
tms_tourstatus_id,
 tms_tourtyp_id,
 startlager_tms_gp_id,
 spedition_tms_gp_id,
 spedition_tms_gp_typ_cd,
 tms,
lieferkunde_tms_gp_id,
 lieferkunde_tms_gp_typ_cd,
 tms_standorttyp_id,
 anz_stellplatz,
 anz_stellplatz_gesamt,
tms_tourart_id,
 wrg_id,
 kosten_upload_fg,
 tourart_id,
 anteil_stellplatz,
 betrag_fixkosten,
 betrag_netto,
 betrag_kosten,
ewm_fg,
 richtung_id,
 frachtzahler_id from
(WITH M_KOSTENART AS (SELECT 'MDIES' AS m_tms_konto_id
   UNION ALL
   SELECT 'MSTRO' AS m_tms_konto_id
   UNION ALL
   SELECT 'MGAS' AS m_tms_konto_id
   UNION ALL
   SELECT 'MMAUT' AS m_tms_konto_id
   UNION ALL
   SELECT 'MKUEH' AS m_tms_konto_id), KOSTEN_ALL AS (SELECT TMS_RECH_D.mandant_id,
    TMS_RECH_D.system_id,
    SAFE_CAST(TMS_RECH_D.tms_tour_id AS BIGNUMERIC) AS tms_tour_id,
    TMS_RECH_D.dat_tour,
    CAST(TMS_RECH_D.tms_konto_id AS STRING) AS tms_konto_id,
    TMS_RECH.wrg_id,
    TMS_RECH.ersteller_tms_gp_id AS frachtzahler_tms_gp_id,
    SUM(TMS_RECH_D.betrag_netto) AS betrag_netto_,
    0 AS betrag_fixkosten_,
    0 AS betrag_kosten_
   FROM kfl_production_dbp_view.v_tms_rechnung_det_1 AS TMS_RECH_D
    INNER JOIN kfl_production_dbp_view.v_tms_rechnung_1 AS TMS_RECH ON TMS_RECH_D.tms_rech_beleg_id = TMS_RECH.tms_rech_beleg_id
        AND TMS_RECH_D.mandant_id = TMS_RECH.mandant_id AND TMS_RECH_D.system_id = TMS_RECH.system_id
   WHERE TMS_RECH.storno_fg = 0
    AND TMS_RECH_D.betrag_netto <> 0
   GROUP BY TMS_RECH_D.mandant_id,
    TMS_RECH_D.system_id,
    tms_tour_id,
    TMS_RECH_D.dat_tour,
    tms_konto_id,
    TMS_RECH.wrg_id,
    frachtzahler_tms_gp_id
   UNION DISTINCT
   (SELECT TMS_TOUR.mandant_id,
     TMS_TOUR.system_id,
     TMS_TOUR.tms_tour_id,
     TMS_TOUR.dat_tour,
     'MFIX' AS tms_konto_id,
     TU_K.wrg_id,
     b_netto.ersteller_tms_gp_id AS frachtzahler_tms_gp_id,
     0 AS betrag_netto_,
     SUM(CASE
       WHEN b_netto.betrag_netto_ > 0
       THEN 0
       ELSE TMS_TOUR.betrag_fixkosten
       END) AS betrag_fixkosten_,
     0 AS betrag_kosten_
    FROM kfl_production_dbp_view.v_tms_tour_1 AS TMS_TOUR_1
     LEFT JOIN (SELECT TMS_RECH_D0.mandant_id,
       SAFE_CAST(TMS_RECH_D0.tms_tour_id AS BIGNUMERIC) AS tms_tour_id,
       TMS_RECH_D0.dat_tour,
       TMS_RECH0.ersteller_tms_gp_id,
       SUM(TMS_RECH_D0.betrag_netto) AS betrag_netto_
      FROM kfl_production_dbp_view.v_tms_rechnung_det_1 AS TMS_RECH_D0
       INNER JOIN kfl_production_dbp_view.v_tms_rechnung_1 AS TMS_RECH0 ON TMS_RECH_D0.tms_rech_beleg_id = TMS_RECH0.tms_rech_beleg_id
           AND TMS_RECH_D0.mandant_id = TMS_RECH0.mandant_id AND TMS_RECH_D0.system_id = TMS_RECH0.system_id
      WHERE TMS_RECH0.storno_fg = 0
       AND TMS_RECH_D0.betrag_netto <> 0
       AND TMS_RECH_D0.tms_konto_id = 700
      GROUP BY TMS_RECH_D0.mandant_id,
       tms_tour_id,
       TMS_RECH_D0.dat_tour,
       TMS_RECH0.ersteller_tms_gp_id) AS b_netto ON TMS_TOUR.mandant_id = b_netto.mandant_id AND TMS_TOUR.tms_tour_id =
        b_netto.tms_tour_id AND TMS_TOUR.dat_tour = b_netto.dat_tour
     LEFT JOIN kfl_production_dbp_view.v_transportation_unit_1 AS TU ON TMS_TOUR.mandant_id = TU.mandant_id AND TMS_TOUR.transportation_unit_id_ext
        = TU.transportation_unit_id_ext
     LEFT JOIN kfl_production_dbp_view.v_transportation_unit_kosten_1 AS TU_K ON TU.mandant_id = TU_K.mandant_id AND TU.transportation_unit_id
        = TU_K.transportation_unit_id
    GROUP BY TMS_TOUR.mandant_id,
     TMS_TOUR.system_id,
     TMS_TOUR.tms_tour_id,
     TMS_TOUR.dat_tour,
     tms_konto_id,
     TU_K.wrg_id,
     frachtzahler_tms_gp_id
    UNION DISTINCT
    SELECT TMS_TOUR0.mandant_id,
     TMS_TOUR0.system_id,
     TMS_TOUR0.tms_tour_id,
     TMS_TOUR0.dat_tour,
     t11.m_tms_konto_id,
     TU_K0.wrg_id,
     TMS_DISPO.bestand_tms_gp_id AS frachtzahler_tms_gp_id,
     SUM(CASE
       WHEN t11.m_tms_konto_id = 'MDIES'
       THEN TU_K0.betrag_diesel
       WHEN t11.m_tms_konto_id = 'MSTRO'
       THEN TU_K0.betrag_strom
       WHEN t11.m_tms_konto_id = 'MGAS'
       THEN TU_K0.betrag_gas
       WHEN t11.m_tms_konto_id = 'MMAUT'
       THEN TU_K0.betrag_maut
       WHEN t11.m_tms_konto_id = 'MKUEH'
       THEN TU_K0.betrag_kuehlung
       ELSE 0
       END) AS betrag_netto_,
     0 AS betrag_fixkosten_,
     0 AS betrag_kosten_
    FROM kfl_production_dbp_view.v_tms_tour_1 AS TMS_TOUR0
     INNER JOIN kfl_production_dbp_view.v_tms_dispostelle_1 AS TMS_DISPO ON TMS_TOUR0.mandant_id = TMS_DISPO.mandant_id
       AND TMS_TOUR0.tms_tour_dispostelle_id = TMS_DISPO.tms_dispostelle_id AND TMS_TOUR0.system_id = TMS_DISPO.system_id
       
     INNER JOIN M_KOSTENART AS t11 ON TRUE
     LEFT JOIN kfl_production_dbp_view.v_transportation_unit_1 AS TU0 ON TMS_TOUR0.mandant_id = TU0.mandant_id AND
       TMS_TOUR0.transportation_unit_id_ext = TU0.transportation_unit_id_ext
     LEFT JOIN kfl_production_dbp_view.v_transportation_unit_kosten_1 AS TU_K0 ON TMS_TOUR0.mandant_id = TU_K0.mandant_id
       AND COALESCE(TU0.transportation_unit_id, ROUND(SAFE_CAST(RIGHT(TMS_TOUR0.transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR0
               .transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0)) = TU_K0.transportation_unit_id AND CASE
        WHEN TU0.kj_transportation_unit IS NOT NULL
        THEN TU0.kj_transportation_unit
        ELSE 1
        END = CASE
        WHEN TU0.kj_transportation_unit IS NOT NULL
        THEN TU_K0.kj_transportation_unit
        ELSE 1
        END
    WHERE COALESCE(TU_K0.betrag_diesel, 0) + COALESCE(TU_K0.betrag_strom, 0) + COALESCE(TU_K0.betrag_gas, 0) + COALESCE(TU_K0
         .betrag_maut, 0) + COALESCE(TU_K0.betrag_kuehlung, 0) > 0
    GROUP BY TMS_TOUR0.mandant_id,
     TMS_TOUR0.system_id,
     TMS_TOUR0.tms_tour_id,
     TMS_TOUR0.dat_tour,
     t11.m_tms_konto_id,
     TU_K0.wrg_id,
     frachtzahler_tms_gp_id)) (SELECT kost.mandant_id,
   TMS_TOUR1.system_id,
   kost.tms_tour_id,
   TMS_TOUR1.tms_tour_bez,
   COALESCE(TU1.transportation_unit_id, TU_LES.tour_id, ROUND(SAFE_CAST(FORMAT_DATE('%Y%m%d', TMS_TOUR1.dat_tour) || CAST(TMS_TOUR1.tms_tour_id AS STRING)
       AS BIGNUMERIC), 0)) AS transportation_unit_id,
   COALESCE(TU1.kj_transportation_unit, EXTRACT(YEAR FROM TU_LES.dat_tour), EXTRACT(YEAR FROM TMS_TOUR1.dat_tour)) AS
   kj_transportation_unit,
   TMS_TOUR1.transportation_unit_id_ext,
   kost.dat_tour,
   kost.tms_konto_id,
   TMS_TOUR1.tms_tourstatus_id,
   TMS_TOUR1.tms_tourtyp_id,
   TMS_DISPO0.bestand_tms_gp_id AS startlager_tms_gp_id,
   COALESCE(TMS_TOUR1.spedition_tms_gp_id, '-1') AS spedition_tms_gp_id,
   TMS_TOUR1.spedition_tms_gp_typ_cd,
   'WANKO' AS tms,
   tms_tour_d.lieferkunde_tms_gp_id,
   tms_tour_d.lieferkunde_tms_gp_typ_cd,
   tms_tour_d.tms_standorttyp_id,
    CASE
    WHEN COALESCE(tms_tour_d.anz_stellplatz_, 0) = 0
    THEN 1
    ELSE tms_tour_d.anz_stellplatz_
    END AS anz_stellplatz,
    CASE
    WHEN COALESCE(tms_tour_d.anz_stellplatz_gesamt, 0) = 0
    THEN 1
    ELSE tms_tour_d.anz_stellplatz_gesamt
    END AS anz_stellplatz_gesamt,
   TMS_TOUR1.tms_tourart_id,
    CASE
    WHEN AKT_U.wrg_typ_id = 0
    THEN 'EUR'
    ELSE COALESCE(kost.wrg_id, CASE
      WHEN AKT_U.wrg_typ_id = 0
      THEN 'EUR'
      ELSE W_TYP.wrg_id
      END)
    END AS wrg_id,
   COALESCE(TS_WUP_K.kosten_upload_fg, -1) AS kosten_upload_fg,
   TMS_TOUR1.tms_tourart_detail_id AS tourart_id,
     CASE
     WHEN tms_tour_d.anz_stellplatz_ IS NULL OR COALESCE(tms_tour_d.anz_stellplatz_gesamt, 0) = 0
     THEN 1
     ELSE tms_tour_d.anz_stellplatz_
     END / CASE
     WHEN COALESCE(tms_tour_d.anz_stellplatz_gesamt, 0) = 0
     THEN CAST(tms_tour_d.anz_kunden_gesamt AS BIGNUMERIC)
     ELSE tms_tour_d.anz_stellplatz_gesamt
     END AS anteil_stellplatz,
    CASE
    WHEN W_TYP.wrg_typ_id = 0
    THEN kost.betrag_fixkosten_ * K.umrechnungskurs
    ELSE kost.betrag_fixkosten_
    END AS betrag_fixkosten,
    CASE
    WHEN W_TYP.wrg_typ_id = 0
    THEN kost.betrag_netto_ * K.umrechnungskurs
    ELSE kost.betrag_netto_
    END AS betrag_netto,
    CASE
    WHEN W_TYP.wrg_typ_id = 0
    THEN kost.betrag_kosten_ * K.umrechnungskurs
    ELSE CAST(kost.betrag_kosten_ AS BIGNUMERIC)
    END AS betrag_kosten,
    CASE
    WHEN LEFT(S.kl_system_bez, 3) = 'FLW'
    THEN 2
    WHEN TU1.transportation_unit_id IS NOT NULL
    THEN 1
    WHEN TU_LES.tour_id IS NOT NULL OR ewm.dat_ewm_von > kost.dat_tour
    THEN 0
    ELSE 1
    END AS ewm_fg,
   TMS_TOUR1.tms_tour_richtungsart_id AS richtung_id,
   kost.frachtzahler_tms_gp_id AS frachtzahler_id
  FROM KOSTEN_ALL AS kost
   INNER JOIN kfl_production_dbp_view.v_tms_tour_1 AS TMS_TOUR1 ON kost.mandant_id = TMS_TOUR1.mandant_id AND kost.tms_tour_id
        = TMS_TOUR1.tms_tour_id AND kost.dat_tour = TMS_TOUR1.dat_tour AND kost.system_id = TMS_TOUR1.system_id
   INNER JOIN kfl_production_dbp_view.v_l_system_1 AS S ON TMS_TOUR1.system_id = S.system_id
   INNER JOIN kfl_production_dbp_view.v_tms_dispostelle_1 AS TMS_DISPO0 ON TMS_TOUR1.mandant_id = TMS_DISPO0.mandant_id
     AND TMS_TOUR1.tms_tour_dispostelle_id = TMS_DISPO0.tms_dispostelle_id AND TMS_TOUR1.system_id = TMS_DISPO0.system_id
     
   INNER JOIN (SELECT mandant_id,
     wup_id,
     MIN(COALESCE(dat, DATE '9999-12-31')) AS dat_ewm_von
    FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1
    GROUP BY mandant_id,
     wup_id) AS ewm ON TMS_DISPO0.mandant_id = ewm.mandant_id AND CAST(TMS_DISPO0.bestand_tms_gp_id AS FLOAT64) = ewm.wup_id
     
   LEFT JOIN kfl_production_dbp_view.v_transportation_unit_1 AS TU1 ON TMS_TOUR1.mandant_id = TU1.mandant_id AND TMS_TOUR1
     .transportation_unit_id_ext = TU1.transportation_unit_id_ext
   LEFT JOIN kfl_production_dbp_view.v_tour_1 AS TU_LES ON TMS_TOUR1.mandant_id = TU_LES.mandant_id AND ROUND(SAFE_CAST(RIGHT(TMS_TOUR1
         .transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR1.transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0) =
      TU_LES.tour_id AND CAST(TMS_DISPO0.bestand_tms_gp_id AS FLOAT64) = TU_LES.wup_id
   LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per_1 AS TS_WUP_K ON TMS_TOUR1.spedition_tms_gp_id
        = TS_WUP_K.tms_gp_id AND TMS_TOUR1.mandant_id = TS_WUP_K.mandant_id AND CAST(TMS_DISPO0.bestand_tms_gp_id AS FLOAT64)
      = TS_WUP_K.wup_id AND TMS_TOUR1.dat_tour BETWEEN TS_WUP_K.dat_von AND TS_WUP_K.dat_bis
   INNER JOIN (SELECT TMS_TOUR_DET.mandant_id,
     TMS_TOUR_DET.system_id,
     TMS_TOUR_DET.tms_tour_id,
     TMS_TOUR_DET.dat_tour,
     TMS_TOUR_DET.lieferkunde_tms_gp_id,
     TMS_TOUR_DET.lieferkunde_tms_gp_typ_cd,
     COALESCE(TMS_GP.tms_standorttyp_id, -1) AS tms_standorttyp_id,
     COUNT(TMS_TOUR_DET.lieferkunde_tms_gp_id) OVER (PARTITION BY TMS_TOUR_DET.mandant_id, TMS_TOUR_DET.system_id,
        TMS_TOUR_DET.tms_tour_id, TMS_TOUR_DET.dat_tour RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
     anz_kunden_gesamt,
     SUM(CASE
       WHEN TMS_TOUR_DET.anz_stellplatz = 0
       THEN COALESCE(TMS_TOUR_DET.anz_stellplatz_retoure, 0)
       ELSE NULL
       END) AS anz_stellplatz_,
     SUM(SUM(CASE
        WHEN TMS_TOUR_DET.anz_stellplatz = 0
        THEN COALESCE(TMS_TOUR_DET.anz_stellplatz_retoure, 0)
        ELSE NULL
        END)) OVER (PARTITION BY TMS_TOUR_DET.mandant_id, TMS_TOUR_DET.system_id, TMS_TOUR_DET.tms_tour_id, TMS_TOUR_DET_1
        .dat_tour RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_stellplatz_gesamt
    FROM kfl_production_dbp_view.v_tms_tour_det_1 AS TMS_TOUR_DET_1
     LEFT JOIN kfl_production_dbp_view.v_tms_gp_1 AS TMS_GP_1 ON TMS_TOUR_DET.mandant_id = TMS_GP.mandant_id AND
         TMS_TOUR_DET.lieferkunde_tms_gp_id = TMS_GP.tms_gp_id AND TMS_TOUR_DET.lieferkunde_tms_gp_typ_cd = TMS_GP.tms_gp_typ_cd
         AND TMS_TOUR_DET.system_id = TMS_GP.system_id
    GROUP BY TMS_TOUR_DET.mandant_id,
     TMS_TOUR_DET.system_id,
     TMS_TOUR_DET.tms_tour_id,
     TMS_TOUR_DET.dat_tour,
     TMS_TOUR_DET.lieferkunde_tms_gp_id,
     TMS_TOUR_DET.lieferkunde_tms_gp_typ_cd,
     TMS_GP.tms_standorttyp_id) AS tms_tour_d ON kost.mandant_id = tms_tour_d.mandant_id AND kost.tms_tour_id =
       tms_tour_d.tms_tour_id AND kost.dat_tour = tms_tour_d.dat_tour AND kost.system_id = tms_tour_d.system_id
   LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_1 AS K ON COALESCE(kost.wrg_id, 'EUR') = K.von_wrg_id
   INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS W_TYP ON TMS_TOUR1.mandant_id = W_TYP.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS AKT_U ON W_TYP.wrg_typ_id = AKT_U.wrg_typ_id
    ));


