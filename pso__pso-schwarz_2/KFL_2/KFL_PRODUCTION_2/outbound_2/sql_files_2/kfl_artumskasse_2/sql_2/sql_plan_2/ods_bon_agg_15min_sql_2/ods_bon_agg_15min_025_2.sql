--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_tag_kasse_2;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_kasse_2 (
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER DEFAULT -1 NOT NULL,
    kassierzeit NUMERIC(29, 2) DEFAULT 0.00 NOT NULL,
    anz_artikel INTEGER DEFAULT 0 NOT NULL,
    registrierzeit NUMERIC(29, 2),
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_kunden INTEGER DEFAULT 0 NOT NULL,
    kassiervorgangszeit INTEGER DEFAULT 0 NOT NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.vis_tag_kasse_2 (
    wup_id, nb_id, mandant_id, dat, kasse_nr, kasse_typ_id, kassierzeit,
    anz_artikel, registrierzeit, umsatz_netto, anz_kunden, kassiervorgangszeit
)
(
    SELECT
        AGG.wup_id,
        0 AS nb_id,
        AGG.mandant_id,
        AGG.dat,
        AGG.kasse_nr,
        AGG.kasse_typ_id,
        SUM(AGG.kassierzeit) AS kassierzeit,
        SUM(AGG.anz_artikel) AS anz_artikel,
        SUM(AGG.registrierzeit) AS registrierzeit,
        SUM(AGG.umsatz_netto) AS umsatz_netto,
        SUM(AGG.anz_kunden) AS anz_kunden,
        SUM(AGG.registrierzeit + AGG.zahlzeit) AS kassiervorgangszeit
    FROM dbp_ods.ods_bon_agg_15min_2 AS AGG
    INNER JOIN dbp_etl.bon_agg_kassenberichte_2 AS K
        ON
            AGG.mandant_id = K.mandant_id AND AGG.wup_id = K.wup_id
            AND AGG.dat = K.bon_dat AND AGG.kasse_nr = K.kasse_nr
    WHERE
        K.bon_dat BETWEEN DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
    GROUP BY
        AGG.wup_id,
        nb_id,
        AGG.mandant_id,
        AGG.dat,
        AGG.kasse_nr,
        AGG.kasse_typ_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_data.vis_tag_kasse_2
WHERE
    dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_data.vis_tag_kasse_2 (
    wup_id, nb_id, mandant_id, dat, kasse_nr, kasse_typ_id, umsatz_netto,
    anz_artikel, anz_kunden, kassierzeit, registrierzeit, kassiervorgangszeit
)
(
    SELECT
        wup_id,
        nb_id,
        mandant_id,
        dat,
        kasse_nr,
        kasse_typ_id,
        umsatz_netto,
        anz_artikel,
        anz_kunden,
        CAST(kassierzeit AS INTEGER) AS kassierzeit,
        CAST(registrierzeit AS INTEGER) AS registrierzeit,
        kassiervorgangszeit
    FROM dbp_etl.vis_tag_kasse_2
    WHERE
        dat BETWEEN DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_ods.bon_load_status_2 SET
    ods_bon_agg_fg = 1
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.bon_agg_kassenberichte_tmp_2
);
