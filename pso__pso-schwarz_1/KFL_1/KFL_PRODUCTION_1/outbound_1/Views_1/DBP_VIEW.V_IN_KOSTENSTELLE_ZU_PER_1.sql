CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_kostenstelle_zu_per_1 AS SELECT mandant_id,
 kostenstelle_id,
 krk_id,
 dat_von,
 dat_bis,
 kostenstelle_node_fg,
 kostenstelle_parent_id,
 kostenstelle_child_id,
 kostenstelle_next_id,
 kostenstelle_level_id,
 kostenstelle_bez
FROM kfl_production_dbp_data.in_kostenstelle_zu_per_1;