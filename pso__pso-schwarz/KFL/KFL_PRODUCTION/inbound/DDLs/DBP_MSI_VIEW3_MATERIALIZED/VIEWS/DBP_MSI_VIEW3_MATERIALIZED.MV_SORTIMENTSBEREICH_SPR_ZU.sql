create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_SORTIMENTSBEREICH_SPR_ZU(
	SPR_ID,
	SORTIMENTSBEREICH_ID,
	SORTIMENTSBEREICH_BEZ
) as
--2024-03-22, AP0212955, SPEC0242926, dknop, initial
SELECT 
 t01.spr_id
,t01.WG_HIERARCHIE_ID AS sortimentsbereich_id
--use spr ID 22 as fallback for all languages if local language is not maintained (which is currently the case)
,t01.WG_HIERARCHIE_bez AS sortimentsbereich_bez

FROM dbp_view.v_WG_HIERARCHIE_SPR_ZU t01

--INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 --dbp_msi.akt_msi_user_spr_zu v03 
--ON t01.spr_id = v02.spr_id

WHERE  ARTHIERTYP_ID=13 AND WG_HIERARCHIE_EBENE_ID=1 AND spr_id=22

GROUP BY t01.WG_HIERARCHIE_ID, t01.WG_HIERARCHIE_bez,t01.spr_id

UNION
--missing WG_HIERARCHIE_ID='-1'
SELECT
22
,-1
,'Keine Zuordnung';