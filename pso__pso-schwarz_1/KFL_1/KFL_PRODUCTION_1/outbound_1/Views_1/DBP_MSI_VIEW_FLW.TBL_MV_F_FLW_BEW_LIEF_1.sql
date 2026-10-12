CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_bew_lief_1 AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.lagerbew_beleg_id,
 V01.bde_vorgang_id,
 V01.werk_id,
 V01.charge_id,
 V01.lagerort_id,
 V01.dat_erfasst,
 V01.zeit_erfasst,
 V01.beleg_gruppe_id,
 V01.dat_haltbarkeit,
 V01.betrag_bew AS betrag_bew_org,
 V01.auftrag_id,
 V01.kj,
 V01.loesch_fg,
 V01.flw_art_id,
 V01.dme_einh_id,
  CASE
  WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
  THEN - 1
  ELSE 1
  END AS vorzeichen,
  V01.nettogew * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS nettogew_lief,
  V01.menge_bme * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS menge_bme_lief,
  V01.menge_dme * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS menge_dme_lief,
 V01.flw_beleg_typ_id,
 V01.altnv_menge_einh_id AS menge_einh_id,
 V01.storno_fg,
 V01.status_mb,
 V01.retourenpos_fg,
 V01.wrg_id AS wrg_id_org,
 V100.default_wrg
FROM kfl_production_dbp_view.v_flw_bew_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.flw_beleg_typ_id = 'WE'
 AND V01.beleg_gruppe_id = 'B'
 AND V01.status_mb IN ('A', 'B', 'C')
 AND V01.loesch_fg <> 1
 AND V01.retourenpos_fg <> 1;