CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_spanne_wb_bld_1 (dat, beleg_wb_id, beleg_wb_pos_id, mandant_id,
system_id, abs_id, rcv_id, art_id, bew_art_wb_id, belastungsart_id, belastungsart_vd_id, vk_brutto, ek_netto, mwst,
mwst_id, spanne_wb_herkunft_id, menge) AS SELECT BF.dat_lagerbew_ist AS dat_,
 BFD.lief_beleg_id AS beleg_wb_id,
 BFD.lief_beleg_pos_id AS beleg_wb_pos_id,
 BFD.mandant_id,
 7 AS system_id,
  CASE
  WHEN test.merker = 1
  THEN BFD.wup_id
  ELSE ROUND(CAST(BF.auftraggeber_id AS BIGNUMERIC), 0)
  END AS abs_id,
  CASE
  WHEN test.merker = 1
  THEN ROUND(CAST(BF.auftraggeber_id AS BIGNUMERIC), 0)
  ELSE BFD.wup_id
  END AS rcv_id,
 BFD.art_id,
 BF.lief_typ_id AS bew_art_wb_id,
 BF.lief_typ_id AS belastungsart_id,
 1 AS belastungsart_vd_id,
 ROUND(CAST(CASE
    WHEN test.merker = 1
    THEN COALESCE(ZEKP.ek_netto * ZEKP.komponentenmenge, ZEKP_GP.ek_netto * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme
    ELSE COALESCE(ZEKP.ek_netto * ZEKP.komponentenmenge, ZEKP_GP.ek_netto * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme * - 1
    END AS NUMERIC), 3) AS ek_netto,
 ROUND(CAST(CASE
    WHEN test.merker = 1
    THEN COALESCE(ZEKP.ek_netto_bnk * ZEKP.komponentenmenge, ZEKP_GP.ek_netto_bnk * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme
    ELSE COALESCE(ZEKP.ek_netto_bnk * ZEKP.komponentenmenge, ZEKP_GP.ek_netto_bnk * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme * - 1
    END AS NUMERIC), 3) AS ek_netto_bnk,
 MP.mwst,
 MP.mwst_id,
 1 AS spanne_wb_herkunft_id,
  CASE
  WHEN test.merker = 1
  THEN BFD.menge_lief_ist_lme
  ELSE BFD.menge_lief_ist_lme * - 1.0
  END AS menge
FROM kfl_production_dbp_view.v_besch_lief_det_1 AS BFD
 INNER JOIN (SELECT 1 AS merker
   FROM kfl_production_dbp_view.v_spr_1
   WHERE spr_id = 22
   UNION ALL
   SELECT 2 AS merker
   FROM kfl_production_dbp_view.v_spr_1
   WHERE spr_id = 22) AS test_1 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_besch_lief_1 AS BF ON BFD.lief_beleg_id = BF.lief_beleg_id AND BFD.mandant_id = BF.mandant_id
      AND BFD.dat_lief_soll = BF.dat_lief_soll AND BF.lief_typ_id = 'YU'
 INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON BFD.art_id = A.art_id AND BFD.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS MP ON A.mwst_id = MP.mwst_id AND A.mandant_id = MP.mandant_id AND BF.dat_lagerbew_ist
   BETWEEN MP.dat_von AND MP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per_1 AS AGZ ON BFD.art_id = AGZ.art_id AND BFD.mandant_id = AGZ.mandant_id
     AND BF.dat_lief_soll BETWEEN AGZ.dat_von AND AGZ.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per_1 AS ZEKP_1 ON BFD.art_id = ZEKP.art_id AND BFD.mandant_id = ZEKP.mandant_id
        AND AGZ.gp_id = ZEKP.gp_id AND CASE
      WHEN BFD.nb_id = - 111
      THEN BFD.wup_id
      ELSE CAST(- 1 AS BIGNUMERIC)
      END = ZEKP.wup_id AND CASE
     WHEN BFD.nb_id = - 111
     THEN BFD.nb_id
     ELSE CAST(- 1 AS BIGNUMERIC)
     END = COALESCE(ZEKP.nb_id, - 1) AND BF.dat_lagerbew_ist BETWEEN ZEKP.dat_von AND ZEKP.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per_1 AS ZEKP_GP ON BFD.art_id = ZEKP_GP.art_id AND BFD.mandant_id =
       ZEKP_GP.mandant_id AND ZEKP_GP.gp_id <> AGZ.gp_id AND CASE
      WHEN BFD.nb_id = - 111
      THEN BFD.wup_id
      ELSE CAST(- 1 AS BIGNUMERIC)
      END = ZEKP_GP.wup_id AND CASE
     WHEN BFD.nb_id = - 111
     THEN BFD.nb_id
     ELSE CAST(- 1 AS BIGNUMERIC)
     END = COALESCE(ZEKP_GP.nb_id, - 1) AND BF.dat_lagerbew_ist BETWEEN ZEKP_GP.dat_von AND ZEKP_GP.dat_bis
WHERE BFD.mandant_id = 1;