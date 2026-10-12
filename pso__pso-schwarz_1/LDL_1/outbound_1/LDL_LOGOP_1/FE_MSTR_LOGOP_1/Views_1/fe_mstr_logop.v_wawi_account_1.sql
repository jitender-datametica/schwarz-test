
CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_account_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id OPTIONS(description='Warehouse id'),
turnover
OPTIONS(description='Turnover calculated on a warehouse level as per Fachkonzept definition: (-1)*NVL(SUM(NVL(DEBIT,0) - NVL(CREDIT,0)),0))'),
end_dt OPTIONS(description='Day end-date - tracking warehouse turnover'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), turnover_cumulative
OPTIONS(description='Cumulative Turnover based on TURNOVER column')) AS WITH TURNOVER_CALC AS (SELECT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
    - 1 * IFNULL(SUM(IFNULL(debit, 0) - IFNULL(credit, 0)), 0) AS turnover,
   DATE(day_end_dt) AS end_dt,
   dwh_valid_from,
   dwh_valid_to
  FROM ldl_logop_data.t_wawi_whaccount_1
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND form_type IN (10, 11, 12, 40, 41, 44, 45, 46, 54, 55, 65, 80, 81, 130, 131, 135, 138, 140, 141, 145, 148, 150,
     151, 160, 161)
   AND DATE(day_end_dt) BETWEEN DATE '2024-03-01' AND (CURRENT_DATE)
   AND NOT deleted_fg
  GROUP BY client_id,
   wh_nr,
   end_dt,
   dwh_valid_from,
   dwh_valid_to) (SELECT client_id,
   wh_id,
   turnover,
   end_dt,
   dwh_valid_from,
   dwh_valid_to,
   SUM(turnover) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(EXTRACT(YEAR FROM end_dt) - EXTRACT(MONTH FROM end_dt) < 3 AS STRING) ORDER BY end_dt IS NULL, end_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   turnover_cumulative
  FROM TURNOVER_CALC
  ORDER BY client_id NULLS LAST,
   wh_id NULLS LAST,
   end_dt NULLS LAST);
