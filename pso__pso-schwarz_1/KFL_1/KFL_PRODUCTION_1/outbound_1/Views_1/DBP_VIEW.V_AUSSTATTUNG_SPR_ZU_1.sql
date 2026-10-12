CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ausstattung_spr_zu_1 AS SELECT mandant_id,
 ausstattung_id,
 spr_id,
 ausstattung_bez
FROM kfl_production_dbp_data.ausstattung_spr_zu_1;