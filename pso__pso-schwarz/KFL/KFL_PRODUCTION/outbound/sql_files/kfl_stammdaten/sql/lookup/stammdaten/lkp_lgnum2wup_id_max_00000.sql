--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    lagernummer_id,
    MAX(wup_id) AS wup_id,
    MAX(nb_id) AS nb_id
FROM dbp_data.lagernummer_wup_zu
GROUP BY
    mandant_id,
    lagernummer_id;
