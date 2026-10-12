CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_debitor_immo_objekt_zu_1 (mandant_id, immo_objekt_id, debitor_id) AS
SELECT mandant_id,
 immo_objekt_id,
 debitor_id
FROM kfl_production_dbp_data.ivs_debitor_immo_objekt_zu_1;