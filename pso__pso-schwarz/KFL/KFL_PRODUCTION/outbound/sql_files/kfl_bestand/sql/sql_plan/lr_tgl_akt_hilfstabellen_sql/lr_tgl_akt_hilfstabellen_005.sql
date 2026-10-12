--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.mk_wupartcal
WHERE dat = CURRENT_DATE("Europe/Berlin");


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.


-- Setzen des Saison Flags (Winter: NOV-MRZ, Sommer: APR-OKT)
INSERT INTO dbp_etl.mk_wupartcal (
    mandant_id,
    wup_id, nb_id, art_id, dat, wtag_id, aktion_fg, saison_fg
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat,
        wtag_id,
        this_aktion_fg AS aktion_fg,
        saison_fg
    FROM (
        SELECT
            T01.mandant_id,
            T01.wup_id,
            T01.nb_id,
            T02.art_id,
            T01.dat,
            T01.wtag_id -- , t02.reg_fg
            ,
            T02.aktion_fg -- Überprüfung ob Promotion (1), regulärer (0)
            ,
            CASE
                WHEN T03.art_id IS NOT NULL
                    THEN 1
                ELSE 0
            END AS this_aktion_fg,
            CASE
                WHEN EXTRACT(MONTH FROM T01.dat) BETWEEN 4 AND 10
                    THEN 'S'
                ELSE 'W'
            END AS saison_fg,
            T01.offen
        FROM dbp_etl.mk_wupcal AS T01
        INNER JOIN dbp_data.mk_art_wup_auswahl AS T02
            ON
                T01.mandant_id = T02.mandant_id AND T01.wup_id = T02
                .wup_id
                AND T01.dat BETWEEN DATE_SUB(
                    CURRENT_DATE("Europe/Berlin"), INTERVAL 7 DAY
                ) AND (CURRENT_DATE("Europe/Berlin"))
                AND T02.aktiv_fg = 1
                AND CURRENT_DATE("Europe/Berlin") BETWEEN T02.dat_von AND T02.dat_bis
        LEFT JOIN dbp_etl.mk_promocal AS T03
            ON
                T01.mandant_id = T03.mandant_id AND T01.wup_id = T03.wup_id
                AND T01.nb_id = T03.nb_id
                AND T02.art_id = T03.art_id
                AND T01.dat = T03.dat
        INNER JOIN
            dbp_data.art_wup_zu_per
                AS T04
            ON
                T01.mandant_id = T04.mandant_id AND T01.wup_id = T04.wup_id
                AND T01.nb_id = T04.nb_id
                AND T02.art_id = T04.art_id
                AND T01.dat BETWEEN T04.dat_von AND T04.dat_bis
    ) AS t05
    WHERE
        dat = CURRENT_DATE("Europe/Berlin")
        AND offen = 1
        AND (
            this_aktion_fg = 1 AND aktion_fg = 1
            OR this_aktion_fg IN (0) AND aktion_fg = 0
        )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat,
        wtag_id,
        aktion_fg,
        saison_fg
);
