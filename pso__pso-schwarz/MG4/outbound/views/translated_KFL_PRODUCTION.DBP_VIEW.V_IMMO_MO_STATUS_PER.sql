CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mo_status_per (mandant_id, mo_status_id, mo_intreno, mv_intreno,
dat_status_von, dat_status_bis, dat_uebergabe, dat_rueckgabe, td_update, td_insert) AS SELECT mandant_id,
 mo_status_id,
 mo_intreno,
 mv_intreno,
 dat_status_von,
 dat_status_bis,
 dat_uebergabe,
 dat_rueckgabe,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mo_status_per;