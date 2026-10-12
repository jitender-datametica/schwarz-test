CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lager_einheiten_typ_1 AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 lager_einheiten_typ,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lager_einheiten_typ_1;