CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_best_belegfluss_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT best_beleg_id,
 best_beleg_pos_id,
 best_entw_typ_id,
 bestaetigung_lfd_nr,
  CASE
  WHEN soll_haben_kz = 'H'
  THEN betrag_ek_netto * -1
  ELSE betrag_ek_netto
  END AS betrag,
 dat_buch,
 folge_beleg_id,
 folge_beleg_pos_id,
 kj,
 kontierung_pos_id,
 lager_bewart_id,
 mandant_id,
 menge_anteil,
 menge_basis,
 menge_best,
 nb_id,
 ref_beleg_id,
 ref_beleg_pos_id,
 ref_gj,
 soll_haben_kz,
 vorgart_best_entw_id,
 wrg_id,
 wup_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_best_belegfluss_1
WHERE best_entw_typ_id = 'E'
 AND mandant_id = 1;