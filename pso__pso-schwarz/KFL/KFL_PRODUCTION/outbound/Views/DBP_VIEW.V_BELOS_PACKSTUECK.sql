CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belos_packstueck AS SELECT mandant_id,
 belos_vorgang_id,
 belos_packstueck_id,
 packstueck_gebinde_einh_id,
 packstueck_gebindeart_id,
 gebinde_anz,
 bruttogew_avisiert,
 sendung_fg,
 belosart_fg,
 nettogew_avisiert
FROM kfl_production_dbp_data.belos_packstueck;