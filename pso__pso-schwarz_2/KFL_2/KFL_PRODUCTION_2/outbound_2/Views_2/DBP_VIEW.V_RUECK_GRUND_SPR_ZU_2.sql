CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rueck_grund_spr_zu_2 AS SELECT rueck_grund_id,
 mandant_id,
 spr_id,
 rueck_grund_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rueck_grund_spr_zu_2;