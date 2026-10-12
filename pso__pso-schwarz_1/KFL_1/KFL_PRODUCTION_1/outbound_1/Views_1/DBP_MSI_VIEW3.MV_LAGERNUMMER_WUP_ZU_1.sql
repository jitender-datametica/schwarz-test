CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lagernummer_wup_zu_1 (lagernummer_id, mandant_id, nb_id, wup_id) AS
SELECT lagernummer_id,
 mandant_id,
 nb_id,
 wup_id
FROM kfl_production_dbp_view.v_lagernummer_wup_zu_1;