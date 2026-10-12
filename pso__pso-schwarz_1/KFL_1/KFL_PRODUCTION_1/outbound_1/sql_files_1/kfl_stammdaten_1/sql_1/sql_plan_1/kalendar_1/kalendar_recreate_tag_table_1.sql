BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.tag_1;


INSERT INTO dbp_data.tag_1 (
    dat,
    kjmo,
    kjmo_vj,
    kjmo_vvj,
    wtag_id,
    kjwo,
    kjwo_vj,
    kjwo_vvj,
    gjwo,
    gjwo_vj,
    wo_dat_von,
    wo_dat_bis,
    gjmo,
    gjmo_vj,
    kjqu,
    gjqu,
    kj,
    gj,
    kjtag_id,
    gjtag_id,
    kjwo_kl,
    kjwo_kl_dat_von,
    kjwo_kl_dat_bis,
    gjwo_kl,
    gjwo_kl_dat_von,
    gjwo_kl_dat_bis,
    dat_vj,
    dat_vvj,
    akt_tag,
    akt_mo,
    akt_mo_komplett,
    akt_wo,
    akt_wo_komplett,
    akt_gjwo_kl,
    akt_gjwo_kl_komplett,
    akt_kjwo_kl,
    akt_kjwo_kl_komplett,
    akt_gjqu,
    akt_gjqu_komplett,
    akt_kjqu,
    akt_kjqu_komplett,
    akt_gj,
    akt_gj_komplett,
    akt_kj,
    akt_kj_komplett,
    mo_gj,
    mo_kj,
    pjwo,
    gjhj,
    akt_gjhj,
    akt_gjhj_komplett, dat_vj_kt
)
(
    SELECT
        T0.dat,
        T0.kjmo,
        T0.kjmo_vj,
        (
            EXTRACT(YEAR FROM PARSE_DATE('%Y%m', CAST(T0.kjmo AS STRING))) - 2
        ) * 100
        + EXTRACT(
            MONTH FROM PARSE_DATE('%Y%m', CAST(T0.kjmo AS STRING)
            )
        ) AS kjmo_vvj,
        T0.wtag_id,
        T0.kjwo,
        T0.kjwo_vj,
        CAST((ROUND(CAST(
            SUBSTR(
                CAST(T0.kjwo_vj AS STRING), 1, 4
            ) AS BIGNUMERIC
        ), 0) - 1) * 100
        + ROUND(CAST(SUBSTR(
            CAST(T0.kjwo_vj AS STRING),
            5, 2
        ) AS BIGNUMERIC), 0) AS INTEGER) AS kjwo_vvj,
        T0.gjwo,
        T0.gjwo_vj,
        T0.wo_dat_von,
        T0.wo_dat_bis,
        T0.gjmo,
        T0.gjmo_vj,
        T0.kjqu,
        T0.gjqu,
        T0.kj,
        T0.gj,
        T0.kjtag_id,
        T0.gjtag_id,
        T0.kjwo_kl,
        T0.kjwo_kl_dat_von,
        T0.kjwo_kl_dat_bis,
        T0.gjwo_kl,
        T0.gjwo_kl_dat_von,
        T0.gjwo_kl_dat_bis,
        T0.dat_vj,
        DATE_SUB(T0.dat, INTERVAL 728 DAY) AS dat_vvj,
        T0.akt_tag - T1.akt_tag AS akt_tag,
        T0.akt_mo - T1.akt_mo AS akt_mo,
        T0.akt_mo - T1.akt_mo_komplett AS akt_mo_komplett,
        T0.akt_wo - T1.akt_wo AS akt_wo,
        T0.akt_wo - T1.akt_wo_komplett AS akt_wo_komplett,
        T0.akt_gjwo_kl - T1.akt_gjwo_kl AS akt_gjwo_kl,
        T0.akt_gjwo_kl - T1.akt_gjwo_kl_komplett AS akt_gjwo_kl_komplett,
        T0.akt_kjwo_kl - T1.akt_kjwo_kl AS akt_kjwo_kl,
        T0.akt_kjwo_kl - T1.akt_kjwo_kl_komplett AS akt_kjwo_kl_komplett,
        T0.akt_gjqu - T1.akt_gjqu AS akt_gjqu,
        T0.akt_gjqu - T1.akt_gjqu_komplett AS akt_gjqu_komplett,
        T0.akt_kjqu - T1.akt_kjqu AS akt_kjqu,
        T0.akt_kjqu - T1.akt_kjqu_komplett AS akt_kjqu_komplett,
        T0.akt_gj - T1.akt_gj AS akt_gj,
        T0.akt_gj - T1.akt_gj_komplett AS akt_gj_komplett,
        T0.akt_kj - T1.akt_kj AS akt_kj,
        T0.akt_kj - T1.akt_kj_komplett AS akt_kj_komplett,
        T0.mo_gj,
        T0.mo_kj,
        T0.pjwo,
        T0.gjhj,
        T0.akt_gjhj - T1.akt_gjhj AS akt_gjhj,
        T0.akt_gjhj - T1.akt_gjhj_komplett AS akt_gjhj_komplett,
        (SAFE.PARSE_DATE('%F', CONCAT(EXTRACT(
            YEAR FROM T0.dat
        ) - 1,
        '-',
        EXTRACT(MONTH FROM T0.dat),
        '-',
        EXTRACT(
            DAY FROM
            T0.dat
        )))) AS dat_vj_kt
    FROM dbp_etl_process.tag_master_1 AS T0
    INNER JOIN
        dbp_etl_process.tag_master_1 AS T1_1
        ON T0.dat <= DATE_ADD(T1.dat, INTERVAL 3650 DAY)
    WHERE T1.dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
);


UPDATE dbp_data.tag_1 AS tag0 SET
    kjwo_vvj = CAST(b.kjwo_neu AS INTEGER) FROM (
    SELECT
        a.kjwo,
        CAST(FLOOR(a.kjwo / 100) + 1 AS STRING)
        || '01' AS kjwo_neu
    FROM (
        SELECT kjwo_vvj AS kjwo
        FROM dbp_data.tag_1
        WHERE dat >= DATE '2000-01-01'
        GROUP BY kjwo
    ) AS a
    LEFT JOIN dbp_data.tag_1 AS B ON a.kjwo = B.kjwo
    WHERE B.dat IS NULL
    GROUP BY
        a.kjwo,
        kjwo_neu
) AS b
WHERE tag0.kjwo_vvj = b.kjwo;


COMMIT TRANSACTION;
