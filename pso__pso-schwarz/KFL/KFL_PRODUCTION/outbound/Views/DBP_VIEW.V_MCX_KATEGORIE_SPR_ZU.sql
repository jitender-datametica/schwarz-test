CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_kategorie_spr_zu AS SELECT kat_id,
 spr_id,
 kat_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_kategorie_spr_zu;