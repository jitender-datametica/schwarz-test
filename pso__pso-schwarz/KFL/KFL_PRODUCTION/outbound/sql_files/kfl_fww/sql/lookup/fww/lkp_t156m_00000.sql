SELECT
    land,
    bustm,
    zustd,
    cnt02,
    lbbsa
FROM dbp_etl.t156m
GROUP BY
    land,
    bustm,
    zustd,
    cnt02,
    lbbsa;
