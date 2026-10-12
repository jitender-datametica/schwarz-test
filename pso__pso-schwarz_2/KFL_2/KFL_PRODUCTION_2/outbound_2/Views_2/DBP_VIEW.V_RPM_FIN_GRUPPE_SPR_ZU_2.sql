CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_fin_gruppe_spr_zu_2 AS SELECT fin_gruppe_id,
 spr_id,
 fin_kategorie_id,
 fin_gruppe_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_fin_gruppe_spr_zu_2;