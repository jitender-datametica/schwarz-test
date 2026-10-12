--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    art_id,
    bestell_art_id,
    inhalt_menge,
    back_aufbereitung_id,
    back_hinweis_id,
    back_programm_id,
    blechbelegung,
    the_type AS oventype,
    ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY 1 IS NULL, 1) AS zeile
FROM dbp_etl.bake_final_2
WHERE
    klart = 'Z01'
    AND mandant_id > 1;
