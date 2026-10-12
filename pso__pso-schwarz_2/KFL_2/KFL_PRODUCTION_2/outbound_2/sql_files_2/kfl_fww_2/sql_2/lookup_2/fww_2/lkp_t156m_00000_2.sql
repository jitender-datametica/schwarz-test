SELECT
    land_2,
    bustm,
    zustd,
    cnt02,
    lbbsa
FROM dbp_etl.t156m_2
GROUP BY
    land_2,
    bustm,
    zustd,
    cnt02,
    lbbsa;
