SELECT
    land_1,
    bustm,
    zustd,
    cnt02,
    lbbsa
FROM dbp_etl.t156m_1
GROUP BY
    land_1,
    bustm,
    zustd,
    cnt02,
    lbbsa;
