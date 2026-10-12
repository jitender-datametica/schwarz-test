
CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_transportation_unit_kosten_upload_1 (USERID STRING) AS
SELECT BV.mandant_id,
 BV.mandant_id_debitor,
 BV.belos_adresse_absender_num_id,
 COALESCE(CASE
   WHEN SAFE_CAST(ROUND(CAST(BV.belos_adresse_empfaenger_id AS FLOAT64)) AS INTEGER) = 0
   THEN NULL
   ELSE V02.aktuell_wup_id
   END, SAFE_CAST(ROUND(CAST(LEFT(BV.belos_adresse_empfaenger_id, 4) AS FLOAT64)) AS INTEGER)) AS
 belos_adresse_empfaenger_id,
 BV.belos_adresse_spedition_id,
 BV.tour_id,
 BV.belos_vorgang_id,
 L_LAG.lagernummer_id,
  CASE
  WHEN V05.wrg_typ_id = 0
  THEN 'EUR'
  ELSE TU_K.wrg_id
  END AS wrg_id_,
 T.dat_tour,
 COALESCE(TS_WUP_K.kosten_upload_fg, -1) AS kosten_upload_fg_,
  CASE
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, -1) = 1
  THEN 'Km-basiert'
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, -1) = -1
  THEN 'nicht definiert / not defined'
  ELSE 'Kosten-basiert'
  END AS abrechnungslogik,
  CASE
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, -1) = 1 AND IFNULL(TU_K.betrag_diesel, 0) = 0 AND IFNULL(TU_K.betrag_strom, 0
         ) = 0 AND IFNULL(TU_K.betrag_gas, 0) = 0 AND IFNULL(TU_K.betrag_maut, 0) = 0 AND IFNULL(TU_K.betrag_kuehlung, 0
      ) = 0 AND IFNULL(TU_K.betrag_sonstiges, 0) = 0
  THEN 1
  ELSE 0
  END AS tu_costs_incomplete_fg
FROM kfl_production_dbp_view.v_belos_vorgang_1 AS BV
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON BV.mandant_id = V02.mandant_id AND V02.wup_id = CASE
     WHEN BV.wup_id = 0 AND BV.belos_adresse_empfaenger_id = 'DCKP'
     THEN 9994
     WHEN BV.wup_id = 0 AND LEFT(BV.belos_adresse_empfaenger_id, 2) = 'DC'
     THEN CAST(SAFE_CAST(ROUND(CAST(RIGHT(BV.belos_adresse_empfaenger_id, 4) AS FLOAT64)) AS INTEGER) AS BIGNUMERIC)
     ELSE BV.wup_id
     END AND (V02.nb_id IN (2, 0, -111) AND V02.wup_id > 0 OR V02.nb_id = -1 AND V02.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_tour_1 AS T ON BV.mandant_id = T.mandant_id AND BV.tour_id = T.tour_id AND T.transportart_id
    IN ('Z001', 'ZF01', 'ZF02', 'ZF03')
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_kosten_1 AS TU_K ON BV.mandant_id = TU_K.mandant_id AND BV.tour_id
     = TU_K.transportation_unit_id AND BV.belos_adresse_absender_num_id = TU_K.wup_id
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per_1 AS TS_WUP_K ON BV.belos_adresse_spedition_id =
     TS_WUP_K.tms_gp_id AND BV.mandant_id = TS_WUP_K.mandant_id AND BV.belos_adresse_absender_num_id = TS_WUP_K.wup_id
  AND T.dat_tour BETWEEN TS_WUP_K.dat_von AND TS_WUP_K.dat_bis
 INNER JOIN kfl_production_dbp_view.v_l_lagernummer_1 AS L_LAG ON BV.mandant_id = L_LAG.mandant_id AND BV.lagernummer_id =
   LEFT(L_LAG.lagernummer_id, 3)
 LEFT JOIN kfl_production_dbp_msi_view3_materialized.mv_kurs_1 AS V03 ON TU_K.wrg_id = V03.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V04 ON BV.mandant_id = V04.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V05 ON V04.wrg_typ_id = V05.wrg_typ_id;

