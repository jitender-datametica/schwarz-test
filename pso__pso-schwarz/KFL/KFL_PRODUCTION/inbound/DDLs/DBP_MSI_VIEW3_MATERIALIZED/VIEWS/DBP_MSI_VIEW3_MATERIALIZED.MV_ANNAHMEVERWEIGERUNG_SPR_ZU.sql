create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ANNAHMEVERWEIGERUNG_SPR_ZU(
	MANDANT_ID,
	ANNAHMEVERWEIGERUNG_ID,
	SPR_ID,
	ANNAHMEVERWEIGERUNG_BEZ
) as -- 20230717 staeblern Umstellung auf Session Variable 
SELECT
   v01.mandant_id,
   v01.annahmeverweigerung_id,
   v01.spr_id,
   v01.annahmeverweigerung_bez
FROM
   dbp_view.v_annahmeverweigerung_spr_zu v01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;