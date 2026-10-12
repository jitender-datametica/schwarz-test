CREATE OR REPLACE VIEW kfl_production_dbp_view.v_beleg_alter_spr_zu (system_id, mandant_id, spr_id, beleg_alter_id,
beleg_alter_bez) AS SELECT system_id,
 mandant_id,
 spr_id,
 beleg_alter_id,
 beleg_alter_bez
FROM kfl_production_dbp_data.beleg_alter_spr_zu;