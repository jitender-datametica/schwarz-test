--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.bestand_mardh_mard_vz_tmp1_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.bestand_mardh_mard_vz_tmp2_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.bestand_mardh_mard_vz_tmp3_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.bestand_mardh_mard_vz_tmp1_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    dat DATE NOT NULL,
    gjmo INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.bestand_mardh_mard_vz_tmp2_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_umlag_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_nf_charge_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    menge_lgbest_erp_ret_gesp_bme NUMERIC(29, 3)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.bestand_mardh_mard_vz_tmp3_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo_ziel INTEGER NOT NULL,
    gjmo_load INTEGER NOT NULL,
    gjmo_bis_ziel INTEGER NOT NULL,
    gjmo_bis_ziel_neu INTEGER NOT NULL,
    gjmo_bis_neu INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    mard_fg INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_umlag_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_nf_charge_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    menge_lgbest_erp_ret_gesp_bme NUMERIC(29, 3)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- ,t.gjmo
INSERT INTO dbp_etl.bestand_mardh_mard_vz_tmp1_2 (
    art_id, mandant_id, wup_id, nb_id,
    lagerort_id, dat, gjmo
)
(
    SELECT
        L.art_id,
        L.mandant_id,
        L.wup_id,
        L.nb_id,
        L.lagerort_id,
        MAX(L.dat),
        CAST(ROUND(CAST(TRIM(SUBSTR(CAST(SPKZ.sap_buchungs_jahr AS STRING), 1, 10)) || CASE
            WHEN CAST(TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10)) AS FLOAT64) <= 9
                THEN '0' || TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10))
            ELSE TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10))
        END AS BIGNUMERIC), 0) AS INTEGER) AS gjmo_
    FROM dbp_etl.bestand_mardh_mard_vz_log_2 AS L
    INNER JOIN dbp_data.tag_2 AS T ON L.dat = T.dat
    INNER JOIN dbp_data.sap_periode_kalender_zu_2 AS SPKZ
        ON
            L.mandant_id = SPKZ.mandant_id AND T.kjmo = SPKZ.kjmo AND SPKZ.krk_id IN ('DE01', 'CZ01', 'SK01', 'HR01', 'PL01', 'RO01', 'BG01') AND SPKZ.buchungsperiode_id <=
            12
    WHERE L.mandant_id = 1
    GROUP BY
        L.art_id,
        L.mandant_id,
        L.wup_id,
        L.nb_id,
        L.lagerort_id,
        gjmo_
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- Nur Bestaende uebernehmen, die sich geändert haben, unveraenderte Bestaende ausfiltern
INSERT INTO
dbp_etl.bestand_mardh_mard_vz_tmp2_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme
)
(
    SELECT
        L.art_id,
        L.mandant_id,
        L.wup_id,
        L.nb_id,
        BMMT1.gjmo,
        BMMT1.lagerort_id,
        L.menge_lgbest_erp_frei_bme,
        L.menge_lgbest_erp_umlag_bme,
        L.menge_lgbest_erp_qual_bme,
        L.menge_lgbest_erp_nf_charge_bme,
        L.menge_lgbest_erp_gesp_bme,
        L.menge_lgbest_erp_ret_gesp_bme
    FROM dbp_data.lagerbestand_erp_per_2 AS L
    INNER JOIN dbp_etl.bestand_mardh_mard_vz_tmp1_2 AS BMMT1
        ON
            L.art_id = BMMT1.art_id AND L.mandant_id =
            BMMT1.mandant_id AND L.wup_id = BMMT1.wup_id AND L.nb_id = BMMT1.nb_id AND L.lagerort_id = BMMT1.lagerort_id AND
            BMMT1.dat BETWEEN L.dat_von AND L.dat_bis
    QUALIFY (COUNT(*) OVER (PARTITION BY
        L.mandant_id, L.art_id, L.wup_id, L.nb_id, BMMT1.lagerort_id ORDER BY
        BMMT1.gjmo
        IS NULL, BMMT1.gjmo
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 1 OR (
        SUM(L.menge_lgbest_erp_frei_bme)
            OVER (PARTITION BY
                L.mandant_id, L.art_id, L.wup_id, L.nb_id, BMMT1.lagerort_id ORDER BY
                BMMT1.gjmo IS NULL,
                BMMT1.gjmo
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
    ) <> 2.0 * L.menge_lgbest_erp_frei_bme OR (
        SUM(L.menge_lgbest_erp_qual_bme
        ) OVER (PARTITION BY
            L.mandant_id, L.art_id, L.wup_id, L.nb_id, BMMT1.lagerort_id ORDER BY
            BMMT1.gjmo IS NULL,
            BMMT1.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
    ) <> 2.0 * L.menge_lgbest_erp_qual_bme OR (
        SUM(L.menge_lgbest_erp_umlag_bme
        )
            OVER (PARTITION BY
                L.mandant_id, L.art_id, L.wup_id, L.nb_id, BMMT1.lagerort_id ORDER BY
                BMMT1.gjmo IS NULL,
                BMMT1.gjmo
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
    ) <> 2.0 * L.menge_lgbest_erp_umlag_bme OR (
        SUM(L.menge_lgbest_erp_nf_charge_bme
        )
            OVER (PARTITION BY
                L.mandant_id, L.art_id, L.wup_id, L.nb_id, BMMT1.lagerort_id ORDER BY
                BMMT1.gjmo IS NULL,
                BMMT1.gjmo
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
    ) <> 2.0 * L.menge_lgbest_erp_nf_charge_bme OR (
        SUM(L.menge_lgbest_erp_gesp_bme
        )
            OVER (PARTITION BY
                L.mandant_id, L.art_id, L.wup_id, L.nb_id, BMMT1.lagerort_id ORDER BY
                BMMT1.gjmo IS NULL,
                BMMT1.gjmo
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
    ) <> 2.0 * L.menge_lgbest_erp_gesp_bme OR (
        SUM(L.menge_lgbest_erp_ret_gesp_bme
        )
            OVER (PARTITION BY
                L.mandant_id, L.art_id, L.wup_id, L.nb_id, BMMT1.lagerort_id ORDER BY
                BMMT1.gjmo IS NULL,
                BMMT1.gjmo
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
    ) <> 2.0 * L.menge_lgbest_erp_ret_gesp_bme
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_vz_tmp3_2
--(
--   art_id
--  ,mandant_id
--  ,wup_id
--  ,nb_id
--  ,gjmo_ziel
--  ,gjmo_load
--  ,gjmo_bis_ziel
--  ,gjmo_bis_ziel_neu
--  ,gjmo_bis_neu
--  ,lagerort_id
--  ,mard_fg
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_umlag_bme
--  ,menge_lgbest_erp_qual_bme
--  ,menge_lgbest_erp_nf_charge_bme
--  ,menge_lgbest_erp_gesp_bme
--  ,menge_lgbest_erp_ret_gesp_bme
--)
--SELECT
--   m.art_id
--  ,m.mandant_id
--  ,m.wup_id
--  ,m.nb_id
--  ,m.gjmo             AS gjmo_ziel
--  ,tmp2.gjmo          AS gjmo_load
--  ,m.gjmo_bis         AS gjmo_bis_ziel
--  ,MIN (CASE WHEN m.gjmo = tmp2.gjmo
--             THEN 999999   -- Flag, dass nur Mengen upgedatet werden muessen; bewusst ungueltiger Monat_2!!
--             ELSE ADD_MONTHS(CAST( (tmp2.gjmo - 190000) *100 +1 AS DATE), -1) / 100 + 190000
--        END)     OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id)    AS gjmo_bis_ziel_neu
--  ,CASE WHEN COUNT(*) OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id
--                            ORDER BY gjmo_load DESC  ROWS 1 PRECEDING) = 1
--        THEN 999912
--        ELSE ADD_MONTHS(CAST( SUM ((gjmo_load - 190000) *100 +1 )
--                                   OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id
--                                         ORDER BY gjmo_load DESC  ROWS 1 PRECEDING)
--                             -  ((gjmo_load - 190000) *100 +1) AS DATE), -1) / 100 + 190000
--   END                AS gjmo_bis_neu
--  ,m.lagerort_id
--  ,m.mard_fg
--  ,tmp2.menge_lgbest_erp_frei_bme
--  ,tmp2.menge_lgbest_erp_umlag_bme
--  ,tmp2.menge_lgbest_erp_qual_bme
--  ,tmp2.menge_lgbest_erp_nf_charge_bme
--  ,tmp2.menge_lgbest_erp_gesp_bme
--  ,tmp2.menge_lgbest_erp_ret_gesp_bme
--FROM ${DWH_COMMON_DBX_DATA}.bestand_erp_monat_2 m
--   INNER JOIN
--     ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_vz_tmp2_2 tmp2
--   ON  m.mandant_id  = tmp2.mandant_id
--   AND m.art_id      = tmp2.art_id
--   AND m.wup_id      = tmp2.wup_id
--   AND m.nb_id       = tmp2.nb_id
--   AND m.lagerort_id = tmp2.lagerort_id
--   AND tmp2.gjmo BETWEEN m.gjmo AND m.gjmo_bis
--   AND m.mard_fg     = 1
--   AND
--    (   m.menge_lgbest_erp_frei_bme      <> tmp2.menge_lgbest_erp_frei_bme
--     OR m.menge_lgbest_erp_umlag_bme     <> tmp2.menge_lgbest_erp_umlag_bme
--     OR m.menge_lgbest_erp_qual_bme      <> tmp2.menge_lgbest_erp_qual_bme
--     OR m.menge_lgbest_erp_nf_charge_bme <> tmp2.menge_lgbest_erp_nf_charge_bme
--     OR m.menge_lgbest_erp_gesp_bme      <> tmp2.menge_lgbest_erp_gesp_bme
--     OR m.menge_lgbest_erp_ret_gesp_bme  <> tmp2.menge_lgbest_erp_ret_gesp_bme
--    )
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--invalid type [CAST(((TMP2.GJMO \- 190000) * 100) \+ 1 AS DATE)] for parameter 'TO_DATE'
--translated statement


-- Flag, dass nur Mengen upgedatet werden muessen; bewusst ungueltiger Monat_2!!
INSERT INTO dbp_etl.bestand_mardh_mard_vz_tmp3_2
(
    art_id, mandant_id, wup_id, nb_id, gjmo_ziel, gjmo_load, gjmo_bis_ziel, gjmo_bis_ziel_neu, gjmo_bis_neu, lagerort_id,
    mard_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme
)
(
    SELECT
        M.art_id,
        M.mandant_id,
        M.wup_id,
        M.nb_id,
        M.gjmo AS gjmo_ziel,
        TMP2.gjmo AS gjmo_load,
        M.gjmo_bis AS gjmo_bis_ziel,
        CAST(MIN(CASE
            WHEN M.gjmo = TMP2.gjmo
                THEN 999999
            ELSE ROUND(CAST(CAST(IF(PARSE_DATE(
                '%Y%m', CAST(TMP2.gjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', CAST(TMP2.gjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', CAST(TMP2.gjmo as STRING)), INTERVAL -1 MONTH)), DATE_ADD(
                PARSE_DATE('%Y%m', CAST(TMP2.gjmo as STRING)),
                INTERVAL -1 MONTH
            )) AS STRING) AS BIGNUMERIC), 0)
        END) OVER (PARTITION BY M.art_id, M.mandant_id, M.wup_id, M.nb_id, M.lagerort_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS INTEGER) AS gjmo_bis_ziel_neu,
        CAST(CASE
            WHEN (COUNT(*) OVER (PARTITION BY M.art_id, M.mandant_id, M.wup_id, M.nb_id, M.lagerort_id ORDER BY TMP2.gjmo IS NULL DESC, TMP2.gjmo DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 1
                THEN 999912
            ELSE ROUND(CAST(CAST(IF(DATE(CAST(LAG(TMP2.gjmo, 1) OVER (PARTITION BY M.art_id, M.mandant_id, M.wup_id, M.nb_id, M.lagerort_id ORDER BY TMP2.gjmo IS NULL DESC, TMP2.gjmo DESC) as STRING)) = LAST_DAY(DATE(CAST(LAG(TMP2.gjmo, 1) OVER (
                PARTITION BY
                    M.art_id, M.mandant_id, M.wup_id, M.nb_id,
                    M.lagerort_id
                ORDER BY TMP2.gjmo IS NULL DESC, TMP2.gjmo DESC
            ) as STRING))), LAST_DAY(DATE_ADD(DATE(CAST(LAG(
                TMP2.gjmo, 1)
                OVER (PARTITION BY M.art_id, M.mandant_id, M.wup_id, M.nb_id, M.lagerort_id ORDER BY TMP2.gjmo IS NULL DESC, TMP2.gjmo DESC
                )
            as STRING)), INTERVAL -1
            MONTH)), DATE_ADD(DATE(CAST(LAG(TMP2.gjmo, 1) OVER (PARTITION BY M.art_id, M.mandant_id, M.wup_id, M.nb_id, M.lagerort_id ORDER BY TMP2.gjmo IS NULL DESC, TMP2.gjmo DESC) as STRING)), INTERVAL -1 MONTH)) AS STRING) AS BIGNUMERIC), 0)
        END AS INTEGER) AS gjmo_bis_neu,
        M.lagerort_id,
        M.mard_fg,
        TMP2.menge_lgbest_erp_frei_bme,
        TMP2.menge_lgbest_erp_umlag_bme,
        TMP2.menge_lgbest_erp_qual_bme,
        TMP2.menge_lgbest_erp_nf_charge_bme,
        TMP2.menge_lgbest_erp_gesp_bme,
        TMP2.menge_lgbest_erp_ret_gesp_bme
    FROM dbp_data.bestand_erp_monat_2 AS M
    INNER JOIN dbp_etl.bestand_mardh_mard_vz_tmp2_2 AS TMP2
        ON M.mandant_id = TMP2.mandant_id AND M.art_id = TMP2.art_id AND M.wup_id = TMP2.wup_id AND M.nb_id = TMP2.nb_id AND M.lagerort_id = TMP2.lagerort_id AND TMP2.gjmo BETWEEN M.gjmo AND M.gjmo_bis AND M.mard_fg = 1 AND (
            M.menge_lgbest_erp_frei_bme
            <> TMP2.menge_lgbest_erp_frei_bme OR M.menge_lgbest_erp_umlag_bme <> TMP2.menge_lgbest_erp_umlag_bme OR M.menge_lgbest_erp_qual_bme <> TMP2.menge_lgbest_erp_qual_bme OR M.menge_lgbest_erp_nf_charge_bme <> TMP2.menge_lgbest_erp_nf_charge_bme OR M.menge_lgbest_erp_gesp_bme <> TMP2.menge_lgbest_erp_gesp_bme
            OR M.menge_lgbest_erp_ret_gesp_bme <> TMP2.menge_lgbest_erp_ret_gesp_bme
        )
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'ZIEL' does not exist or not authorized.


UPDATE dbp_data.bestand_erp_monat_2 AS ZIEL SET
    menge_lgbest_erp_frei_bme = TMP3.menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme = TMP3.menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme = TMP3.menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme = TMP3.menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme = TMP3.menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme = TMP3.menge_lgbest_erp_ret_gesp_bme FROM
    dbp_etl.bestand_mardh_mard_vz_tmp3_2
        AS TMP3
WHERE
    ZIEL.gjmo = TMP3.gjmo_ziel AND ZIEL.gjmo = TMP3.gjmo_load AND ZIEL.mandant_id = TMP3.mandant_id AND ZIEL.art_id =
    TMP3.art_id AND ZIEL.wup_id = TMP3.wup_id AND ZIEL.nb_id = TMP3.nb_id AND ZIEL.lagerort_id = TMP3.lagerort_id AND
    ZIEL.mard_fg = 1;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'ZIEL' does not exist or not authorized.


UPDATE dbp_data.bestand_erp_monat_2 AS ZIEL SET
    gjmo_bis = tmp3.gjmo_bis_ziel_neu FROM (
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        lagerort_id,
        gjmo_ziel,
        gjmo_bis_ziel_neu
    FROM dbp_etl.bestand_mardh_mard_vz_tmp3_2
    WHERE gjmo_bis_ziel_neu <> 999999
    GROUP BY
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        gjmo_ziel,
        gjmo_bis_ziel_neu,
        lagerort_id
) AS tmp3
WHERE
    ZIEL.gjmo = tmp3.gjmo_ziel AND ZIEL.mandant_id = tmp3.mandant_id AND ZIEL.art_id = tmp3.art_id AND ZIEL.wup_id =
    tmp3.wup_id AND ZIEL.nb_id = tmp3.nb_id AND ZIEL.lagerort_id = tmp3.lagerort_id AND ZIEL.mard_fg = 1;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.bestand_erp_monat_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, gjmo_bis, mard_fg
)
(
    SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        gjmo_load,
        lagerort_id,
        menge_lgbest_erp_frei_bme,
        menge_lgbest_erp_umlag_bme,
        menge_lgbest_erp_qual_bme,
        menge_lgbest_erp_nf_charge_bme,
        menge_lgbest_erp_gesp_bme,
        menge_lgbest_erp_ret_gesp_bme,
        gjmo_bis_neu,
        mard_fg
    FROM dbp_etl.bestand_mardh_mard_vz_tmp3_2
    WHERE
        gjmo_ziel <> gjmo_load
        AND gjmo_bis_ziel_neu <> 999999
);


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.bestand_mardh_mard_vz_log_2;
