--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT
   mandant_id
  ,eigenmarke_id
  ,spr_id
FROM DBP_DATA.artkz_eigenmarke_2
ORDER BY 
   mandant_id
  ,eigenmarke_id
  ,spr_id;

