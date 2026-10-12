CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_cd_typ AS SELECT mandant_id,
 cd_typ_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_cd_typ;