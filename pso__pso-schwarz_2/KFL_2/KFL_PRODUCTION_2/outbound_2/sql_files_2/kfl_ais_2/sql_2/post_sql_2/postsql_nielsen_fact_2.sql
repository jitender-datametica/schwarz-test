-- 1. Create temp table


CREATE OR REPLACE TEMPORARY TABLE _check_nielsen_mat_kjmo AS
SELECT
    A.mandant_id,
    SUBSTR(A.per_tag, 2, 4) || SUBSTR(A.per_tag, 7, 2) AS nielsen_kjwo,
    B.kjmo
FROM ${TEMP_TABLE} AS A
INNER JOIN dbp_data.tag_2 AS B ON CAST(SUBSTR(A.per_tag, 2, 4) || SUBSTR(A.per_tag, 7, 2) AS FLOAT64) = B.kjwo
WHERE
    B.wtag_id = 1
    AND (
        A.mandant_id, A.per_tag) IN (
        SELECT (mandant_id, MAX(per_tag))
        FROM ${TEMP_TABLE}
        GROUP BY mandant_id
    )
GROUP BY
    A.mandant_id,
    nielsen_kjwo,
    B.kjmo;


-- 2. Update temp table with the calculated month


UPDATE ${TEMP_TABLE} SET
    mat_kjmo = b.kjmo FROM (
    SELECT
        mandant_id,
        kjmo
    FROM `_check_nielsen_mat_kjmo`
    GROUP BY
        mandant_id,
        kjmo
) AS b
WHERE
    ${TEMP_TABLE}.mandant_id = b.mandant_id AND
    ${TEMP_TABLE}.mat_kjmo IS NULL;


-- 3. Cleanup existing data in Fact table


DELETE FROM dbp_etl.nielsen_fact
WHERE (
    mandant_id, mat_kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM `_check_nielsen_mat_kjmo`
    GROUP BY mandant_id,
    kjmo
);


-- 4. Insert data from temp to Fact table


INSERT INTO dbp_etl.nielsen_fact (
    mandant_id, mat_kjmo, file_name, mkt_tag, prod_tag, per_tag, sales_item,
    sales_unit, sales_value, numeric_distribution, weighted_distribution, avg_price_unit, avg_price_item, menge, menge_sa,
    menge_af, umsatz_netto, umsatz_netto_sa, umsatz_netto_af, distribution_numerisch, distribution_gewichtet, anz_maerkte,
    distr_num_4_wo, distr_gew_4_wo, td_update, td_insert
)
(
    SELECT *
    FROM ${TEMP_TABLE}
);


-- 5. Set MAT_KJMO in Market and Product tables


DELETE FROM dbp_etl.nielsen_mkt
WHERE (
    mandant_id, mat_kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM `_check_nielsen_mat_kjmo`
    GROUP BY mandant_id,
    kjmo
);


DELETE FROM dbp_etl.nielsen_prod
WHERE (
    mandant_id, mat_kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM `_check_nielsen_mat_kjmo`
    GROUP BY mandant_id,
    kjmo
);


UPDATE dbp_etl.nielsen_mkt SET
    mat_kjmo = b.kjmo FROM (
    SELECT
        mandant_id,
        kjmo
    FROM `_check_nielsen_mat_kjmo`
    GROUP BY
        mandant_id,
        kjmo
) AS b
WHERE nielsen_mkt.mandant_id = b.mandant_id AND nielsen_mkt.mat_kjmo IS NULL;


UPDATE dbp_etl.nielsen_prod SET
    mat_kjmo = b.kjmo FROM (
    SELECT
        mandant_id,
        kjmo
    FROM `_check_nielsen_mat_kjmo`
    GROUP BY
        mandant_id,
        kjmo
) AS b
WHERE nielsen_prod.mandant_id = b.mandant_id AND nielsen_prod.mat_kjmo IS NULL;
