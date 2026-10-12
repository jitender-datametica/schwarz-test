CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_PM_VW_AKT_1
(
	ART_ID,
	MANDANT_ID,
	VKPK1,
	VKPK10,
	VKPK4
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
art_id,
mandant_id,
MAX(vkpk1)  AS VKPK1,
MAX(vkpk10) AS VKPK10,
MAX(vkpk4)  AS VKPK4
FROM
(
SELECT
 art_id
,mandant_id
--AP0239305/SPEC0282069 ssch1303 22.11.2024
,MAX(CASE WHEN pm_id = 1  THEN vk_brutto END) AS VKPK1
,MAX(CASE WHEN pm_id = 10 THEN vk_brutto END) AS VKPK10
,MAX(CASE WHEN pm_id = 4  THEN vk_brutto END) AS VKPK4
,dat_von
,ROW_NUMBER() OVER (PARTITION BY art_id ORDER BY dat_von DESC) AS rn
FROM dbp_view.v_ART_PM_VW_ZU_PER_1
WHERE mandant_id = 1
AND dat_von <= CURRENT_DATE
AND dat_bis >= CURRENT_DATE
AND pm_id IN (1,4,10)
AND preistyp_id = 0
GROUP BY art_id, mandant_id, dat_von)

GROUP BY
 art_id
,mandant_id;
