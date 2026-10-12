CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_KAUFLAND_STORE_MO_SUM(
MANDANT_ID,
WUP_ID,
NB_ID,
KJMO,
KFL_REVIEW_ANZ,
KFL_REVIEW_SUM
) AS

	--KMR Google : Kaufland Bewertungen (monatlicher Snapshot)
	--2024-02-14 : Initial [AP0203615]
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 mo.MANDANT_ID
 , wup.aktuell_wup_id 													AS wup_id
 , mo.NB_ID
 , mo.KJMO
 , mo.ANZ_REVIEW_RATING 												AS KFL_REVIEW_ANZ
 , mo.SUM_REVIEW_RATING 												AS KFL_REVIEW_SUM
FROM DBP_MSI_DATA.KFL_RETAIL_STORE_MO_SUM mo

INNER JOIN dbp_view.v_wup wup
ON mo.mandant_id = wup.mandant_id AND mo.wup_id = wup.wup_id
;