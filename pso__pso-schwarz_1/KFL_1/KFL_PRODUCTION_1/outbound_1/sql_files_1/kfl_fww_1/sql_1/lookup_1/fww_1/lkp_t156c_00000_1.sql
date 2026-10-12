SELECT
    land_1,
    lbbsa,
    sobkz,
    xumlme,
    xtrame,
    xumlmc
FROM dbp_etl.t156c_1
GROUP BY
    land_1,
    lbbsa,
    sobkz,
    xumlme,
    xtrame,
    xumlmc;
