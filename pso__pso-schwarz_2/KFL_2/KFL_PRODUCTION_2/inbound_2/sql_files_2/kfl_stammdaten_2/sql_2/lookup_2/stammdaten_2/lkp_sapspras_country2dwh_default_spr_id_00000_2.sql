--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT
	CASE WHEN t3.mandant_id=1 THEN 'DE' ELSE t3.mandant_kbez END countrycode
	,t2.sap_spr_id
	,t3.mandant_id
	, t2.spr_id
FROM DBP_DATA.mandant_spr_zu_2 t1_2
INNER JOIN DBP_DATA.sap_dwh_spr_zu_2 t2
	ON t1.spr_id=t2.spr_id
INNER JOIN DBP_DATA.mandant_2 t3
	ON t3.mandant_id=t1.mandant_id
	OR (t3.mandant_id<>1 AND t1.spr_id=22);

