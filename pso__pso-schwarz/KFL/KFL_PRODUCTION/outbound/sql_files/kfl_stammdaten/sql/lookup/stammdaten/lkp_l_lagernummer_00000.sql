--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    TRIM(lagernummer_id) AS lagernummer_id,
    wup_id,
    nb_id,
    oug_fg
FROM dbp_data.l_lagernummer;
