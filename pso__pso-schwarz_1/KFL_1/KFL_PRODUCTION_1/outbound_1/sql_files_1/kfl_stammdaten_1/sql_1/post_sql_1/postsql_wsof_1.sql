DELETE FROM dbp_etl.wsof_1
WHERE
    filiale IN (3142, 4112, 4132, 4182, 4202, 4252, 4372, 5400, 6420, 6912, 6914, 9002);


DELETE FROM dbp_etl.wsof_1
WHERE skopf = 0;


DELETE FROM dbp_data.baustein_wup_zu_per_1
WHERE (mandant_id, baustein_id, wup_id, nb_id, dat_bis) IN (
    SELECT (
        MAN.mandant_id, wsof.skopf, wsof.filiale, WUP.nb_id,
        wsof.datub
    )
    FROM dbp_etl.wsof_1
    INNER JOIN dbp_data.mandant_1 AS MAN ON wsof.mandt = MAN.mandant_sap_id
    INNER JOIN
        dbp_data.wup_1 AS WUP_1
        ON MAN.mandant_id = WUP.mandant_id AND wsof.filiale = WUP.wup_id
);


INSERT INTO dbp_data.baustein_wup_zu_per_1 (
    mandant_id, wup_id, nb_id, dat_bis, baustein_id, dat_von
)
(
    SELECT
        MAN.mandant_id,
        wsof.filiale AS wup_id,
        WUP.nb_id,
        MAX(wsof.datub),
        wsof.skopf AS baustein_id,
        wsof.datuv AS dat_von
    FROM dbp_etl.wsof_1
    INNER JOIN dbp_data.mandant_1 AS MAN ON wsof.mandt = MAN.mandant_sap_id
    INNER JOIN
        dbp_data.wup_1 AS WUP_1
        ON MAN.mandant_id = WUP.mandant_id AND wsof.filiale = WUP.wup_id
    WHERE wsof.lvorm <> 'X'
    GROUP BY
        MAN.mandant_id,
        baustein_id,
        wup_id,
        WUP.nb_id,
        dat_von
);
