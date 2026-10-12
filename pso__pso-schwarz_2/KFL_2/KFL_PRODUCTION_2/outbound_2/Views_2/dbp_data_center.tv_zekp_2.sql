CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_zekp_2 AS SELECT mandant_id,
 wup_id AS werks,
 dat_von AS datab,
 gp_id AS lifnr,
 ek_brutto AS abrut,
 ek_mep AS mepre,
 logistikkostenzuschlag AS lokau,
 ek_netto_bnk AS aknb
FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2
WHERE mandant_id = 1
 AND dat_bis = DATE '9999-12-31';