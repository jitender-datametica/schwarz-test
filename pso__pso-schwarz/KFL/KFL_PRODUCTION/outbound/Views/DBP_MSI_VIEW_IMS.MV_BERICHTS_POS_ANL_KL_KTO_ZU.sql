CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_berichts_pos_anl_kl_kto_zu AS SELECT 'AKL:' ||
  anlage_klasse_id AS anl_kl_kto_id,
 berichts_position_invest_id,
 berichts_position_it_id
FROM kfl_production_dbp_msi_v_view.v_berichts_pos_anl_kls_zu_per
WHERE dat_bis = DATE '9999-12-31'
UNION DISTINCT
SELECT 'KTO:' || kostenart_id AS anl_kl_kto_id,
 berichts_position_invest_id,
 berichts_position_it_id
FROM kfl_production_dbp_msi_v_view.v_berichts_pos_kostart_zu_per
WHERE dat_bis = DATE '9999-12-31';