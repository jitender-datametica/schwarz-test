CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_packstueck_dl_1 (mandant_id, belos_vorgang_id,
packstueck_gebinde_einh_id, packstueck_gebindeart_id, bruttogew_avisiert, sendung_fg, nettogew_avisiert) AS SELECT
 mandant_id,
 belos_vorgang_id,
 packstueck_gebinde_einh_id,
 packstueck_gebindeart_id,
 bruttogew_avisiert,
 sendung_fg,
 nettogew_avisiert
FROM kfl_production_dbp_view.v_belos_packstueck_1
WHERE belosart_fg = 1;