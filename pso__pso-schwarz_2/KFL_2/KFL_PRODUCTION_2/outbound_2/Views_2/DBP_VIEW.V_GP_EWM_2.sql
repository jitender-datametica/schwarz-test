CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_ewm_2 AS SELECT mandant_id,
 gp_ewm_id,
 gp_ewm_id_num,
 gp_ewm_typ_id,
 gp_ewm_grp_id,
 name_org_1,
 name_org_2,
 gp_ewm_guid
FROM kfl_production_dbp_data.gp_ewm_2;