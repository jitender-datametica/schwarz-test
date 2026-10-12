
CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_spanne_wb_bld
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT BF.dat_lagerbew_ist AS dat_,
 BFD.lief_beleg_id AS beleg_wb_id,
 BFD.lief_beleg_pos_id AS beleg_wb_pos_id,
 BFD.mandant_id,
 7 AS system_id,
  CASE
  WHEN test.merker = 1
  THEN BFD.wup_id
  ELSE CAST(ROUND(CAST(BF.auftraggeber_id AS FLOAT64)) AS INTEGER)
  END AS abs_id,
  CASE
  WHEN test.merker = 1
  THEN CAST(ROUND(CAST(BF.auftraggeber_id AS FLOAT64)) AS INTEGER)
  ELSE BFD.wup_id
  END AS rcv_id,
 BFD.art_id,
 BF.lief_typ_id AS bew_art_wb_id,
 BF.lief_typ_id AS belastungsart_id,
 1 AS belastungsart_vd_id,
 ROUND(CAST(CASE
    WHEN test.merker = 1
    THEN COALESCE(ZEKP.ek_netto * ZEKP.komponentenmenge, ZEKP_GP.ek_netto * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme
    ELSE COALESCE(ZEKP.ek_netto * ZEKP.komponentenmenge, ZEKP_GP.ek_netto * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme * -1
    END AS NUMERIC), 3) AS ek_netto,
 ROUND(CAST(CASE
    WHEN test.merker = 1
    THEN COALESCE(ZEKP.ek_netto_bnk * ZEKP.komponentenmenge, ZEKP_GP.ek_netto_bnk * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme
    ELSE COALESCE(ZEKP.ek_netto_bnk * ZEKP.komponentenmenge, ZEKP_GP.ek_netto_bnk * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme * -1
    END AS NUMERIC), 3) AS ek_netto_bnk,
 MP.mwst,
 MP.mwst_id,
 1 AS spanne_wb_herkunft_id,
  CASE
  WHEN test.merker = 1
  THEN BFD.menge_lief_ist_lme
  ELSE BFD.menge_lief_ist_lme * -1.0
  END AS menge
FROM kfl_production_dbp_view.v_besch_lief_det AS BFD
 INNER JOIN (SELECT 1 AS merker
   FROM kfl_production_dbp_view.v_spr
   WHERE spr_id = 22
   UNION ALL
   SELECT 2 AS merker
   FROM kfl_production_dbp_view.v_spr
   WHERE spr_id = 22) AS test ON TRUE
 INNER JOIN kfl_production_dbp_view.v_besch_lief AS BF ON BFD.lief_beleg_id = BF.lief_beleg_id AND BFD.mandant_id = BF.mandant_id
      AND BFD.dat_lief_soll = BF.dat_lief_soll AND BF.lief_typ_id = 'YU'
 INNER JOIN kfl_production_dbp_view.v_art AS A ON BFD.art_id = A.art_id AND BFD.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS MP ON A.mwst_id = MP.mwst_id AND A.mandant_id = MP.mandant_id AND BF.dat_lagerbew_ist
   BETWEEN MP.dat_von AND MP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS AGZ ON BFD.art_id = AGZ.art_id AND BFD.mandant_id = AGZ.mandant_id
     AND BF.dat_lief_soll BETWEEN AGZ.dat_von AND AGZ.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS ZEKP ON BFD.art_id = ZEKP.art_id AND BFD.mandant_id = ZEKP.mandant_id
        AND AGZ.gp_id = ZEKP.gp_id AND CASE
      WHEN BFD.nb_id = -111
      THEN BFD.wup_id
      ELSE -1
      END = ZEKP.wup_id AND CASE
     WHEN BFD.nb_id = -111
     THEN BFD.nb_id
     ELSE -1
     END = COALESCE(ZEKP.nb_id, -1) AND BF.dat_lagerbew_ist BETWEEN ZEKP.dat_von AND ZEKP.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS ZEKP_GP ON BFD.art_id = ZEKP_GP.art_id AND BFD.mandant_id =
       ZEKP_GP.mandant_id AND ZEKP_GP.gp_id <> AGZ.gp_id AND CASE
      WHEN BFD.nb_id = -111
      THEN BFD.wup_id
      ELSE -1
      END = ZEKP_GP.wup_id AND CASE
     WHEN BFD.nb_id = -111
     THEN BFD.nb_id
     ELSE -1
     END = COALESCE(ZEKP_GP.nb_id, -1) AND BF.dat_lagerbew_ist BETWEEN ZEKP_GP.dat_von AND ZEKP_GP.dat_bis
WHERE BFD.mandant_id = 1;