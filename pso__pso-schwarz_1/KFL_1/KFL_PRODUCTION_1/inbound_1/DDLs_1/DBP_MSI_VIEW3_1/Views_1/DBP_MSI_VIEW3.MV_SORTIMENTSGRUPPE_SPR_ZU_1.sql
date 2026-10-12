CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_SORTIMENTSGRUPPE_SPR_ZU_1(
	SPR_ID,
	SORTIMENTSGRUPPE_ID,
	SORTIMENTSGRUPPE_BEZ
) AS
--2023-08-07, AP0182383, SPEC0207712, dknop, initial
SELECT 
 t01.spr_id
,t01.WG_HIERARCHIE_ID AS sortimentsgruppe_id
--use spr_1 ID 22 as fallback for all languages if local language is not maintained (which is currently the case)
,t01.WG_HIERARCHIE_bez AS sortimentsgruppe_bez

FROM dbp_view.v_WG_HIERARCHIE_SPR_ZU_1 t01

--INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 --dbp_msi.akt_msi_user_spr_zu_1 v03 
--ON t01.spr_id = v02.spr_id

WHERE  ARTHIERTYP_ID=11 AND WG_HIERARCHIE_EBENE_ID=1 AND spr_id=22

GROUP BY t01.WG_HIERARCHIE_ID, t01.WG_HIERARCHIE_bez,t01.spr_id

UNION
--missing WG_HIERARCHIE_ID='-1'
SELECT
22
,-1
,'Keine Zuordnung';