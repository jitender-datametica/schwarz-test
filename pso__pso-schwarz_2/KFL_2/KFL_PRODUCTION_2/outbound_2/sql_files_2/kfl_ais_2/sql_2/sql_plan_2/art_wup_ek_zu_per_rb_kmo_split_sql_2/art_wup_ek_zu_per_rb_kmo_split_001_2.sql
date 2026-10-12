--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_wup_ek_zu_per_rb_kmo_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_ek_zu_per_rb_kmo_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    ek_netto NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4) DEFAULT 1.0000 NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    ek_nettonetto NUMERIC(29, 4),
    kein_zekp_fg INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.art_wup_ek_zu_per_rb_kmo_2 (
    art_id, mandant_id, wup_id, nb_id, dat_von, dat_bis,
    ek_netto,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    komponentenmenge,
    wrg_id,
    ek_nettonetto,
    kein_zekp_fg
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat_von,
    dat_bis,
    ek_netto,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    komponentenmenge,
    wrg_id,
    ek_nettonetto,
    kein_zekp_fg
FROM dbp_data.art_wup_ek_zu_per_2
WHERE mandant_id > 1);
