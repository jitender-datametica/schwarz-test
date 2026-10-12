CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_2 (mandant_id, mv_intreno, mo_intreno, dat_von
, dat_bis, zuordnung_info_kz, td_update, td_insert) AS SELECT mandant_id,
 mv_intreno,
 mo_intreno,
 dat_von,
 dat_bis,
 zuordnung_info_kz,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mietvertrag_mo_zu_per_2;