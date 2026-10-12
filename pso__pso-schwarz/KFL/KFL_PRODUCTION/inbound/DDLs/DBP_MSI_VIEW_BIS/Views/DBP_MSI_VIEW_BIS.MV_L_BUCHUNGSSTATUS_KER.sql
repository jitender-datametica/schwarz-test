CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_BUCHUNGSSTATUS_KER as
      SELECT
      v01.kj_ker_mo_id,
      v02.gjmo,
      v01.akt_buchungs_schluss,
      v01.akt_gj_buchungs_schluss,
      v01.akt_fruehinfo1,
      v01.akt_fruehinfo2,
      v01.buchungs_schluss_akt,
      v01.buchungs_schluss_vm,
      v01.buchungs_schluss_vvm,
      v01.dat_fruehinfo1,
      v01.dat_fruehinfo2,
      v01.dat_buchungs_schluss

      FROM dbp_view.v_l_buchungsstatus_ker  v01

      JOIN dbp_view.v_monat v02
      ON v01.kj_ker_mo_id = v02.kjmo
;