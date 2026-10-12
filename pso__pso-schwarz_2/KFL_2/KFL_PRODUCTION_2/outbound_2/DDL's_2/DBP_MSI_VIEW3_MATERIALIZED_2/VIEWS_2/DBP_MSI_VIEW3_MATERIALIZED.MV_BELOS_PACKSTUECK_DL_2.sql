CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_belos_packstueck_dl_2 (mandant_id, belos_vorgang_id,
packstueck_gebinde_einh_id, packstueck_gebindeart_id, bruttogew_avisiert, sendung_fg, nettogew_avisiert) AS SELECT
 mandant_id,
 belos_vorgang_id,
 packstueck_gebinde_einh_id,
 packstueck_gebindeart_id,
 bruttogew_avisiert,
 sendung_fg,
 nettogew_avisiert
FROM kfl_production_dbp_view.v_belos_packstueck_2
WHERE -- Eingeschränkt auf die Daten der Distributionslogistik
 belosart_fg = 1;