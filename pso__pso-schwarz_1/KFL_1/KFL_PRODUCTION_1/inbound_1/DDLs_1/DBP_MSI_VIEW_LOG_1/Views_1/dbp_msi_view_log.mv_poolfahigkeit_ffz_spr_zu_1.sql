CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_POOLFAHIGKEIT_FFZ_SPR_ZU_1(
	POOLFAHIGKEIT_FFZ_ID,
	MANDANT_ID,
	POOLFAHIGKEIT_FFZ_BEZ
) AS
--AP0133256_SPEC0166769, dknop, initial

SELECT 
 tp_merkmalart_id AS poolfahigkeit_ffz_id
,mandant_id
,tp_merkmalart_bez AS poolfahigkeit_ffz_bez 
FROM dbp_view.v_tp_merkmalart_spr_zu_1 WHERE ( mandant_id, tp_merkmal_id)
IN (SELECT mandant_id
        ,tp_merkmal_id  FROM dbp_view.v_l_tp_merkmal_1 WHERE tp_merkmal_sap_id = 'FFZ-POOLFAEHIG') 
AND spr_id = 22
GROUP BY tp_merkmalart_id
,mandant_id
,tp_merkmalart_bez
 --for some reason only DE texts are maintained even in KMO SAP
UNION
SELECT
 -1 AS equipmentklasse_ffz_id
,mandant_id
, 'keine Angabe' AS equipmentklasse_ffz_bez 
FROM dbp_view.v_mandant_1
;