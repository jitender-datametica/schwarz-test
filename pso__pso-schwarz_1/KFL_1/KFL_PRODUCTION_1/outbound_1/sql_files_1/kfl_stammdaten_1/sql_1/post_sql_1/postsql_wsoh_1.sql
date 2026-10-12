DELETE FROM dbp_etl.wsoh_1
WHERE skopf = 0;


DELETE FROM dbp_data.baustein_per_1
WHERE mandant_id IN (
    SELECT MAN.mandant_id
    FROM dbp_etl.wsoh_1
    INNER JOIN dbp_data.mandant_1 AS MAN ON wsoh.mandt = MAN.mandant_sap_id
);


DELETE FROM dbp_data.baustein_wup_zu_per_1
WHERE mandant_id IN (
    SELECT MAN.mandant_id
    FROM dbp_etl.wsoh_1
    INNER JOIN dbp_data.mandant_1 AS MAN ON wsoh.mandt = MAN.mandant_sap_id
);


DELETE FROM dbp_data.baustein_art_zu_per_1
WHERE mandant_id IN (
    SELECT MAN.mandant_id
    FROM dbp_etl.wsoh_1
    INNER JOIN dbp_data.mandant_1 AS MAN ON wsoh.mandt = MAN.mandant_sap_id
);


INSERT INTO dbp_data.baustein_per_1 (
    baustein_id, mandant_id, spr_id, baustein_bez, dat_von, dat_bis
)
(
    SELECT
        wsoh.skopf,
        MAN.mandant_id,
        22,
        wsoh.vtext,
        wsoh.datab,
        wsoh.datub
    FROM dbp_etl.wsoh_1
    INNER JOIN dbp_data.mandant_1 AS MAN ON wsoh.mandt = MAN.mandant_sap_id
    WHERE wsoh.lvorm <> 'X'
);
