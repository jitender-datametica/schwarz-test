create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WG_SORTIMENTSGRUPPE(
	WG_ID,
	SORTIMENTSGRUPPE_ID
) as
--2023-08-07, AP0182383, SPEC0207712, dknop, initial
SELECT
 wg.wg_id
,COALESCE(scm.WG_HIERARCHIE_MUTTER_ID,-1) AS sortimentsgruppe_id
FROM dbp_view.v_wg_per wg
LEFT JOIN dbp_view.v_WG_HIERARCHIE_ZU_PER scm
ON wg.mandant_id=scm.mandant_id
AND wg.wg_id=scm.WG_HIERARCHIE_ID
AND scm.ARTHIERTYP_ID=11
WHERE wg.dat_bis='9999-12-31'
AND wg.arthiertyp_id=2
GROUP BY wg.WG_ID,
COALESCE(scm.WG_HIERARCHIE_MUTTER_ID,-1);