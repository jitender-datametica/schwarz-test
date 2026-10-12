CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_TAG_2
   -- 11.01.2013 SHoger initial
   -- 01.02.2016 twie: kjwo_kl_vj, gjwo_kl_vj entfernt
   -- 12.12.2017 twie: SPEC0025711 dat_vvj ermitteln

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
   ,kjwo_kl_dat_von
   ,kjwo_kl_dat_bis
   ,gjwo_kl
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
   ,pjwo
   ,dat_vvj
   )
   AS

      SELECT
      v01.dat,
      v01.kjmo,
      v01.kjmo_vj,
      v01.wtag_id,
      v01.kjwo,
      v01.kjwo_vj,
      v01.gjwo,
      v01.gjwo_vj,
      v01.wo_dat_von,
      v01.wo_dat_bis,
      v01.gjmo,
      v01.gjmo_vj,
      v01.kjqu,
      v01.gjqu,
      v01.kj,
      v01.gj,
      v01.kjtag_id,
      v01.gjtag_id,
      v01.kjwo_kl,
      v01.kjwo_kl_dat_von,
      v01.kjwo_kl_dat_bis,
      v01.gjwo_kl,
      v01.gjwo_kl_dat_von,
      v01.gjwo_kl_dat_bis,
      v01.dat_vj,
      v01.akt_tag,
      v01.akt_mo,
      v01.akt_mo_komplett,
      v01.akt_wo_komplett -1  AS  akt_wo,
      v01.akt_wo_komplett,
      v01.akt_gjwo_kl,
      v01.akt_gjwo_kl_komplett,
      v01.akt_kjwo_kl,
      v01.akt_kjwo_kl_komplett,
      v01.akt_gjqu,
      v01.akt_gjqu_komplett,
      v01.akt_kjqu,
      v01.akt_kjqu_komplett,
      v01.akt_gj,
      v01.akt_gj_komplett,
      v01.akt_kj,
      v01.akt_kj_komplett,
      v01.mo_gj,
      v01.mo_kj,
      v01.pjwo,
      v02.dat_vj AS dat_vvj
      FROM dbp_view.v_tag_2 v01

      JOIN dbp_view.v_tag_2 v02
      ON v01.dat_vj = v02.dat
;