

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_bew_lief_2 (mandant_id, best_beleg_id,
best_beleg_pos_id, lagerbew_beleg_id, bde_vorgang_id, werk_id, charge_id, lagerort_id, dat_erfasst, zeit_erfasst,
beleg_gruppe_id, dat_haltbarkeit, auftrag_id, kj, loesch_fg, in_art_id, dme_einh_id, nettogew_lief, menge_bme_lief,
menge_dme_lief, flw_beleg_typ_id, menge_einh_id, storno_fg, status_mb, retourenpos_fg, betrag_bew, wrg_id) AS SELECT V01
 .mandant_id,
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
 V01.auftrag_id,
 V01.kj,
 V01.loesch_fg,
 V01.flw_art_id AS in_art_id,
 V01.dme_einh_id,
 V01.nettogew_lief,
 V01.menge_bme_lief,
 V01.menge_dme_lief,
 V01.flw_beleg_typ_id,
 V01.menge_einh_id,
 V01.storno_fg,
 V01.status_mb,
 V01.retourenpos_fg,
 CAST(CASE
   WHEN V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_bew_org, 0)
   WHEN V01.wrg_id_org <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_bew_org, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag_bew_org, 0) * V500.umrechnungskurs
   WHEN V01.wrg_id_org = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_bew_org, 0)
   ELSE NULL
   END AS NUMERIC) AS betrag_bew,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_flw_bew_lief_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id_org = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_erfasst BETWEEN V500.dat_von AND V500.dat_bis;


