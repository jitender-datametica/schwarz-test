WITH
  LAST_SALE_${COUNTRY_1} AS (
    SELECT
      LA.kl_art_id,
      LA.mandant_id,
      LA.wup_id,
      LA.dat,
      LA.datzeit
    FROM dbp_ods.ods_letzter_abverkauf_1 AS LA
    INNER JOIN
      (
        SELECT
          mandant_id,
          wup_id,
          dat,
          MIN(bon_beginn) AS bon_beginn
        FROM dbp_etl.dat_wup_last_sale_${COUNTRY_1}
        WHERE
          dat
          BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 2 DAY)
          AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        GROUP BY
          mandant_id,
          wup_id,
          dat
      ) AS lb
      ON
        LA.mandant_id = lb.mandant_id
        AND LA.wup_id = lb.wup_id
        AND LA.dat = lb.dat
        AND LA.datzeit > lb.bon_beginn
  )
(
  SELECT
    t3.article_no,
    t3.country_1,
    t3.store_no,
    t3.sale_date,
    t3.sales_time
  FROM
    (
      SELECT
        a.kl_art_id AS article_no,
        CASE
          WHEN a.mandant_id = 1
            THEN 'DE'
          ELSE B.mandant_kbez
          END AS country_1,
        a.wup_id AS store_no,
        a.dat AS sale_date,
        FORMAT_DATETIME('%F %H:%M:%S', a.datzeit) AS sales_time,
        a.wup_id
      FROM LAST_SALE_${COUNTRY_1} AS a
      INNER JOIN dbp_data.mandant_1 AS B
        ON a.mandant_id = B.mandant_id
      ORDER BY a.wup_id NULLS LAST
    ) AS t3
);
