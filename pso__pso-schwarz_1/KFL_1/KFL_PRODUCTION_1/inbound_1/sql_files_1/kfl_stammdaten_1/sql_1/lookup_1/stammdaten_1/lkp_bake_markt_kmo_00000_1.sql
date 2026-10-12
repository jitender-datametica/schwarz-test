--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id,
       wup_id,
       nb_id,
       oventype,
       dat_von,
       dat_bis,
       anz_blech,
       anz_ofen,
       gp_backen_bez,
       ROW_NUMBER() OVER (PARTITION BY nb_id ORDER BY nb_id) AS zeile
FROM  DBP_ETL.bake_final_1
WHERE klart = 'Z30' AND
      mandant_id > 1
;

