BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.as_phasen_2;


-- take weekday value for all wgs that exist in dbe_etl_bed.as_phasen_tmp_2, but keep wg entries with no weekday

-- add column with default weekday value
-- multiply with all available posten_kz
-- WHERE wg_id = 0
INSERT INTO
dbp_data.as_phasen_2
(
    SELECT
        a.mandant_id,
        a.wg_id,
        a.posten_kz_sap,
        COALESCE(a.wtag_phasenbeginn, b.wtag_phasenbeginn) AS wtag_phasenbeginn,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM (
        SELECT
            wg.mandant_id,
            wg.wg_id,
            apt.posten_kz_sap,
            AP.wtag_phasenbeginn -- get the wg from DWH

        FROM (SELECT DISTINCT
            mandant_id,
            wg_id
        FROM dbp_data.wg_per_2
        WHERE
            arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        UNION DISTINCT
        SELECT DISTINCT
            mandant_id,
            wg_id
        FROM dbp_etl.as_phasen_tmp_2
        WHERE wg_id <> 0) AS wg
        INNER JOIN (
            SELECT DISTINCT posten_kz_sap
            FROM dbp_etl.as_phasen_tmp_2
        ) AS apt
            ON TRUE
        LEFT JOIN
            dbp_etl.as_phasen_tmp_2
                AS AP
            ON
                wg.mandant_id = AP.mandant_id AND wg.wg_id = AP.wg_id
                AND apt.posten_kz_sap = AP.posten_kz_sap
    ) AS a
    LEFT JOIN (SELECT DISTINCT
        mandant_id,
        posten_kz_sap,
        wtag_phasenbeginn
    FROM dbp_etl.as_phasen_tmp_2) AS b
        ON a.mandant_id = b.mandant_id AND a.posten_kz_sap = b.posten_kz_sap
    WHERE COALESCE(a.wtag_phasenbeginn, b.wtag_phasenbeginn) IS NOT NULL
);


COMMIT TRANSACTION;
