CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_packstueck (mandant_id, belos_vorgang_id,
packstueck_gebinde_einh_id, packstueck_gebindeart_id, gebinde_anz, bruttogew_avisiert, sendung_fg, nettogew_avisiert) AS
SELECT mandant_id,
 belos_vorgang_id,
 packstueck_gebinde_einh_id,
 packstueck_gebindeart_id,
  CASE
  WHEN sendung_fg = 1
  THEN gebinde_anz
  ELSE NULL
  END AS gebinde_anz,
 bruttogew_avisiert,
 sendung_fg,
 nettogew_avisiert
FROM kfl_production_dbp_view.v_belos_packstueck
WHERE belosart_fg = 0;