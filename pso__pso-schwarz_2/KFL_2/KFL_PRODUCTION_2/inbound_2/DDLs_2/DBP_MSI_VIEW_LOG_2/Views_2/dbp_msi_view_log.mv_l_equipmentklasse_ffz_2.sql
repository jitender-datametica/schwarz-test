CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_EQUIPMENTKLASSE_FFZ_2(
	MANDANT_ID,
	TP_OBJECT_ID,
	EQUIPMENTKLASSE_FFZ_ID
) AS
--AP0133256_SPEC0166769, dknop, initial
--AP0133256_SPEC0166769, dknop, correcting issues in joins to v_l_tp_merkmal_2 and v_l_tp_merkmalart_2
SELECT 
 t0.mandant_id
,t0.tp_objekt_id
,COALESCE(t1.tp_merkmalart_id,-1) AS equipmentklasse_ffz_id

FROM dbp_view.v_tp_objekt_per_2 t0
LEFT JOIN ( SELECT 
 t00.mandant_id
,t00.tp_objekt_id
,t01.tp_merkmalart_id 
FROM dbp_view.v_tp_objekt_merkmal_2 t00
JOIN dbp_view.v_tp_merkmalart_spr_zu_2 t01 
ON t00.mandant_id=t01.mandant_id
AND t00.tp_merkmal_id=t01.tp_merkmal_id
AND t01.spr_id=22 
JOIN dbp_view.v_l_tp_merkmal_2 t02 
ON t00.mandant_id=t02.mandant_id 
AND t00.tp_merkmal_id=t02.tp_merkmal_id
AND t02.tp_merkmal_sap_id = 'FFZ-TYP'
JOIN  dbp_view.v_l_tp_merkmalart_2 t03 
ON t00.mandant_id=t03.mandant_id 
AND t00.tp_merkmal_id =t03.tp_merkmal_id
AND t02.tp_merkmal_klasse_id=t03.tp_merkmal_klasse_id 
AND t00.tp_merkmalwert=t03.tp_merkmalwert_ID
AND t01.tp_merkmalart_id=t03.tp_merkmalart_id) t1_2

ON t0.mandant_id=t1.mandant_id
AND t0.tp_objekt_id=t1.tp_objekt_id
WHERE t0.dat_bis='9999-12-31'
--and t0.tp_objekt_id=10195511
;