CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hwg_spr_zu_2 AS SELECT hwg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 hwg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.hwg_spr_zu_2;