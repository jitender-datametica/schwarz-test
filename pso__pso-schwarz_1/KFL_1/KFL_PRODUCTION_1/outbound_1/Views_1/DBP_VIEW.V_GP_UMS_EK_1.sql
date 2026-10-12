CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_ums_ek_1 AS SELECT mandant_id,
 gp_id,
 einkaufsorganisation_id,
 kj_bezugsjahr,
 teilgebiet,
 umsatz_netto,
 umsatz_wrg_id
FROM kfl_production_dbp_data.gp_ums_ek_1;