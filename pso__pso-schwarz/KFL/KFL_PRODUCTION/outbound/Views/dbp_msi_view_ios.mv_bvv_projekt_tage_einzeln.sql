CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_projekt_tage_einzeln AS SELECT A12.projekt_id,
 A12.projekt_nr,
 MAX(CASE
   WHEN A11.cpr_suchfeld_id = 'CPR_BAUABNAHME'
   THEN A11.dat_termin
   ELSE NULL
   END) AS cpr_bauabnahme,
 MAX(CASE
   WHEN A11.cpr_suchfeld_id = 'BAUBEGINN'
   THEN A11.dat_termin
   ELSE NULL
   END) AS baubeginn,
 MAX(CASE
   WHEN A11.cpr_suchfeld_id = 'CPR_BAUBEG_KAELTE'
   THEN A11.dat_termin
   ELSE NULL
   END) AS cpr_baubeg_kaelte,
 MAX(CASE
   WHEN A11.cpr_suchfeld_id = 'KBE_FS_VP_VERABSCHIEDET'
   THEN A11.dat_termin
   ELSE NULL
   END) AS kbe_fs_vp_verabschiedet,
 MAX(CASE
   WHEN A11.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
   THEN A11.dat_termin
   ELSE NULL
   END) AS stille_eroeffnung,
 MAX(CASE
   WHEN A11.cpr_suchfeld_id = 'BEGINN_EINRICHTUNG'
   THEN A11.dat_termin
   ELSE NULL
   END) AS beginn_einrichtung,
 MAX(A11.dat_termin_gj) AS dat_termin_gj
FROM kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt AS A11
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_cpr_phase AS A12 ON A11.projekt_phase_id = A12.projekt_phase_id
GROUP BY A12.projekt_id,
 A12.projekt_nr;