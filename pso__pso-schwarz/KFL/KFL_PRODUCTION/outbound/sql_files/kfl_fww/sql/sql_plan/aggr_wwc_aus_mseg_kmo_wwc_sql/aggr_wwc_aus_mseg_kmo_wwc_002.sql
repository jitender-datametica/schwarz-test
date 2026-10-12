--[OK] statement is translated correctly (syntax and type checks are fine)


-- Der zweite UNION-Zweig zieht alle Saetze aus dem Deltatopf 1:1 heran.

-- fern Stornos generiert und diese dann mit dem neuen Delta (s.u.) ausspult.

-- Der erste UNION-Zweig betreibt den Austausch bereits in der LAGERBEW_DET befindlicher

-- Belege, indem er die gelieferten Delta-Saetze der MSEG gegenueberstellt und bei Tref-
MERGE INTO
    dbp_data.lagerbew_det_wwc_woche AS A
USING (
    SELECT
        a1.mandant_id,
        a1.wup_id,
        a1.nb_id,
        a1.lager_bewart_id,
        a1.art_id,
        a1.gp_id,
        a1.wrg_id,
        B1.kjwo_kl,
        SUM(a1.betrag_lagerbew) AS betrag_lagerbew,
        SUM(a1.betrag_verkauf) AS betrag_verkauf,
        SUM(a1.menge_lagerbew_bme) AS menge_lagerbew_bme,
        SUM(a1.betrag_vk_netto) AS betrag_vk_netto,
        SUM(a1.betrag_verkauf_ist) AS betrag_verkauf_ist,
        SUM(a1.betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto,
        SUM(a1.betrag_exbwr) AS betrag_exbwr,
        a1.exvkw_gleich_vkwrt_fg
    FROM (
        SELECT
            Y.mandant_id,
            Y.wup_id,
            Y.nb_id,
            Y.lager_bewart_id,
            Y.art_id,
            Y.gp_id,
            Y.wrg_id,
            Y.dat_buch,
            -1
            * ROUND(CAST(Y.betrag_lagerbew AS NUMERIC), 2) AS betrag_lagerbew,
            -1 * Y.betrag_verkauf AS betrag_verkauf,
            -1 * Y.menge_lagerbew_bme AS menge_lagerbew_bme,
            -1 * Y.betrag_vk_netto AS betrag_vk_netto,
            -1 * Y.betrag_verkauf_ist AS betrag_verkauf_ist,
            -1 * Y.betrag_verkauf_ist_netto AS betrag_verkauf_ist_netto,
            -1 * Z.betrag_exbwr AS betrag_exbwr,
            CASE
                WHEN Y.betrag_verkauf_ist = Y.betrag_verkauf
                    THEN 1
                ELSE 0
            END AS exvkw_gleich_vkwrt_fg
        FROM dbp_data.lagerbew_det_delta AS X
        INNER JOIN dbp_data.lagerbew_det AS Y
            ON
                X.mandant_id = Y.mandant_id
                AND X.lagerbew_beleg_id = Y.lagerbew_beleg_id
                AND X.lagerbew_beleg_pos_id = Y.lagerbew_beleg_pos_id
                AND X.dat_buch = Y.dat_buch
        INNER JOIN dbp_data.lagerbew_det_wwc AS Z
            ON
                X.mandant_id = Z.mandant_id AND X.lagerbew_beleg_id = Z
                .lagerbew_beleg_id
                AND X.lagerbew_beleg_pos_id = Z.lagerbew_beleg_pos_id
                AND X.dat_buch = Z.dat_buch
        UNION ALL
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            lager_bewart_id,
            art_id,
            gp_id,
            wrg_id,
            dat_buch,
            ROUND(CAST(betrag_lagerbew AS NUMERIC), 2) AS betrag_lagerbew,
            betrag_verkauf,
            menge_lagerbew_bme,
            betrag_vk_netto,
            betrag_verkauf_ist,
            betrag_verkauf_ist_netto,
            betrag_exbwr,
            CASE
                WHEN betrag_verkauf_ist = betrag_verkauf
                    THEN 1
                ELSE 0
            END AS exvkw_gleich_vkwrt_fg
        FROM dbp_data.lagerbew_det_delta AS W
    ) AS a1
    INNER JOIN dbp_data.tag AS B1 ON a1.dat_buch = B1.dat
    GROUP BY
        a1.mandant_id,
        a1.wup_id,
        a1.nb_id,
        a1.lager_bewart_id,
        a1.art_id,
        a1.gp_id,
        a1.wrg_id,
        a1.exvkw_gleich_vkwrt_fg,
        B1.kjwo_kl
) AS b
    ON
        A.mandant_id = b.mandant_id
        AND A.art_id = b.art_id
        AND A.wup_id = b.wup_id
        AND A.nb_id = b.nb_id
        AND A.lager_bewart_id
        = b.lager_bewart_id
        AND A.gp_id = b.gp_id
        AND A.kjwo_kl = b.kjwo_kl
        AND A.wrg_id = b.wrg_id
        AND A.exvkw_gleich_vkwrt_fg
        = b.exvkw_gleich_vkwrt_fg
WHEN MATCHED THEN
    UPDATE SET
        betrag_lagerbew
        = A.betrag_lagerbew + b.betrag_lagerbew ,
        betrag_verkauf = A.betrag_verkauf + b.betrag_verkauf ,
        menge_lagerbew_bme
        = A.menge_lagerbew_bme + b.menge_lagerbew_bme ,
        betrag_vk_netto
        = A.betrag_vk_netto + b.betrag_vk_netto ,
        betrag_verkauf_ist
        = A.betrag_verkauf_ist + b.betrag_verkauf_ist ,
        betrag_verkauf_ist_netto
        = 
            A.betrag_verkauf_ist_netto + b.betrag_verkauf_ist_netto ,
        betrag_exbwr = A.betrag_exbwr + b.betrag_exbwr 
WHEN NOT MATCHED THEN INSERT (
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    lager_bewart_id,
    gp_id,
    kjwo_kl,
    exvkw_gleich_vkwrt_fg,
    betrag_lagerbew,
    betrag_verkauf,
    menge_lagerbew_bme,
    betrag_vk_netto,
    betrag_verkauf_ist,
    betrag_exbwr,
    betrag_verkauf_ist_netto, wrg_id
) VALUES (
    b.art_id,
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.lager_bewart_id,
    b.gp_id,
    b.kjwo_kl,
    b.exvkw_gleich_vkwrt_fg,
    b.betrag_lagerbew,
    b.betrag_verkauf,
    b.menge_lagerbew_bme,
    b.betrag_vk_netto,
    b.betrag_verkauf_ist,
    b.betrag_exbwr,
    b.betrag_verkauf_ist_netto,
    b.wrg_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- fern Stornos generiert und diese dann mit dem neuen Delta (s.u.) ausspult.

-- Der erste UNION-Zweig betreibt den Austausch bereits in der LAGERBEW_DET befindlicher

-- Belege, indem er die gelieferten Delta-Saetze der MSEG gegenueberstellt und bei Tref-

-- Der zweite UNION-Zweig zieht alle Saetze aus dem Deltatopf 1:1 heran.
MERGE INTO
    dbp_data.lagerbew_det_wwc_monat
        AS A
USING (
    SELECT
        a1.mandant_id,
        a1.wup_id,
        a1.nb_id,
        a1.lager_bewart_id,
        a1.art_id,
        a1.gp_id,
        a1.wrg_id,
        B1.kjmo,
        SUM(a1.betrag_lagerbew) AS betrag_lagerbew,
        SUM(a1.betrag_verkauf) AS betrag_verkauf,
        SUM(a1.menge_lagerbew_bme) AS menge_lagerbew_bme,
        SUM(a1.betrag_vk_netto) AS betrag_vk_netto,
        SUM(a1.betrag_verkauf_ist) AS betrag_verkauf_ist,
        SUM(a1.betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto,
        SUM(a1.betrag_exbwr) AS betrag_exbwr,
        a1.exvkw_gleich_vkwrt_fg
    FROM (
        SELECT
            Y.mandant_id,
            Y.wup_id,
            Y.nb_id,
            Y.lager_bewart_id,
            Y.art_id,
            Y.gp_id,
            Y.wrg_id,
            Y.dat_buch,
            -1
            * ROUND(CAST(Y.betrag_lagerbew AS NUMERIC), 2) AS betrag_lagerbew,
            -1 * Y.betrag_verkauf AS betrag_verkauf,
            -1 * Y.menge_lagerbew_bme AS menge_lagerbew_bme,
            -1 * Y.betrag_vk_netto AS betrag_vk_netto,
            -1 * Y.betrag_verkauf_ist AS betrag_verkauf_ist,
            -1 * Y.betrag_verkauf_ist_netto AS betrag_verkauf_ist_netto,
            -1 * Z.betrag_exbwr AS betrag_exbwr,
            CASE
                WHEN Y.betrag_verkauf_ist = Y.betrag_verkauf
                    THEN 1
                ELSE 0
            END AS exvkw_gleich_vkwrt_fg
        FROM dbp_data.lagerbew_det_delta AS X
        INNER JOIN dbp_data.lagerbew_det AS Y
            ON
                X.mandant_id = Y.mandant_id
                AND X.lagerbew_beleg_id = Y.lagerbew_beleg_id
                AND X.lagerbew_beleg_pos_id = Y.lagerbew_beleg_pos_id
                AND X.dat_buch = Y.dat_buch
        INNER JOIN dbp_data.lagerbew_det_wwc AS Z
            ON
                X.mandant_id = Z.mandant_id AND X.lagerbew_beleg_id = Z
                .lagerbew_beleg_id
                AND X.lagerbew_beleg_pos_id = Z.lagerbew_beleg_pos_id
                AND X.dat_buch = Z.dat_buch
        UNION ALL
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            lager_bewart_id,
            art_id,
            gp_id,
            wrg_id,
            dat_buch,
            ROUND(CAST(betrag_lagerbew AS NUMERIC), 2) AS betrag_lagerbew,
            betrag_verkauf,
            menge_lagerbew_bme,
            betrag_vk_netto,
            betrag_verkauf_ist,
            betrag_verkauf_ist_netto,
            betrag_exbwr,
            CASE
                WHEN betrag_verkauf_ist = betrag_verkauf
                    THEN 1
                ELSE 0
            END AS exvkw_gleich_vkwrt_fg
        FROM dbp_data.lagerbew_det_delta AS W
    ) AS a1
    INNER JOIN dbp_data.tag AS B1 ON a1.dat_buch = B1.dat
    GROUP BY
        a1.mandant_id,
        a1.wup_id,
        a1.nb_id,
        a1.lager_bewart_id,
        a1.art_id,
        a1.gp_id,
        a1.wrg_id,
        a1.exvkw_gleich_vkwrt_fg,
        B1.kjmo
) AS b
    ON
        A.mandant_id = b.mandant_id
        AND A.art_id = b.art_id
        AND A.wup_id = b.wup_id
        AND A.nb_id = b.nb_id
        AND A.lager_bewart_id
        = b.lager_bewart_id
        AND A.gp_id = b.gp_id
        AND A.kjmo = b.kjmo
        AND A.wrg_id = b.wrg_id
        AND A.exvkw_gleich_vkwrt_fg
        = b.exvkw_gleich_vkwrt_fg
WHEN MATCHED THEN
    UPDATE SET
        betrag_lagerbew
        = A.betrag_lagerbew + b.betrag_lagerbew ,
        betrag_verkauf = A.betrag_verkauf + b.betrag_verkauf ,
        menge_lagerbew_bme
        = A.menge_lagerbew_bme + b.menge_lagerbew_bme ,
        betrag_vk_netto
        = A.betrag_vk_netto + b.betrag_vk_netto ,
        betrag_verkauf_ist
        = A.betrag_verkauf_ist + b.betrag_verkauf_ist ,
        betrag_verkauf_ist_netto
        = 
            A.betrag_verkauf_ist_netto + b.betrag_verkauf_ist_netto ,
        betrag_exbwr = A.betrag_exbwr + b.betrag_exbwr 
WHEN NOT MATCHED THEN INSERT (
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    lager_bewart_id,
    gp_id,
    kjmo,
    exvkw_gleich_vkwrt_fg,
    betrag_lagerbew,
    betrag_verkauf,
    menge_lagerbew_bme,
    betrag_vk_netto,
    betrag_verkauf_ist,
    betrag_exbwr,
    betrag_verkauf_ist_netto, wrg_id
) VALUES (
    b.art_id,
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.lager_bewart_id,
    b.gp_id,
    b.kjmo,
    b.exvkw_gleich_vkwrt_fg,
    b.betrag_lagerbew,
    b.betrag_verkauf,
    b.menge_lagerbew_bme,
    b.betrag_vk_netto,
    b.betrag_verkauf_ist,
    b.betrag_exbwr,
    b.betrag_verkauf_ist_netto,
    b.wrg_id
);
