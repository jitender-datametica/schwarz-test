--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT 
   mandant_id
  ,spr_id 
  ,sortimentslistenart_id
FROM DBP_DATA.sortimentslistenart_spr_zu
ORDER BY 
   mandant_id
  ,spr_id
  ,sortimentslistenart_id;

