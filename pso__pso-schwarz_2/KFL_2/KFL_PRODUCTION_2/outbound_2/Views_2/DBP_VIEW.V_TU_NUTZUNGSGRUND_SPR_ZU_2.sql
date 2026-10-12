CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tu_nutzungsgrund_spr_zu_2 AS SELECT mandant_id,
 lager,
 tu_nutzungsgrund_id,
 spr_id,
 tu_nutzungsgrund_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.tu_nutzungsgrund_spr_zu_2;