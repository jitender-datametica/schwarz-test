CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_best_belegfluss_bnk
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 1 AS anzahlpositionen,
 folge_beleg_id,
 folge_beleg_pos_id,
 kj,
 kond_stufe_id,
 kond_zaehl_id,
 vorgart_best_entw_id,
 best_entw_typ_id,
 betrag_kondition,
 soll_haben_kz,
 ref_lagerbew_beleg_id,
 gp_id,
 dat_erfasst,
 dat_buch,
 7 AS system_id,
 konditionsart_id,
 wrg_id
FROM kfl_production_dbp_view.v_best_belegfluss_bnk AS V01
WHERE mandant_id = 1;