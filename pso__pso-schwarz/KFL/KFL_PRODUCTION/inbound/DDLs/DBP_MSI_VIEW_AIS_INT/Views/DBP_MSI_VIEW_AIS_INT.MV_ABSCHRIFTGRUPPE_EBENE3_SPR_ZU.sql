create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.MV_ABSCHRIFTGRUPPE_EBENE3_SPR_ZU(
	ABSCHRIFTGRUPPE_ID_EBENE3,
	ABSCHRIFTGRUPPE_EBENE3_BEZ
) as
SELECT


v01.abschriftgruppe_id
,COALESCE (MAX(CASE WHEN spr_id = 22  THEN v01.abschriftgruppe_bez END), 'N/A') AS abschriftgruppe_ebene3_bez                     

FROM DBP_VIEW.V_ABSCHRIFTGRUPPE_SPR_ZU v01
JOIN DBP_VIEW.V_ABSCHRIFTGRUPPE v02
ON v01.mandant_id = v02.mandant_id
AND v01.abschriftgruppe_id = v02.abschriftgruppe_id
WHERE v02.abschriftgruppe_ebene_kz = 3
GROUP BY
v01.abschriftgruppe_id;
