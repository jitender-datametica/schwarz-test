CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nettostunden_gfos AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 stunden_netto_markt
FROM kfl_production_dbp_data.nettostunden_gfos;