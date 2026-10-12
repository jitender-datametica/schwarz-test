CREATE OR REPLACE VIEW kfl_production_dbp_view.v_verfuegbarkeitsgruppe_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 lagernummer_id,
 verfuegbarkeitsgruppe_id,
 verfuegbarkeitsgruppe_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.verfuegbarkeitsgruppe_spr_zu_1;