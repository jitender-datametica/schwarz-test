--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    CASE
        WHEN mandant_kbez = 'D'
            THEN 'DE'
        ELSE mandant_kbez
    END AS land_id,
    mandant_id
FROM dbp_data.mandant_1;
