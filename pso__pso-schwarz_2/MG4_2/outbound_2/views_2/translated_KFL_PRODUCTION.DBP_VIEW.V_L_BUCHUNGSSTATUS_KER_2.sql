CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_buchungsstatus_ker_2 (kj_ker_mo_id, akt_buchungs_schluss,
akt_gj_buchungs_schluss, akt_fruehinfo1, akt_fruehinfo2, buchungs_schluss_akt, buchungs_schluss_vm, buchungs_schluss_vvm
, dat_fruehinfo1, dat_fruehinfo2, dat_buchungs_schluss, td_insert, td_update) AS SELECT kj_ker_mo_id,
 akt_buchungs_schluss,
 akt_gj_buchungs_schluss,
 akt_fruehinfo1,
 akt_fruehinfo2,
 buchungs_schluss_akt,
 buchungs_schluss_vm,
 buchungs_schluss_vvm,
 dat_fruehinfo1,
 dat_fruehinfo2,
 dat_buchungs_schluss,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_buchungsstatus_ker_2;