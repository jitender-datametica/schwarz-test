CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mitarbeiter_abwesenh_spr_zu_2 AS SELECT mandant_id,
 abwesenheit_id,
 spr_id,
 abwesenheit_bez
FROM kfl_production_dbp_data.mitarbeiter_abwesenh_spr_zu_2;