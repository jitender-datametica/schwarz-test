--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.l_kjmo_sort_2 (mandant_id,
                                                kjmo,
                                                kjwo_update)
SELECT mandant_id,
       kjmo,
       kjwo_update
FROM DBP_DATA.sortiment_leistung_2
WHERE (mandant_id,kjmo,kjwo_update) NOT IN (SELECT mandant_id,kjmo,kjwo_update FROM DBP_DATA.l_kjmo_sort_2)
GROUP BY 1,2,3
;
