CREATE OR REPLACE VIEW kfl_production_dbp_view.v_statusgruppe_spr_zu_1 AS SELECT system_id,
 mandant_id,
 statusgruppe_id,
 spr_id,
 statusgruppe_bez
FROM kfl_production_dbp_data.statusgruppe_spr_zu_1;