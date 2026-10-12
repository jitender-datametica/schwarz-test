CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_WG_WUP_SM_ZU_PER
-- 29.07.2020 NSR1559407 Attribut Sortimentskategorie anpassen
(
  mandant_id
, wup_id
, wg_id
, nb_id
, dat_von
, arthiertyp_id
, dat_bis
, sm_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS 
SELECT
  mandant_id
, wup_id
, wg_id
, nb_id
, dat_von
, arthiertyp_id
, dat_bis
, CAST(TRIM(CASE 
              WHEN sm_id::VARCHAR(2) IS NULL THEN ksm_id::VARCHAR(2)
              WHEN ksm_id::VARCHAR(2) IS NULL THEN sm_id::VARCHAR(2)
            END) AS VARCHAR(2)) AS sm_id
FROM dbp_view.v_sm_wup_wg_zu_per
WHERE arthiertyp_id = 2
AND dat_bis = '9999-12-31';