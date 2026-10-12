--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT
mandant_id
,ereignis_id
,sap_ereignis_id
,ereignistyp_id
,default_offen
FROM DBP_DATA.ereignis_1 WHERE NOT sap_ereignis_id IS NULL;

