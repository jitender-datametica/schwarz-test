CREATE OR REPLACE VIEW kfl_production_dbp_view.v_verrechnungsart_spr_zu_1 AS SELECT mandant_id,
 verrechnungsart_id,
 spr_id,
 verrechnungsart_bez
FROM kfl_production_dbp_data.verrechnungsart_spr_zu_1;