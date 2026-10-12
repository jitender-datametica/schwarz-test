CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_MONAT_2
AS
   SELECT
   v01.kjmo, v01.kjmo_vj, v01.kj, v01.mo_kj, v01.gj, v01.mo_gj, v01.akt_mo, v01.akt_mo_komplett, v01.akt_gj, v01.akt_gj_komplett, v01.akt_kj, v01.akt_kj_komplett, v01.gjmo, v01.gjmo_vj, v01.kjqu, v01.akt_kjqu, v01.akt_kjqu_komplett, v01.gjqu, v01.akt_gjqu, v01.akt_gjqu_komplett, v01.min_dat AS mo_dat_von, v01.max_dat AS mo_dat_bis


   FROM dbp_view.v_monat_2  v01

   WHERE v01.akt_gj BETWEEN -10 AND 1;