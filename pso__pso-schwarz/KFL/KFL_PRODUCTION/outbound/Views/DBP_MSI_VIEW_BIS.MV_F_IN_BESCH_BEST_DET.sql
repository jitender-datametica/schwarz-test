CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_besch_best_det (mandant_id, buchungskreis_id,
best_beleg_id, best_beleg_pos_id, dat_buch, dat_best_beleg, bestellart_id, in_art_id, in_lief_id,
einkaufsorganisation_id, werk_id, vz_ind, menge_best_bme, menge_bme, best_menge_einh_id, besch_pos_typ_id,
betrag_pos_netto_best_wrg, endrech_fg, rech_plan_id, dat_von_rb, dat_aenderung) AS SELECT V01.mandant_id,
 V01.buchungskreis_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.dat_best_beleg AS dat_buch,
 V01.dat_best_beleg,
 V01.bestellart_id,
 V01.in_art_id,
 V01.in_lief_id,
 V01.einkaufsorganisation_id,
 V01.werk_id,
  CASE
  WHEN V01.retourenpos_fg = 1
  THEN - 1
  ELSE 1
  END AS vz_ind,
  V01.menge_best_bme * CASE
   WHEN V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS menge_best_bme,
  V01.menge_bme * CASE
   WHEN V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS menge_bme,
 V01.best_menge_einh_id,
 V01.besch_pos_typ_id,
  CASE
  WHEN V04.wrg_typ_id = 0
  THEN CAST(V01.betrag_pos_netto_best_wrg AS BIGNUMERIC) * V01.umrechnungskurs * CASE
    WHEN V01.retourenpos_fg = 1
    THEN - 1
    ELSE 1
    END
  ELSE CAST(V01.betrag_pos_netto_best_wrg AS BIGNUMERIC) * CASE
    WHEN V01.retourenpos_fg = 1
    THEN - 1
    ELSE 1
    END
  END AS betrag_pos_netto_best_wrg,
 V01.endrech_fg,
 V01.rech_plan_id,
 V01.dat_von_rb,
 V01.dat_aenderung
FROM kfl_production_dbp_msi_view_bis.tbl_mv_f_in_besch_best_det AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V04 ON TRUE;