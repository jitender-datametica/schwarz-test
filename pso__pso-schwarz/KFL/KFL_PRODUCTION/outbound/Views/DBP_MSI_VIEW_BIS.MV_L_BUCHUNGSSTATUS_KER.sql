CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_buchungsstatus_ker AS SELECT V01.kj_ker_mo_id,
 V02.gjmo,
 V01.akt_buchungs_schluss,
 V01.akt_gj_buchungs_schluss,
 V01.akt_fruehinfo1,
 V01.akt_fruehinfo2,
 V01.buchungs_schluss_akt,
 V01.buchungs_schluss_vm,
 V01.buchungs_schluss_vvm,
 V01.dat_fruehinfo1,
 V01.dat_fruehinfo2,
 V01.dat_buchungs_schluss
FROM kfl_production_dbp_view.v_l_buchungsstatus_ker AS V01
 INNER JOIN kfl_production_dbp_view.v_monat AS V02 ON V01.kj_ker_mo_id = V02.kjmo;