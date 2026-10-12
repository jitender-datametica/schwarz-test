CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rpm_fin_gruppe_1 AS SELECT fin_gruppe_id,
 fin_kategorie_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_rpm_fin_gruppe_1;