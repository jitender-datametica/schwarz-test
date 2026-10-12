CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_BUCHUNGSSTATUS_KER
(
kj_ker_mo_id
, gjmo
, akt_buchungs_schluss
, akt_gj_buchungs_schluss
, akt_fruehinfo1
, akt_fruehinfo2
, buchungs_schluss_akt
, buchungs_schluss_vm
, buchungs_schluss_vvm
, dat_fruehinfo1
, dat_fruehinfo2
, dat_buchungs_schluss
)
AS
   SELECT
   v01.kj_ker_mo_id  --entspricht kjmo
   , v02.gjmo, v01.akt_buchungs_schluss, v01.akt_gj_buchungs_schluss, v01.akt_fruehinfo1, v01.akt_fruehinfo2, v01.buchungs_schluss_akt, v01.buchungs_schluss_vm, v01.buchungs_schluss_vvm, v01.dat_fruehinfo1, v01.dat_fruehinfo2, v01.dat_buchungs_schluss

   FROM dbp_view.v_l_buchungsstatus_ker v01

   JOIN dbp_view.v_monat v02
   ON v01.kj_ker_mo_id = v02.kjmo;