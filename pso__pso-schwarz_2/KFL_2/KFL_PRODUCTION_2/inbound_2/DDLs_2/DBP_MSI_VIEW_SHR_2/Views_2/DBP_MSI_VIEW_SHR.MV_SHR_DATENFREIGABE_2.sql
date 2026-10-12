CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_SHR_DATENFREIGABE_2 as

   SELECT
   v01.mandant_id, v01.kjmo, max(v01.dat) as dat, max(v01.user_id) as user_id, v01.shr_freigabe_fg


   FROM dbp_msi_v_view.v_shr_datenfreigabe_2 v01

   WHERE
   v01.shr_freigabe_fg = 1

   group by 1,2,5
;