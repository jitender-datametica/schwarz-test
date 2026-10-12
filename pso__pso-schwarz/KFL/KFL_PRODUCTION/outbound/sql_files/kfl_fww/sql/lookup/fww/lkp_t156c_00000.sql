SELECT
    land,
    lbbsa,
    sobkz,
    xumlme,
    xtrame,
    xumlmc
FROM dbp_etl.t156c
GROUP BY
    land,
    lbbsa,
    sobkz,
    xumlme,
    xtrame,
    xumlmc;
