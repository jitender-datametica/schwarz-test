--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id, kl_art_id , art_id, wg_art_fg, best_menge_einh_id, basismenge_einh_id, mwst_id, artikelart_id
  FROM DBP_DATA.art_1  
WHERE (mandant_id, kl_art_id , art_id) IN 
  (
    SELECT
       mandant_id
      ,kl_art_id	
      ,MAX(art_id) 
    FROM DBP_DATA.art_1 
    GROUP BY 
       mandant_id
      ,kl_art_id
  );

