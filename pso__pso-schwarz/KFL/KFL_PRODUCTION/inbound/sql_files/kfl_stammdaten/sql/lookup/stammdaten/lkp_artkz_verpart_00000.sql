--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT
   mandant_id
  ,TRIM(verpart_id) as verpart_id
FROM DBP_DATA.artkz_verpart
ORDER BY 
   mandant_id
  ,verpart_id;

