--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)


CREATE OR REPLACE TABLE dbp_etl.`_zeitraum_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    dat,
    kjmo
FROM dbp_data.tag_1 AS A
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_data.tag_1
    WHERE akt_mo = -1 * ${MONAT_1}) AND (
    SELECT MAX(dat)
    FROM dbp_data.tag_1
    WHERE akt_mo = -1 * ${MONAT_1}
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW_1' does not exist or not authorized.


DELETE FROM dbp_etl_process.ekc_artbew_1
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_etl.`_zeitraum_${TRANSIENT_TABLE_SUFFIX}`) AND (
    SELECT MAX(dat)
    FROM dbp_etl.`_zeitraum_${TRANSIENT_TABLE_SUFFIX}`
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW_KMEP_1' does not exist or not authorized.


INSERT INTO dbp_etl_process.ekc_artbew_1 (
    mandant_id, art_id, bewart_id, wup_id, nb_id, dat, umsatz_netto_,
    logkostenzuschlag, ek_mep_einstandspreis_, menge_, bonus_stk_, bonus_stk_kw_, bonus_stk_ww_, ek_mep_einstandspreis__,
    wa_kalk_kw_, wa_kalk_ww_
)
(
    SELECT
        a.mandant_id,
        a.art_id,
        a.bewart_id,
        a.wup_id,
        a.nb_id,
        a.dat,
        SUM(a.umsatz_netto) AS umsatz_netto_,
        SUM(a.logkostenzuschlag) AS logkostenzuschlag,
        SUM(a.ek_mep_einstandspreis) AS ek_mep_einstandspreis_,
        SUM(a.menge) AS menge_,
        CAST(SUM(COALESCE(b.bonus_stk, 0)) AS FLOAT64) AS bonus_stk_,
        CAST(SUM(COALESCE(c.bonus_stk, 0)) AS FLOAT64) AS bonus_stk_kw_,
        CAST(SUM(COALESCE(d.bonus_stk, 0)) AS FLOAT64) AS bonus_stk_ww_,
        CAST(
            SUM(a.umsatz_netto) - SUM(a.ek_mep_einstandspreis) + SUM(a.menge) * SUM(COALESCE(b.bonus_stk, 0)) AS FLOAT64) AS
        ek_mep_einstandspreis__,
        CAST(
            SUM(a.umsatz_netto) - SUM(a.ek_mep_einstandspreis) + SUM(a.menge) * SUM(COALESCE(c.bonus_stk, 0)) AS FLOAT64) AS
        wa_kalk_kw_,
        CAST(SUM(a.umsatz_netto) - SUM(a.ek_mep_einstandspreis) + SUM(a.menge) * SUM(COALESCE(d.bonus_stk, 0)) AS FLOAT64)
            AS
            wa_kalk_ww_
    FROM (
        SELECT
            mandant_id,
            art_id,
            bewart_id,
            wup_id,
            nb_id,
            dat,
            SUM(umsatz_netto) AS umsatz_netto,
            SUM(logkostenzuschlag) AS logkostenzuschlag,
            SUM(CASE
                WHEN mandant_id = 1
                    THEN CAST(ek_mep AS NUMERIC)
                ELSE COALESCE(ek_gld, 0)
            END) AS ek_mep_einstandspreis,
            SUM(menge) AS menge
        FROM dbp_data.artbew_1 AS T1_1
        WHERE
            dat BETWEEN (
                SELECT MIN(dat)
                FROM dbp_etl.`_zeitraum_${TRANSIENT_TABLE_SUFFIX}`) AND (
                SELECT MAX(dat)
                FROM dbp_etl.`_zeitraum_${TRANSIENT_TABLE_SUFFIX}`
            )
        GROUP BY
            mandant_id,
            art_id,
            bewart_id,
            wup_id,
            nb_id,
            dat
    ) AS a
    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        dat_von,
        dat_bis,
        betrag_kmep_einh AS bonus_stk
    FROM dbp_etl_process.ekc_artbew_kmep_1 AS U
    WHERE zeitraum_kz = 'KM') AS b
        ON
            a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.dat BETWEEN b.dat_von AND
            b.dat_bis
    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        dat_von,
        dat_bis,
        betrag_kmep_einh AS bonus_stk
    FROM dbp_etl_process.ekc_artbew_kmep_1 AS U
    WHERE zeitraum_kz = 'KW') AS c
        ON
            a.mandant_id = c.mandant_id AND a.art_id = c.art_id AND a.dat BETWEEN c.dat_von AND
            c.dat_bis
    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        dat_von,
        dat_bis,
        betrag_kmep_einh AS bonus_stk
    FROM dbp_etl_process.ekc_artbew_kmep_1 AS U
    WHERE zeitraum_kz = 'WW') AS d
        ON
            a.mandant_id = d.mandant_id AND a.art_id = d.art_id AND a.dat BETWEEN d.dat_von AND
            d.dat_bis
    GROUP BY
        a.mandant_id,
        a.art_id,
        a.bewart_id,
        a.wup_id,
        a.nb_id,
        a.dat
);
