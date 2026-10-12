-- 2024-06-26, dknop, AP0226503, SPEC0255672, initial
 -- ON bv.belos_adresse_spedition_id = ts_wup_k.tms_gp_id

-- 2024-11-26, nwag, branch to limit on >= 2023 as an interim solution

-- 2024-10-22, AP0210954_SPEC0239355, dknop, also display TDL for WANKO Tours

-- ON bv.belos_adresse_spedition_id = ts_wup_k.tms_gp_id

-- 2024-09-18, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit duplication

-- 2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
 -- shuttletouren-dummies:

-- 2025-01-22, INC10130607, nwag, add a UNION to fix shuttle tours

-- 2024-08-01,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

-- 2024-08-13, SNIK1809, Updated CASE for tu_costs_incomplete_fg

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_transportation_unit_kosten_upload (mandant_id,
belos_adresse_absender_num_id, belos_adresse_empfaenger_id, belos_adresse_empfaenger_num_id, belos_adresse_spedition_id
, tms, tdl_id, transportation_unit_id, kj_transportation_unit, belos_vorgang_id, lagernummer_id, dat_tour,
kosten_upload_fg, kosten_upload_fg_bez, tu_costs_incomplete_fg) AS SELECT BV.mandant_id,
 BV.belos_adresse_absender_num_id,
 COALESCE(CAST(V02.aktuell_wup_id AS STRING), BV.belos_adresse_empfaenger_id) AS belos_adresse_empfaenger_id,
 COALESCE(CASE
   WHEN ROUND(SAFE_CAST(BV.belos_adresse_empfaenger_id AS BIGNUMERIC), 0) = 0
   THEN NULL
   ELSE SAFE_CAST(V02.aktuell_wup_id AS BIGNUMERIC)
   END, ROUND(SAFE_CAST(LEFT(BV.belos_adresse_empfaenger_id, 4) AS BIGNUMERIC), 0)) AS belos_adresse_empfaenger_id_num,
 BV.belos_adresse_spedition_id -- not used
,
  CASE
  WHEN T_A.dat_tour >= b_w_sw.dat_tms_wanko
  THEN 'WANKO'
  ELSE 'BELOS'
  END AS tms,
  CASE
  WHEN CASE
    WHEN T_A.dat_tour >= b_w_sw.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN COALESCE(v021.spedition_tms_gp_id, '-1')
  ELSE COALESCE(T_A.belos_adresse_spedition_id, '-1')
  END AS tdl_id,
 BV.tour_id AS transportation_unit_id,
 EXTRACT(YEAR FROM BV.dat_leistung) AS kj_transportation_unit,
 BV.belos_vorgang_id,
 L_LAG.lagernummer_id,
 T_A.dat_tour,
 COALESCE(TS_WUP_K.kosten_upload_fg, - 1) AS kosten_upload_fg_,
  CASE
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, - 1) = 1
  THEN 'Km-basiert'
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, - 1) = - 1
  THEN 'nicht definiert / not defined'
  ELSE 'Kosten-basiert'
  END AS abrechnungslogik,
  CASE
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, - 1) = 1 AND IFNULL(TU_K.betrag_diesel, 0) = 0 AND IFNULL(TU_K.betrag_strom,
         0) = 0 AND IFNULL(TU_K.betrag_gas, 0) = 0 AND IFNULL(TU_K.betrag_maut, 0) = 0 AND IFNULL(TU_K.betrag_kuehlung,
      0) = 0 AND IFNULL(TU_K.betrag_sonstiges, 0) = 0
  THEN 1
  ELSE 0
  END AS tu_costs_incomplete_fg
