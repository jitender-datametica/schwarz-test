CREATE OR REPLACE VIEW kfl_production_dbp_view.v_monat_spr_zu_2 (mo_id, spr_id, mo_bez, td_update, td_insert) AS SELECT
 mo_id,
 spr_id,
 mo_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.monat_spr_zu_2;