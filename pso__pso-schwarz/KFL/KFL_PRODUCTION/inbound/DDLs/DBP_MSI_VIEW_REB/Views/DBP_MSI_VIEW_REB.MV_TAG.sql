CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_TAG
(
dat
, kjmo
, kjmo_vj
, wtag_id
, kjwo
, kjwo_vj
, gjwo
, gjwo_vj
, wo_dat_von
, wo_dat_bis
, gjmo
, gjmo_vj
, kjqu
, gjqu
, kj
, gj
, kjtag_id
, gjtag_id
, kjwo_kl
, kjwo_kl_dat_von
, kjwo_kl_dat_bis
, gjwo_kl
, gjwo_kl_dat_von
, gjwo_kl_dat_bis
, dat_vj
, akt_tag
, akt_mo
, akt_mo_komplett
, akt_wo
, akt_wo_komplett
, akt_gjwo_kl
, akt_gjwo_kl_komplett
, akt_kjwo_kl
, akt_kjwo_kl_komplett
, akt_gjqu
, akt_gjqu_komplett
, akt_kjqu
, akt_kjqu_komplett
, akt_gj
, akt_gj_komplett
, akt_kj
, akt_kj_komplett
, mo_gj
, mo_kj
, dat_vvj
, akt_qu
, dat_vm
)
AS
   SELECT
   dat, kjmo, kjmo_vj, wtag_id, kjwo, kjwo_vj, gjwo, gjwo_vj, wo_dat_von, wo_dat_bis, gjmo, gjmo_vj, kjqu, gjqu, kj, gj, kjtag_id, gjtag_id, kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis, gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, dat_vj, akt_tag, akt_mo, akt_mo_komplett, akt_wo, akt_wo_komplett, akt_gjwo_kl, akt_gjwo_kl_komplett, akt_kjwo_kl, akt_kjwo_kl_komplett, akt_gjqu, akt_gjqu_komplett, akt_kjqu, akt_kjqu_komplett, akt_gj, akt_gj_komplett, akt_kj, akt_kj_komplett, mo_gj, mo_kj, dat_vj-364, TRUNC( akt_mo/3), ADD_MONTHS(dat, -1)

   FROM dbp_view.v_tag
;