--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT 
  CASE WHEN mandant_kbez='D' THEN 'DE' ELSE mandant_kbez END lkz_iso
  ,t1.mandant_id
  ,t2.spr_id 
  ,t3.sap_spr_id
  ,t4.sap_spr_id AS sap_spr_id_de
  ,t1.default_wrg
FROM DBP_DATA.mandant_1 t1_1

INNER JOIN DBP_DATA.mandant_spr_zu_1 t2
ON t1.mandant_id = t2.mandant_id

INNER JOIN DBP_DATA.sap_dwh_spr_zu_1 t3
ON t2.spr_id = t3.spr_id

INNER JOIN DBP_DATA.sap_dwh_spr_zu_1 t4
ON t4.spr_id = 22;

