CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_artbew_wg_sum_1 (mandant_id, wup_id, nb_id, kjmo, wg_id, dat,
menge, umsatz_netto, default_wrg) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.kjmo,
 V01.wg_id,
 V01.dat,
 V01.menge,
 V01.umsatz_netto,
 V02.default_wrg
FROM kfl_production_dbp_view.v_artbew_wg_sum_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id;