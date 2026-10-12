CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_stock_value_add_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item_2 nr'), reported_date OPTIONS(description='T1001 Date'), pieceqty_cal
OPTIONS(description='Stock Expected'), pieceqty_real OPTIONS(description='Stock Counted'), pieceqty_diff
OPTIONS(description='Stock Difference'), retail_price OPTIONS(description='Retail Price from Bestandartikel_2'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted')) AS WITH VASTOCK AS (SELECT
   VAS.client_id,
   VAS.wh_nr,
   VAS.itemnr,
   VAS.cal_dt,
   VAS.pieceqty_cal,
   VAS.pieceqty_real,
   BES.retail_price,
   VAS.dwh_load_id,
   VAS.dwh_created,
   VAS.dwh_updated,
   VAS.dwh_valid_from,
   VAS.dwh_valid_to,
   VAS.deleted_fg
  FROM ldl_logop_data.t_wawi_stock_value_2 AS VAS
   INNER JOIN ldl_logop_data.t_wawi_bestandartikel_act_2 AS BES ON VAS.client_id = BES.client_id AND VAS.wh_nr = BES.wh_nr
       AND VAS.itemnr = BES.artikelnr
  WHERE CURRENT_DATE BETWEEN VAS.dwh_valid_from AND VAS.dwh_valid_to
   AND CAST(VAS.cal_dt AS DATE) >= DATE_ADD(CURRENT_DATE, INTERVAL - 28 DAY)
   AND VAS.stock_area = 2
   AND NOT VAS.deleted_fg) (SELECT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   itemnr AS artikelnr,
   DATE_TRUNC(cal_dt, DAY) AS reported_date,
   IFNULL(pieceqty_cal, 0),
   IFNULL(pieceqty_real, 0),
    IFNULL(pieceqty_cal, 0) - IFNULL(pieceqty_real, 0) AS pieceqty_diff,
   retail_price,
   dwh_load_id,
   dwh_created,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CASE
       WHEN client_id = 13 AND wh_nr = 600
       THEN 60
       WHEN client_id = 18 AND wh_nr = 20
       THEN 4
       WHEN client_id = 21 AND wh_nr = 20
       THEN 22
       ELSE wh_nr
       END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM VASTOCK);