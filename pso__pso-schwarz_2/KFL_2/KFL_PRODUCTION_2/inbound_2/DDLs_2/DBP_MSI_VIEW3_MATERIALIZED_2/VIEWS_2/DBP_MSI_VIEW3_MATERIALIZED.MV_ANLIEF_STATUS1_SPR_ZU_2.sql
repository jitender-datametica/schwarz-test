create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ANLIEF_STATUS1_SPR_ZU_2(
	ANLIEFERUNG_STATUS1_ID,
	ANLIEFERUNG_STATUS1_BEZ
) as
-- 20230717 staeblern Umstellung auf Session Variable 
   SELECT
   v01.anlieferung_status1_id, v01.anlieferung_status1_bez
   FROM dbp_view.v_anlieferung_status1_spr_zu_2 v01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02
   ON v01.spr_id = v02.spr_id;