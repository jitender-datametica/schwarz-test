CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktivitaetsbereich_spr_zu AS SELECT mandant_id,
 lagernummer_id,
 aktivitaetsbereich_id,
 spr_id,
 aktivitaetsbereich_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.aktivitaetsbereich_spr_zu;