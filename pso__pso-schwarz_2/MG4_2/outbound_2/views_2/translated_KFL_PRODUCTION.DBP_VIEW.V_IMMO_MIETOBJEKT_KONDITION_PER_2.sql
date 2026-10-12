CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mietobjekt_kondition_per_2 (mandant_id, mo_intreno, dat_von,
konditionsart_id, mo_objekt_nr, dat_bis, wrg_id, miete_per_anno, td_update, td_insert) AS SELECT mandant_id,
 mo_intreno,
 dat_von,
 konditionsart_id,
 mo_objekt_nr,
 dat_bis,
 wrg_id,
 miete_per_anno,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mietobjekt_kondition_per_2;