CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_planung_mieteinnahmen_2 AS SELECT mandant_id,
 we_intreno,
 wrg_id,
 planmiete_per_monat,
 planmiete_per_qm,
 planflaeche
FROM kfl_production_dbp_data.immo_planung_mieteinnahmen_2;