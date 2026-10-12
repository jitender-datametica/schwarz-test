CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_zustaendig_typ AS SELECT zustaendig_typ_id,
 mandant_id,
 zustaendig_typ_bez,
 spr_id
FROM kfl_production_dbp_data.ivs_l_zustaendig_typ;