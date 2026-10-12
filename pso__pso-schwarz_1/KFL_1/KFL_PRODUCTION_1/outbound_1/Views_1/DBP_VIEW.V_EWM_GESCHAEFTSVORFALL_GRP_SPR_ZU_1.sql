CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ewm_geschaeftsvorfall_grp_spr_zu_1 AS SELECT mandant_id,
 lagernummer_id,
 ewm_gv_grp_id,
 spr_id,
 ewm_gv_grp_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ewm_geschaeftsvorfall_grp_spr_zu_1;