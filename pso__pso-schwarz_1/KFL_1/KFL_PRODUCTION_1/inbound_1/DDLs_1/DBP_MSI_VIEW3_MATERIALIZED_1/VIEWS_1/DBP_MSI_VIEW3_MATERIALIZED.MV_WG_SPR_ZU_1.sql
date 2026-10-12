create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WG_SPR_ZU_1(
	WG_ID,
	SPR_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	WG_BEZ,
	WG_ID_BEZ
) as 
-- 05.08.2018, AP0021792, mkub1811: OWG Umstellung
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   wg_id,
   v01.spr_id,
   arthiertyp_id,
   mandant_id,
   wg_bez,
   wg_id_bez
FROM
   DBP_MSI_VIEW3_MATERIALIZED.tbl_MV_WG_SPR_ZU_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.arthiertyp_id = 2
   AND v01.wg_id >= -3 --17.07.10: Filterung der Korrektur- WG aus VIS/MIS;