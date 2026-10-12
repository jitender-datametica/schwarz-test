--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.BAKE_FINAL_DE_2' does not exist or not authorized.
SELECT mandant_id,
       art_id,
       bestell_art_id,
       inhalt_menge,
       back_aufbereitung_id,
       back_hinweis_id,
       back_programm_id,
       blechbelegung,
       the_type as oventype,
       ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY 1) AS zeile
FROM  DBP_ETL.bake_final_de_2
WHERE klart = 'Z01' AND
      mandant_id = 1
;

