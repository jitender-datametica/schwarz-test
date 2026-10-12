CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_aktivitaet_typ AS SELECT aktivitaet_typ_id,
 mandant_id,
 aktivitaet_typ_bez,
 spr_id
FROM kfl_production_dbp_data.ivs_l_aktivitaet_typ;