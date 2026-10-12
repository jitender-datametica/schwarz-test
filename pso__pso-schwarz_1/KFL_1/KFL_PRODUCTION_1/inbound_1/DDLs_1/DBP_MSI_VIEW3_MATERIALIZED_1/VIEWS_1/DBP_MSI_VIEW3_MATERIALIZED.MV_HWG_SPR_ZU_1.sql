create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_HWG_SPR_ZU_1(
	HWG_ID,
	HWG_BEZ,
	HWG_ID_BEZ,
	MANDANT_ID,
	ARTHIERTYP_ID,
	SPR_ID
) as 
-- LOOKUP : Hauptwarengruppe
-- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)
-- 20170508 AP0017810, SPEC0021927
--05.08.2018, AP0021792, mkub1811: OWG Umstellung
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.hwg_id,
   v01.hwg_bez,
   v01.hwg_id_bez,
   v01.mandant_id,
   v01.arthiertyp_id,
   v01.spr_id
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_HWG_SPR_ZU_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.arthiertyp_id = 2;