CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_TAG_1
(
  akt_gj
, akt_gj_komplett
, akt_gjqu
, akt_gjqu_komplett
, akt_gjwo_kl
, akt_gjwo_kl_komplett
, akt_kj
, akt_kj_komplett
, akt_kjqu
, akt_kjqu_komplett
, akt_kjwo_kl
, akt_kjwo_kl_komplett
, akt_mo
, akt_mo_komplett
, akt_tag
, akt_wo
, akt_wo_komplett
, dat
, dat_vj
, gj
, gjmo
, gjmo_vj
, gjqu
, gjtag_id
, gjwo
, gjwo_kl
, gjwo_kl_dat_bis
, gjwo_kl_dat_von
, gjwo_vj
, kj
, kjmo
, kjmo_vj
, kjqu
, kjtag_id
, kjwo
, kjwo_kl
, kjwo_kl_dat_bis
, kjwo_kl_dat_von
, kjwo_vj
, mo_gj
, mo_kj
, wo_dat_bis
, wo_dat_von
, wtag_id
) 
AS 
SELECT 
  v01.akt_gj
, v01.akt_gj_komplett
, v01.akt_gjqu
, v01.akt_gjqu_komplett
, v01.akt_gjwo_kl
, v01.akt_gjwo_kl_komplett
, v01.akt_kj
, v01.akt_kj_komplett
, v01.akt_kjqu
, v01.akt_kjqu_komplett
, v01.akt_kjwo_kl
, v01.akt_kjwo_kl_komplett
, v01.akt_mo
, v01.akt_mo_komplett
, v01.akt_tag
, v01.akt_wo
, v01.akt_wo_komplett
, v01.dat
, v01.dat_vj
, v01.gj
, v01.gjmo
, v01.gjmo_vj
, v01.gjqu
, v01.gjtag_id
, v01.gjwo
, v01.gjwo_kl
, v01.gjwo_kl_dat_bis
, v01.gjwo_kl_dat_von
, v01.gjwo_vj
, v01.kj
, v01.kjmo
, v01.kjmo_vj
, v01.kjqu
, v01.kjtag_id
, v01.kjwo
, v01.kjwo_kl
, v01.kjwo_kl_dat_bis
, v01.kjwo_kl_dat_von
, v01.kjwo_vj
, v01.mo_gj
, v01.mo_kj
, v01.wo_dat_bis
, v01.wo_dat_von
, v01.wtag_id

FROM dbp_view.v_tag_1 v01;