FROM kfl_production_dbp_view.v_belos_vorgang AS BV
 LEFT JOIN kfl_production_dbp_view.v_wup AS V02 ON BV.mandant_id = V02.mandant_id AND V02.wup_id = CASE
     WHEN ROUND(SAFE_CAST(BV.belos_adresse_empfaenger_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(BV.belos_adresse_empfaenger_id AS BIGNUMERIC), 0)
     END AND (V02.nb_id IN (2, 0, - 111) AND V02.wup_id > 0 OR V02.nb_id = - 1 AND V02.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet AS T_A ON BV.mandant_id = T_A.mandant_id AND BV.tour_id
      = T_A.transportation_unit_id AND T_A.aktivitaet_richtung_id = '2' AND BV.dat_leistung = T_A.dat_tour
 LEFT JOIN (SELECT mandant_id,
   lagernummer_id,
   MIN(dat_tms_wanko) AS dat_tms_wanko
  FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm
  WHERE dat_tms_wanko IS NOT NULL
  GROUP BY mandant_id,
   lagernummer_id) AS b_w_sw ON T_A.mandant_id = b_w_sw.mandant_id AND T_A.lagernummer_id = b_w_sw.lagernummer_id
 LEFT JOIN (SELECT DISTINCT T.mandant_id,
   TU.transportation_unit_id,
   T.dat_tour,
    CASE
    WHEN T.tms_tourtyp_id = 105
    THEN 0
    ELSE 1
    END AS distribution_abr_fg,
   T.spedition_tms_gp_id,
   T.temperaturgruppe_id,
   T.tms_tourtyp_id,
   T.tms_tourart_id
  FROM kfl_production_dbp_data.tms_tour AS T
   INNER JOIN kfl_production_dbp_view.v_tag AS D ON T.dat_tour = D.dat AND D.akt_kj >= - 2
   INNER JOIN kfl_production_dbp_view.v_transportation_unit AS TU ON T.mandant_id = TU.mandant_id AND T.transportation_unit_id_ext
      = TU.transportation_unit_id_ext) AS v021 ON T_A.mandant_id = v021.mandant_id AND T_A.transportation_unit_id = v021
    .transportation_unit_id AND T_A.dat_tour = v021.dat_tour
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_kosten AS TU_K ON BV.mandant_id = TU_K.mandant_id AND BV.tour_id
      = TU_K.transportation_unit_id AND BV.belos_adresse_absender_num_id = TU_K.wup_id AND EXTRACT(YEAR FROM BV.dat_leistung
    ) = TU_K.kj_transportation_unit
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per AS TS_WUP_K ON CASE
      WHEN CASE
        WHEN T_A.dat_tour >= b_w_sw.dat_tms_wanko
        THEN 'WANKO'
        ELSE 'BELOS'
        END = 'WANKO'
      THEN COALESCE(v021.spedition_tms_gp_id, '-1')
      ELSE COALESCE(T_A.belos_adresse_spedition_id, '-1')
      END = TS_WUP_K.tms_gp_id AND BV.mandant_id = TS_WUP_K.mandant_id AND BV.belos_adresse_absender_num_id = TS_WUP_K.wup_id
     AND T_A.dat_tour BETWEEN TS_WUP_K.dat_von AND TS_WUP_K.dat_bis
 INNER JOIN kfl_production_dbp_view.v_l_lagernummer AS L_LAG ON BV.mandant_id = L_LAG.mandant_id AND BV.lagernummer_id =
   LEFT(L_LAG.lagernummer_id, 3)
WHERE EXTRACT(YEAR FROM BV.dat_leistung) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
UNION DISTINCT
SELECT BV.mandant_id,
 BV.belos_adresse_absender_num_id,
 CAST(COALESCE(V02.aktuell_wup_id, t7.kunde_id) AS STRING) AS belos_adresse_empfaenger_id,
 COALESCE(V02.aktuell_wup_id, t7.kunde_id) AS belos_adresse_empfaenger_id_num,
 BV.belos_adresse_spedition_id -- not used
,
  CASE
  WHEN T_A.dat_tour >= b_w_sw.dat_tms_wanko
  THEN 'WANKO'
  ELSE 'BELOS'
  END AS tms,
  CASE
  WHEN CASE
    WHEN T_A.dat_tour >= b_w_sw.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN COALESCE(v021.spedition_tms_gp_id, '-1')
  ELSE COALESCE(T_A.belos_adresse_spedition_id, '-1')
  END AS tdl_id,
 BV.tour_id AS transportation_unit_id,
 EXTRACT(YEAR FROM BV.dat_leistung) AS kj_transportation_unit,
 - 1 AS belos_vorgang_id,
 L_LAG.lagernummer_id,
 T_A.dat_tour,
 COALESCE(TS_WUP_K.kosten_upload_fg, - 1) AS kosten_upload_fg_,
  CASE
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, - 1) = 1
  THEN 'Km-basiert'
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, - 1) = - 1
  THEN 'nicht definiert / not defined'
  ELSE 'Kosten-basiert'
  END AS abrechnungslogik,
  CASE
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, - 1) = 1 AND IFNULL(TU_K.betrag_diesel, 0) = 0 AND IFNULL(TU_K.betrag_strom,
         0) = 0 AND IFNULL(TU_K.betrag_gas, 0) = 0 AND IFNULL(TU_K.betrag_maut, 0) = 0 AND IFNULL(TU_K.betrag_kuehlung,
      0) = 0 AND IFNULL(TU_K.betrag_sonstiges, 0) = 0
  THEN 1
  ELSE 0
  END AS tu_costs_incomplete_fg
