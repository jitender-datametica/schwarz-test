--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT 
   sap_spr_id, s.spr_id, mandant_id
FROM 
( 
  SELECT sap_spr_id, 
     MAX(spr_id) AS spr_id 
  FROM DBP_DATA.sap_dwh_spr_zu 
  WHERE mandant_id=1 
  GROUP BY 1
) s

LEFT OUTER JOIN DBP_DATA.mandant_spr_zu m
ON s.spr_id = m.spr_id;

