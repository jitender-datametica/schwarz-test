CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WG_WUP_SM_ZU_PER_2(
MANDANT_ID,
WUP_ID,
MATKL,
NB_ID,
DAT_VON,
ARTHIERTYP_ID,
DAT_BIS,
SM_ID
) AS 
--11.06.2024, SPEC0255380, prescherad, Neualange 
SELECT
  mandant_id
, wup_id
, wg_id AS MATKL
, nb_id
, dat_von
, arthiertyp_id
, dat_bis
, CAST(TRIM(CASE 
              WHEN sm_id::VARCHAR(2) IS NULL THEN ksm_id::VARCHAR(2)
              WHEN ksm_id::VARCHAR(2) IS NULL THEN sm_id::VARCHAR(2)
            END) AS VARCHAR(2)) AS sm_id
FROM dbp_view.v_sm_wup_wg_zu_per_2
WHERE arthiertyp_id = 2
AND dat_bis = '9999-12-31';