create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_VORGART_BEST_ENTW_SPR_ZU(
	MANDANT_ID,
	VORGART_BEST_ENTW_ID,
	SPR_ID,
	VORGART_BEST_ENTW_BEZ
) as
 -- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.vorgart_best_entw_id,
   v01.spr_id,
   v01.vorgart_best_entw_bez
FROM
   dbp_view.v_vorgart_best_entw_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;