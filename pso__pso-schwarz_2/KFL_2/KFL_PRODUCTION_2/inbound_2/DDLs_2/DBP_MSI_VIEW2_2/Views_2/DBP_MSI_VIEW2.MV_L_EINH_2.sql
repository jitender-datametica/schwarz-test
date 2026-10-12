CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_EINH_2
--24.07.2020 lsvi0303 AP0055938, SPEC0083417 Neue Attribut fuer feld art.einh_id
(mandant_id
,einh_id
)
AS 
SELECT DISTINCT
mandant_id
,einh_id
FROM dbp_view.v_l_einh_2
WHERE mandant_id=1

UNION ALL 

SELECT DISTINCT
mandant_id
,' ' as einh_id
FROM dbp_view.v_l_einh_2
WHERE mandant_id=1;