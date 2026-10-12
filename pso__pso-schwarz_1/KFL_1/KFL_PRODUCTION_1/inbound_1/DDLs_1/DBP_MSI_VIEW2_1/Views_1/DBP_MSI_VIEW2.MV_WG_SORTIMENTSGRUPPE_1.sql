CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WG_SORTIMENTSGRUPPE_1(
	WG_ID,
	MANDANT_ID,
	SORTIMENTSGRUPPE_ID
) AS
--2023-12-19, AP0182383, SPEC0207712, dknop, initial
SELECT
 wg.wg_id
,wg.mandant_id 
,COALESCE(scm.WG_HIERARCHIE_MUTTER_ID,-1) AS sortimentsgruppe_id
FROM dbp_view.v_wg_per_1 wg
LEFT JOIN dbp_view.v_WG_HIERARCHIE_ZU_PER_1 scm
ON wg.mandant_id=scm.mandant_id
AND wg.wg_id=scm.WG_HIERARCHIE_ID
AND scm.ARTHIERTYP_ID=11
WHERE wg.dat_bis='9999-12-31'
AND wg.arthiertyp_id=2
GROUP BY wg.WG_ID,wg.mandant_id,
COALESCE(scm.WG_HIERARCHIE_MUTTER_ID,-1);