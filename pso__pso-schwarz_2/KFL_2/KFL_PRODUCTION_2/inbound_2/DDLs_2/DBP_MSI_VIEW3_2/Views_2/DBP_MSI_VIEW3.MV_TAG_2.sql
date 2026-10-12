CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TAG_2
--18.04.2016, srom0404, Feld gjwo_kl_vj lt. Mail von M.Sarbak (19.01.2016) ausgebaut

(
dat
,kjmo
,kjmo_vj
,wtag_id
,kjwo
,kjwo_vj
,gjwo
,gjwo_vj
,wo_dat_von
,wo_dat_bis
,gjmo
,gjmo_vj
,kjqu
,gjqu
,kj
,gj
,kjtag_id
,gjtag_id
,kjwo_kl
--,kjwo_kl_vj
,kjwo_kl_dat_von
,kjwo_kl_dat_bis
,gjwo_kl
--,gjwo_kl_vj
,gjwo_kl_dat_von
,gjwo_kl_dat_bis
,dat_vj
,akt_tag
,akt_mo
,akt_mo_komplett
,akt_wo
,akt_wo_komplett
,akt_gjwo_kl
,akt_gjwo_kl_komplett
,akt_kjwo_kl
,akt_kjwo_kl_komplett
,akt_gjqu
,akt_gjqu_komplett
,akt_kjqu
,akt_kjqu_komplett
,akt_gj
,akt_gj_komplett
,akt_kj
,akt_kj_komplett
,mo_gj
,mo_kj
,dat_vvj
,akt_qu
,dat_vm
,akt_gj_help
)
AS
   SELECT
  dat, kjmo, kjmo_vj, wtag_id, kjwo, kjwo_vj, gjwo, gjwo_vj, wo_dat_von, wo_dat_bis, gjmo, gjmo_vj, kjqu, gjqu, kj, gj, kjtag_id, gjtag_id, kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis, gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, dat_vj, akt_tag, akt_mo, akt_mo_komplett, akt_wo, akt_wo_komplett, akt_gjwo_kl, akt_gjwo_kl_komplett, akt_kjwo_kl, akt_kjwo_kl_komplett, akt_gjqu, akt_gjqu_komplett, akt_kjqu, akt_kjqu_komplett, akt_gj, akt_gj_komplett, akt_kj, akt_kj_komplett, mo_gj, mo_kj, dat_vj-364, akt_mo/3, ADD_MONTHS(dat, -1), CASE WHEN EXTRACT (MONTH FROM(CURRENT_DATE))=3 THEN akt_gj+1 ELSE akt_gj END AS akt_gj_help
   FROM dbp_view.v_tag_2
   WHERE dat > '2004-01-01';