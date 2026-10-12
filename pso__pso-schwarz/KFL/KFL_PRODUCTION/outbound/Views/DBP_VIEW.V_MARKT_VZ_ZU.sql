CREATE OR REPLACE VIEW kfl_production_dbp_view.v_markt_vz_zu AS SELECT mandant_id,
 vz_wup_id,
 wup_id,
 entfernung,
 direkte_zuordnung_fg
FROM kfl_production_dbp_data.markt_vz_zu;