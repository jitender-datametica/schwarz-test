CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mandant_wrg_zu_per (mandant_id, wrg_id, von_wrg_id, dat_von, dat_bis,
umrechnungskurs) AS SELECT mandant_id,
 wrg_id,
 von_wrg_id,
 dat_von,
 dat_bis,
 umrechnungskurs
FROM kfl_production_dbp_data.mandant_wrg_zu_per;