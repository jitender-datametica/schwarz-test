CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mietvertrag_kondition_per_2 AS SELECT mandant_id,
 mv_intreno,
 mo_intreno,
 dat_von,
 konditionsart_id,
 dat_bis,
 wrg_id,
 miete_per_anno,
 miete_umsatz_prozent,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mietvertrag_kondition_per_2;