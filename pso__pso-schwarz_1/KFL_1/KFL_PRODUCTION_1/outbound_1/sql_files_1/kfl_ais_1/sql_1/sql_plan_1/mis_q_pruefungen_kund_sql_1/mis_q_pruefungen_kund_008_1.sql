--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_kunden_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    dat_vgl DATE NOT NULL,
    bonanzahl INTEGER NOT NULL,
    kunden_fg INTEGER NOT NULL,
    kundenavg_fg INTEGER NOT NULL,
    kundengleich_fg INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.mis_q_kunden_1 (
    mandant_id, wup_id, nb_id, dat, dat_vgl, bonanzahl, kunden_fg,
    kundenavg_fg, kundengleich_fg
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T2.dat,
        T2.dat_vgl,
        T1.bonanzahl,
        T2.kunden_fg,
        T2.kundenavg_fg,
        T2.kundengleich_fg
    FROM dbp_data.wupcal_1 AS T1_1
    INNER JOIN dbp_etl.mis_q_kunden_join_tag_1 AS T2
        ON T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id
        -- aalb, workaround aufgrund Abbruch am 16.05.2014---
        AND T1.nb_id = T2.nb_id AND T1.dat = T2.dat_vgl

    WHERE T1.bonanzahl IS NOT NULL
);
