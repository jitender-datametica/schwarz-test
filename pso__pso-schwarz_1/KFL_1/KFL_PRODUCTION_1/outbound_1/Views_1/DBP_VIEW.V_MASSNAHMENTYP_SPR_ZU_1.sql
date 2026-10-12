CREATE OR REPLACE VIEW kfl_production_dbp_view.v_massnahmentyp_spr_zu_1 AS SELECT massnahmentyp_id,
 spr_id,
 massnahmentyp_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.massnahmentyp_spr_zu_1;