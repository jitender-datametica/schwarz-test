CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GP_ART_LTS_ZU_2(
	MANDANT_ID,
	GP_ID,
	ART_ID,
	GP_TEILSORTIMENT_ID
) AS
   SELECT
   v02.mandant_id, v02.gp_id, v02.art_id, Coalesce(v03.gp_teilsortiment_id, '999999') gp_teilsortiment_id

   FROM

   (
   SELECT
   v01.mandant_id, v01.gp_id, v01.art_id

   FROM dbp_view.v_art_gp_nm_zu_per_2 v01

   GROUP BY v01.mandant_id, v01.gp_id, v01.art_id
   ) v02
   LEFT JOIN dbp_view.v_ek_infosatz_2 v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.art_id = v03.art_id
   AND v02.gp_id = v03.gp_id

   QUALIFY Rank() Over(PARTITION BY v02.mandant_id, v02.gp_id, v02.art_id ORDER BY v03.ek_infosatz_id DESC NULLS LAST) = 1;