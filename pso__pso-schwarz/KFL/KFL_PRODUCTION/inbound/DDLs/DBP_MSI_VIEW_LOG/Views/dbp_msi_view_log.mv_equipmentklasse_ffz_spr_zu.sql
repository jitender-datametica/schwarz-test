CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_EQUIPMENTKLASSE_FFZ_SPR_ZU(
	EQUIPMENTKLASSE_FFZ_ID,
	EQUIPMENTKLASSE_FFZ_BEZ
) AS
--AP0133256_SPEC0166769, dknop, initial

SELECT 
 tp_merkmalart_id AS equipmentklasse_ffz_id
--,mandant_id
,MAX(tp_merkmalart_bez) AS equipmentklasse_ffz_bez 
FROM dbp_view.v_tp_merkmalart_spr_zu WHERE ( mandant_id, tp_merkmal_id)
IN (SELECT mandant_id
        ,tp_merkmal_id  FROM dbp_view.v_l_tp_merkmal WHERE tp_merkmal_sap_id = 'FFZ-TYP') 
AND spr_id = 22
GROUP BY tp_merkmalart_id
--,mandant_id
--,tp_merkmalart_bez
 --for some reason only DE texts are maintained even in KMO SAP
UNION
SELECT
 -1 AS equipmentklasse_ffz_id
 --,mandant_id
, 'kein FFZ' AS equipmentklasse_ffz_bez 
--FROM dbp_view.v_mandant
;