--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT
   mandant_id
  ,wg_id
  ,wug_id
  ,arthiertyp_id
FROM DBP_DATA.wug
ORDER BY 
   mandant_id
  ,wg_id
  ,wug_id
  ,arthiertyp_id;

