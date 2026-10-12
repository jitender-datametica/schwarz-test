SELECT
    land_2,
    lbbsa,
    sobkz,
    xumlme,
    xtrame,
    xumlmc
FROM dbp_etl.t156c_2
GROUP BY
    land_2,
    lbbsa,
    sobkz,
    xumlme,
    xtrame,
    xumlmc;
