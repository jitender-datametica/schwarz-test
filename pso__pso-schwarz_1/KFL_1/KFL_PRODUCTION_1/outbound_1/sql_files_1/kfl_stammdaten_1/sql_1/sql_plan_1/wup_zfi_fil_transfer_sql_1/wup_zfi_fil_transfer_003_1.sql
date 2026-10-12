UPDATE dbp_data.art_list_wup_zu_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    art_list_wup_zu_per.mandant_id = b.mandant_id
    AND art_list_wup_zu_per.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis,
        INTERVAL 1 DAY
    ) BETWEEN art_list_wup_zu_per.dat_von AND art_list_wup_zu_per.dat_bis;


UPDATE dbp_data.art_wup_nachschub_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    art_wup_nachschub_per.mandant_id = b.mandant_id
    AND art_wup_nachschub_per.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis,
        INTERVAL 1 DAY
    ) BETWEEN art_wup_nachschub_per.dat_von AND art_wup_nachschub_per.dat_bis;


UPDATE dbp_data.art_wup_ordersatz_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    art_wup_ordersatz.mandant_id = b.mandant_id
    AND art_wup_ordersatz.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis,
        INTERVAL 1 DAY
    ) BETWEEN art_wup_ordersatz.dat_von AND art_wup_ordersatz.dat_bis;


UPDATE dbp_data.art_wup_status_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    art_wup_status_per.mandant_id = b.mandant_id
    AND art_wup_status_per.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis,
        INTERVAL 1 DAY
    ) BETWEEN art_wup_status_per.dat_von AND art_wup_status_per.dat_bis;


UPDATE dbp_data.art_wup_vk_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    art_wup_vk_per.mandant_id = b.mandant_id
    AND art_wup_vk_per.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis, INTERVAL 1
        DAY
    ) BETWEEN art_wup_vk_per.dat_von AND art_wup_vk_per.dat_bis;


UPDATE dbp_data.art_wup_zu_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    art_wup_zu_per.mandant_id = b.mandant_id
    AND art_wup_zu_per.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis, INTERVAL 1
        DAY
    ) BETWEEN art_wup_zu_per.dat_von AND art_wup_zu_per.dat_bis;


UPDATE dbp_data.ek_orderbuch_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    ek_orderbuch.mandant_id = b.mandant_id
    AND ek_orderbuch.wup_id = b.wup_id
    AND DATE_ADD(b.dat_bis, INTERVAL 1 DAY)
    BETWEEN ek_orderbuch.dat_von AND ek_orderbuch.dat_bis;


UPDATE dbp_data.kasse_typ_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    kasse_typ_per.mandant_id = b.mandant_id
    AND kasse_typ_per.wup_id = b.wup_id
    AND DATE_ADD(b.dat_bis, INTERVAL 1 DAY
    ) BETWEEN kasse_typ_per.dat_von AND kasse_typ_per.dat_bis;


UPDATE dbp_data.vz_wg_wup_zu_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    vz_wg_wup_zu_per.mandant_id = b.mandant_id
    AND vz_wg_wup_zu_per.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis, INTERVAL
        1 DAY
    ) BETWEEN vz_wg_wup_zu_per.dat_von AND vz_wg_wup_zu_per.dat_bis;


UPDATE dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    wup_kunde_wg_disporhythmus_lft_zu_per.mandant_id = b.mandant_id
    AND wup_kunde_wg_disporhythmus_lft_zu_per.wup_id
    = b.wup_id AND DATE_ADD(b.dat_bis, INTERVAL 1 DAY) BETWEEN wup_kunde_wg_disporhythmus_lft_zu_per.dat_von AND
    wup_kunde_wg_disporhythmus_lft_zu_per.dat_bis;


UPDATE dbp_data.wup_marktmerkmal_zu_per_1 SET
    dat_bis = b.dat_bis FROM (
    SELECT
        mandant_id,
        wup_id,
        dat_bis
    FROM dbp_data.wup_1
    WHERE
        mandant_id = 1
        AND wup_aenderung_grund_id = 3
) AS b
WHERE
    wup_marktmerkmal_zu_per.mandant_id = b.mandant_id
    AND wup_marktmerkmal_zu_per.wup_id = b.wup_id
    AND DATE_ADD(
        b.dat_bis,
        INTERVAL 1 DAY
    ) BETWEEN wup_marktmerkmal_zu_per.dat_von AND wup_marktmerkmal_zu_per.dat_bis;


CREATE OR REPLACE TEMPORARY TABLE _zfil_kill AS
SELECT
    A.mandant_id,
    A.wup_id,
    B.dat
FROM dbp_data.wup_1 AS A
INNER JOIN dbp_data.tag_1 AS B ON B.dat >= DATE_ADD(A.dat_bis, INTERVAL 1 DAY)
WHERE
    A.mandant_id = 1
    AND A.wup_aenderung_grund_id = 3;


DELETE FROM dbp_data.art_list_wup_zu_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.art_wup_nachschub_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.art_wup_ordersatz_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.art_wup_status_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.art_wup_vk_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.art_wup_zu_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.ek_orderbuch_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.kasse_typ_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.vz_wg_wup_zu_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.wup_marktmerkmal_zu_per_1
WHERE (
    mandant_id, wup_id, dat_von) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


DELETE FROM dbp_data.marktbestand_erp_1
WHERE (
    mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM `_zfil_kill`
);


UPDATE dbp_data.vaus_wup_1 SET
    region_id = 1257
WHERE mandant_id = 2 AND wup_id IN (4850);


UPDATE dbp_data.vaus_wup_1 SET
    region_id = 671
WHERE mandant_id = 2 AND wup_id IN (3550, 3850);


UPDATE dbp_data.vaus_wup_1 SET
    region_id = 669
WHERE mandant_id = 2 AND wup_id IN (3150, 3750);


UPDATE dbp_data.vaus_wup_1 SET
    region_id = 667
WHERE mandant_id = 2 AND wup_id IN (4000, 4050, 4150);


UPDATE dbp_data.wup_1 SET
    region_id = 1257
WHERE mandant_id = 2 AND wup_id IN (4850);


UPDATE dbp_data.wup_1 SET
    region_id = 671
WHERE mandant_id = 2 AND wup_id IN (3550, 3850);


UPDATE dbp_data.wup_1 SET
    region_id = 669
WHERE mandant_id = 2 AND wup_id IN (3150, 3750);


UPDATE dbp_data.wup_1 SET
    region_id = 667
WHERE mandant_id = 2 AND wup_id IN (4000, 4050, 4150);
