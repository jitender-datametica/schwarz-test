CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_fin_kategorie_spr_zu AS SELECT fin_kategorie_id,
 spr_id,
 fin_kategorie_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_fin_kategorie_spr_zu;