FROM kfl_production_dbp_view.v_belos_vorgang AS BV
 LEFT JOIN (SELECT mandant_id,
   transportation_unit_id,
   dat_tour,
   kunde_id
  FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum
  WHERE EXTRACT(YEAR FROM dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
  GROUP BY mandant_id,
   transportation_unit_id,
   kunde_id,
   dat_tour) AS t7 ON BV.tour_id = t7.transportation_unit_id AND BV.mandant_id = t7.mandant_id AND BV.dat_leistung = t7
   .dat_tour
 LEFT JOIN kfl_production_dbp_view.v_wup AS V02 ON BV.mandant_id = V02.mandant_id AND t7.kunde_id = V02.wup_id AND (V02
      .nb_id IN (2, 0, - 111) AND V02.wup_id > 0 OR V02.nb_id = - 1 AND V02.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet AS T_A ON BV.mandant_id = T_A.mandant_id AND BV.tour_id
      = T_A.transportation_unit_id AND T_A.aktivitaet_richtung_id = '2' AND BV.dat_leistung = T_A.dat_tour
 LEFT JOIN (SELECT mandant_id,
   lagernummer_id,
   MIN(dat_tms_wanko) AS dat_tms_wanko
  FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm
  WHERE dat_tms_wanko IS NOT NULL
  GROUP BY mandant_id,
   lagernummer_id) AS b_w_sw ON T_A.mandant_id = b_w_sw.mandant_id AND T_A.lagernummer_id = b_w_sw.lagernummer_id
 LEFT JOIN (SELECT DISTINCT T.mandant_id,
   TU.transportation_unit_id,
   T.dat_tour,
    CASE
    WHEN T.tms_tourtyp_id = 105
    THEN 0
    ELSE 1
    END AS distribution_abr_fg,
   T.spedition_tms_gp_id,
   T.temperaturgruppe_id,
   T.tms_tourtyp_id,
   T.tms_tourart_id,
   T.tms_tourart_detail_id
  FROM kfl_production_dbp_data.tms_tour AS T
   INNER JOIN kfl_production_dbp_view.v_tag AS D ON T.dat_tour = D.dat AND D.akt_kj >= - 2
   INNER JOIN kfl_production_dbp_view.v_transportation_unit AS TU ON T.mandant_id = TU.mandant_id AND T.transportation_unit_id_ext
      = TU.transportation_unit_id_ext) AS v021 ON T_A.mandant_id = v021.mandant_id AND T_A.transportation_unit_id = v021
    .transportation_unit_id AND T_A.dat_tour = v021.dat_tour
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_kosten AS TU_K ON BV.mandant_id = TU_K.mandant_id AND BV.tour_id
      = TU_K.transportation_unit_id AND BV.belos_adresse_absender_num_id = TU_K.wup_id AND EXTRACT(YEAR FROM BV.dat_leistung
    ) = TU_K.kj_transportation_unit
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per AS TS_WUP_K ON CASE
      WHEN CASE
        WHEN T_A.dat_tour >= b_w_sw.dat_tms_wanko
        THEN 'WANKO'
        ELSE 'BELOS'
        END = 'WANKO'
      THEN COALESCE(v021.spedition_tms_gp_id, '-1')
      ELSE COALESCE(T_A.belos_adresse_spedition_id, '-1')
      END = TS_WUP_K.tms_gp_id AND BV.mandant_id = TS_WUP_K.mandant_id AND BV.belos_adresse_absender_num_id = TS_WUP_K.wup_id
     AND T_A.dat_tour BETWEEN TS_WUP_K.dat_von AND TS_WUP_K.dat_bis
 INNER JOIN kfl_production_dbp_view.v_l_lagernummer AS L_LAG ON BV.mandant_id = L_LAG.mandant_id AND BV.lagernummer_id =
   LEFT(L_LAG.lagernummer_id, 3)
WHERE v021.tms_tourart_detail_id = 2
 OR T_A.belos_tourart_id = 2 AND EXTRACT(YEAR FROM BV.dat_leistung) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2;