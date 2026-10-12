create or replace view DBP_MSI_VIEW2.MV_ART_GP_ZU_PER_1(
	ART_ID,
	GP_ID,
	MANDANT_ID,
	AKTUELL_FG
) as
   SELECT
  art_id, gp_id, mandant_id, CASE WHEN dat_bis = '9999-12-31' THEN 'a'ELSE 'h' END AS aktuell_fg
   FROM dbp_view.v_art_gp_zu_per_1
   WHERE mandant_id = 1
   QUALIFY
   SUM(1) OVER (PARTITION BY  art_id,  gp_id,  mandant_id ORDER BY dat_bis DESC NULLS LAST ROWS UNBOUNDED PRECEDING) = 1;