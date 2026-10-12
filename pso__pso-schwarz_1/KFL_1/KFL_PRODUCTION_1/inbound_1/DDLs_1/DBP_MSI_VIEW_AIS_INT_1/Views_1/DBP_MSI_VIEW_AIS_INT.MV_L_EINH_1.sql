CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_EINH_1
--24.07.2020 lsvi0303 AP0055938, SPEC0083417 Neue Attribut fuer feld art.einh_id
(
  einh_id
, mandant_id

)
AS 
SELECT
  einh_id
, mandant_id

FROM dbp_view.v_l_einh_1

UNION ALL

SELECT DISTINCT
  ' ' as einh_id
, mandant_id

FROM dbp_view.v_l_einh_1;