--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TABLE dbp_etl.wupcal_bonanzahl_tmp_2 AS
(
    SELECT *
    FROM dbp_data.wupcal_2
    LIMIT 0
);


--translated statement


-- 1031123
INSERT INTO dbp_etl.wupcal_bonanzahl_tmp_2 (
    mandant_id, wup_id, nb_id, dat, offen, werbewoche,
    datenlieferung_artbew_wg_sum,
    datenlieferung_bonanzahl,
    datenlieferung_misvier,
    datenlieferung_artbew,
    datenlieferung_qbm_status, bonanzahl, bonanzahl_misvier
)
(
    SELECT
        dt1.mandant_id AS `_mandant_id`,
        dt1.wup_id AS `_wup_id`,
        dt1.nb_id AS `_nb_id`,
        dt1.dat_missing AS `_dat`,
        1 AS `_offen`,
        0 AS `_werbewoche`,
        0 AS `_datenlieferung_artbew_wg_sum`,
        0 AS `_datenlieferung_bonanzahl`,
        0 AS `_datenlieferung_misvier`,
        0 AS `_datenlieferung_artbew`,
        0 AS `_datenlieferung_qbm_status`,
        CAST(CASE
            WHEN WWZP0.umsatz_prz = 0
                THEN 0
            ELSE dt1.source_bonanzahl / WWZP0.umsatz_prz * dt1.umsatz_prz
        END AS INTEGER) AS `_bonanzahl`,
        0 AS `_bonanzahl_misvier`
    FROM (SELECT
        t2.mandant_id,
        t2.wup_id,
        t2.nb_id,
        t2.dat_missing,
        t2.missing_bonanzahl,
        t2.source_bonanzahl,
        t2.umsatz_prz,
        t2.dat_source
    FROM (
        SELECT
            W1.mandant_id,
            W1.wup_id,
            W1.nb_id,
            W1.dat AS dat_missing,
            W1.bonanzahl AS missing_bonanzahl,
            W2.bonanzahl AS source_bonanzahl,
            WWZP.umsatz_prz,
            W2.dat AS dat_source,
            W1.dat,
            W2.dat AS dat0
        FROM dbp_data.wupcal_2 AS W1
        INNER JOIN
            dbp_data.wupcal_2 AS W2
            ON
                W1.mandant_id = W2.mandant_id
                AND W1.wup_id = W2.wup_id
                AND W1.nb_id = W2.nb_id
        INNER JOIN
            dbp_data.tag_2 AS T1_2
            ON
                W1.dat = T1.dat
                AND T1.dat < CURRENT_DATE("Europe/Berlin")
                AND T1.dat > PARSE_DATE('%F', '2003-11-23')
        INNER JOIN
            dbp_data.wup_wotag_zu_per_2 AS WWZP
            ON
                W1.mandant_id = WWZP.mandant_id
                AND W1.wup_id = WWZP.wup_id
                AND W1.nb_id = WWZP.nb_id
                AND T1.wtag_id = WWZP.wtag_id
        WHERE
            W2.bonanzahl <> 0
            AND W2.dat < W1.dat
            AND W1.datenlieferung_bonanzahl IN (0, 2)
            AND W1.offen = 1
            AND W1.nb_id IN (0)
            AND WWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
        -- QUALIFY CSUM(1, w2.dat desc) = 1
        QUALIFY
            (
                ROW_NUMBER()
                    OVER (
                        PARTITION BY W1.mandant_id, W1.wup_id, W1.nb_id, W1.dat
                        ORDER BY dat0 IS NULL DESC, dat0 DESC
                    )
            )
            = 1
    -- GROUP BY 1,2,3,4
    ) AS t2) AS dt1
    INNER JOIN
        dbp_data.tag_2 AS T2
        ON dt1.dat_source = T2.dat AND T2.dat < CURRENT_DATE("Europe/Berlin")
    INNER JOIN
        dbp_data.wup_wotag_zu_per_2 AS WWZP0
        ON
            dt1.mandant_id = WWZP0.mandant_id
            AND dt1.wup_id = WWZP0.wup_id
            AND dt1.nb_id = WWZP0.nb_id
            AND T2.wtag_id = WWZP0.wtag_id
            AND WWZP0.dat_bis = PARSE_DATE('%F', '9999-12-31')
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.wupcal_bonanzahl_tmp_2
WHERE (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_data.wupcal_2
    WHERE
        datenlieferung_bonanzahl = 1
        AND bonanzahl <> 0
);


/*disabled SPEC0164039*/

-- Umsatzkalk. check

/*UPDATE KFL_PRODUCTION.DBP_DATA.wupcal_2

SET
      bonanzahl = _bonanzahl
    , datenlieferung_bonanzahl = 2

FROM
(
  SELECT
     mandant_id   AS _mandant_id
   , wup_id       AS _wup_id
   , nb_id        AS _nb_id
   , dat          AS _dat
   , bonanzahl    AS _bonanzahl
  FROM KFL_PRODUCTION.DBP_ETL.wupcal_bonanzahl_tmp_2 k
)
    ums_dt  WHERE mandant_id  = _mandant_id
  AND wup_id      = _wup_id
  AND nb_id       = _nb_id
  AND dat         = _dat
  AND datenlieferung_bonanzahl IN (0,2)

*/


INSERT INTO dbp_etl_process.kundenanz_agg_wt_2 (
    mandant_id, wup_id, nb_id, dat, calc_fg, dat_lief
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        1 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.wupcal_bonanzahl_tmp_2
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        calc_fg,
        dat_lief
);
