CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_L_K_LISTUNG
(
  k_listung
, mandant_id
)
AS
SELECT
CASE WHEN sm_id = - 1 THEN 'N/A' ELSE CAST(sm_id AS VARCHAR(16)) END AS k_listung
, mandant_id
  
FROM dbp_view.v_sm

WHERE mandant_id = 1
AND sm_id <> -9 AND sm_id <6;