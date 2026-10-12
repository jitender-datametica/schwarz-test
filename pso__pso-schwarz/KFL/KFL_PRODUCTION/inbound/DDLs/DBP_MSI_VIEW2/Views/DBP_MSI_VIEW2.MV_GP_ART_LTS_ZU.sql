CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_GP_ART_LTS_ZU(
	mandant_id,
	gp_id,
	art_id,
	gp_teilsortiment_id
) AS

   SELECT v02.mandant_id,
   v02.gp_id,
   v02.art_id,
   COALESCE(v03.gp_teilsortiment_id, '999999') gp_teilsortiment_id

  FROM

  (SELECT v01.mandant_id,
   v01.gp_id,
   v01.art_id

  FROM dbp_view.v_art_gp_nm_zu_per v01

   WHERE v01.mandant_id = 1

   GROUP BY v01.mandant_id, v01.gp_id, v01.art_id) v02
   LEFT JOIN dbp_view.v_ek_infosatz v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.art_id = v03.art_id
   AND v02.gp_id = v03.gp_id

   QUALIFY RANK() OVER(PARTITION BY v02.mandant_id, v02.gp_id, v02.art_id ORDER BY v03.ek_infosatz_id DESC NULLS LAST) = 1;