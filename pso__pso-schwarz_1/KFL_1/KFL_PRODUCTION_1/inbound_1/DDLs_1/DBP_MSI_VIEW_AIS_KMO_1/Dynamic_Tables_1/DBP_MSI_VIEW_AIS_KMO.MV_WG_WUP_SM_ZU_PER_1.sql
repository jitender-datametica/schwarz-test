CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_WG_WUP_SM_ZU_PER_1
-- SPEC0066356 Erweiterung um ksm_id / sschuecke 03.12.2019
-- 08.07.2020 lsvi0303: AP0043104, SPEC0069749 Attribut Sortimentskategorie/K-Sortimentskategorie anpassen
(
  mandant_id
, wup_id
, wg_id
, nb_id
, dat_von
, arthiertyp_id
, dat_bis
, sm_id
, ksm_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
SELECT
     mandant_id
    ,wup_id
    ,wg_id
    ,nb_id
    ,dat_von
    ,arthiertyp_id
    ,dat_bis
    ,CASE 
        WHEN sm_id  IS NULL THEN CAST(TRIM(ksm_id) AS VARCHAR(2))
        WHEN ksm_id IS NULL THEN CAST(TRIM(sm_id) AS VARCHAR(2))
     END AS sm_id
    ,ksm_id
FROM dbp_view.v_sm_wup_wg_zu_per_1
WHERE mandant_id <> 1 
  AND arthiertyp_id = 2
  AND dat_bis = '9999-12-31'
ORDER BY wup_id, wg_id, nb_id, dat_von, dat_bis;