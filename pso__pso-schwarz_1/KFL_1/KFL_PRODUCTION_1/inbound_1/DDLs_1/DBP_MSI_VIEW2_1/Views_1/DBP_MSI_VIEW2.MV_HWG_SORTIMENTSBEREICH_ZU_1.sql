CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_HWG_SORTIMENTSBEREICH_ZU_1(
	HWG_ID,
	MANDANT_ID,
	SORTIMENTSBEREICH_ID
) AS
--2024-03-22, AP0212955, SPEC0242926, dknop, initial
SELECT
hwg.hwg_id
,hwg.mandant_id
,COALESCE(scm.WG_HIERARCHIE_MUTTER_ID,-1) AS sortimentsbereich_id
FROM  dbp_view.v_hwg_per_1 hwg
LEFT JOIN  dbp_view.v_WG_HIERARCHIE_ZU_PER_1 scm
ON hwg.mandant_id=scm.mandant_id
AND hwg.hwg_id=scm.WG_HIERARCHIE_ID
AND scm.ARTHIERTYP_ID=13
WHERE hwg.dat_bis='9999-12-31'
AND hwg.arthiertyp_id=2
GROUP BY hwg.hWG_ID,hwg.mandant_id,COALESCE(scm.WG_HIERARCHIE_MUTTER_ID,-1) ;