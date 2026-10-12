CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lager_einheiten_typ_2 (mandant_id, lagernummer_id, wup_id, nb_id
, lager_einheiten_typ) AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 lager_einheiten_typ
FROM kfl_production_dbp_view.v_l_lager_einheiten_typ_2;