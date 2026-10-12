--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_data.art_vw_erst_we_1;


-- Workaround 2011.03.13 --- David Bandeira
-- INNER JOIN KFL_PRODUCTION.DBP_DATA.bsch_rech v02

-- v01.bsch_id=v02.bsch_id
-- ON
INSERT INTO dbp_data.art_vw_erst_we_1
(
    SELECT
        art_id,
        COALESCE(vw_id, -1),
        mandant_id,
        MIN(dat_erst_we),
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM ((
        SELECT
            V02.art_id,
            V03.vw_id,
            V02.mandant_id,
            MIN(V01.dat_faktura) AS dat_erst_we
        FROM dbp_data.besch_faktura_1 AS V01
        INNER JOIN
            dbp_data.besch_faktura_det_1 AS V02
            ON V01.faktura_beleg_id = V02.faktura_beleg_id
        INNER JOIN dbp_data.wup_1 AS V03
            ON COALESCE(
                ROUND(SAFE_CAST(V01.auftraggeber_id AS BIGNUMERIC), 0),
                -1
            ) = V03.wup_id AND V03.mandant_id = 1 AND V03.nb_id = 0
        WHERE V01.auftraggeber_id BETWEEN '0000001000' AND '0000009999'
        GROUP BY
            V02.mandant_id,
            V02.art_id,
            V03.vw_id
        UNION DISTINCT
        SELECT
            V01.art_id,
            V02.vw_id,
            V01.mandant_id,
            MIN(V01.dat_faktura) AS dat_erst_we
        FROM dbp_data.besch_faktura_medata_1 AS V01
        INNER JOIN dbp_data.wup_1 AS V02
            ON
                V01.faktura_markt = V02.wup_id
                AND V02.mandant_id = 1
                AND V02.nb_id
                = 0
        GROUP BY
            V01.art_id,
            V01.mandant_id,
            V02.vw_id
    )
    UNION DISTINCT
    SELECT
        V01.art_id,
        V03.vw_id,
        V01.mandant_id,
        MIN(V01.dat) AS dat_erst_we
    FROM dbp_data.bsch_rech_det_1 AS V01
    INNER JOIN dbp_data.wup_1 AS V03 ON V01.wup_id = V03.wup_id
        WHERE V01.nb_id = 0
        GROUP BY
            V01.mandant_id,
            V01.art_id,
            V03.vw_id
    ) AS a
    GROUP BY
        art_id,
        COALESCE(vw_id, -1),
        mandant_id
);
