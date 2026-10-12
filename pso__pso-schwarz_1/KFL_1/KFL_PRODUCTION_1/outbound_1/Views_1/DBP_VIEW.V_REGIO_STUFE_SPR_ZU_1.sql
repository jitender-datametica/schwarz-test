CREATE OR REPLACE VIEW kfl_production_dbp_view.v_regio_stufe_spr_zu_1 AS SELECT mandant_id,
 regio_stufe_id,
 spr_id,
 regio_stufe_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.regio_stufe_spr_zu_1;