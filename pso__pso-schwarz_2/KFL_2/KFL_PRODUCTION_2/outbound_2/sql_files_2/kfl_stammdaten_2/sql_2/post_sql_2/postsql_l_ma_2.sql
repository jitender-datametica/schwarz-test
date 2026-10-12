--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.l_ma_2 SET
    dat_bis = t2.dat_bis_ FROM (
    SELECT
        ma_id AS ma_id_,
        dat_bis AS dat_bis_
    FROM ${TEMP_TABLE}
    WHERE
        dat_bis <> PARSE_DATE('%Y%m%d', '99991231')
        AND (
            ma_id, dat_von) IN (
            SELECT (ma_id, MAX(dat_von))
            FROM ${TEMP_TABLE}
            GROUP BY ma_id
        )
) AS t2
WHERE l_ma.ma_id = t2.ma_id_;
