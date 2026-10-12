CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lager_einheiten_typ_spr_zu_1 AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 lager_einheiten_typ,
 spr_id,
 lager_einheiten_typ_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lager_einheiten_typ_spr_zu_1;