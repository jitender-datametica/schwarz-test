CREATE OR REPLACE VIEW p_lew_bil.v_mat_agg_store_day_sales_payment_type_1
(
  client_id
, dat_formdate
, cy_month
, loc_sid
, orig_store_nr
, currency_iso_cd
, sales_net_val_pos
, return_net_val_pos
, cnt_customer
, sales_payment_type
)
AS
SELECT
  a.client_id
, a.dwh_cal_dt                                AS dat_formdate
, To_Number(To_Char(a.dwh_cal_dt, 'YYYYMM'))  AS cy_month
, a.loc_sid
, store.src_orig_store_nr                     AS orig_store_nr
, b.curr_cd_from                              AS currency_iso_cd
, a.sales_net_val_ln  / b.exchange_rate       AS sales_net_val_pos
, a.return_net_val_ln / b.exchange_rate       AS return_net_val_pos
, a.cnt_customer                              AS cnt_customer
, a.sales_payment_type
FROM
(
    SELECT
      client_id
    , dwh_cal_dt
    , loc_sid
    , sales_payment_type
    , Sum(sales_net_val_ln)  AS sales_net_val_ln
    , Sum(return_net_val_ln) AS return_net_val_ln
    , Count(1)               AS cnt_customer
    FROM
    (
        SELECT
          rcpt.client_id
        , rcpt.dwh_cal_dt
        , rcpt.loc_sid
        , rcpt.receipt_id
        , rcpt.register_id
        , Min(paym.tendertype_ejr_cd) AS sales_payment_type
        , Max(rcpt.sales_net_val_ln ) AS sales_net_val_ln
        , Max(rcpt.return_net_val_ln) AS return_net_val_ln
        FROM
        (
            SELECT
              rh.client_id
            , rh.loc_sid
            , rh.receipt_id
            , rh.register_id
            , rh.dwh_cal_dt
            , paym.paym_val_max AS receipt_paym_val_max
            , rl.sales_net_val_ln
            , rl.return_net_val_ln
            
            FROM p_lew_core_ac.v_pos_receiptheader_1 AS rh
            
            INNER JOIN
            (
                SELECT
                  client_id
                , loc_sid
                , receipt_id
                , register_id
                , dwh_cal_dt
                , Max(payment_val) AS paym_val_max
                FROM 
                (
                    SELECT
                      client_id
                    , loc_sid
                    , receipt_id
                    , register_id
                    , dwh_cal_dt
                    , tendertype_ejr_cd
                    , Sum(payment_val) AS payment_val
                    FROM p_lew_core_ac.v_pos_ctrl_payment_1
                    WHERE turnover_relevant_fg = 1
                    GROUP BY client_id, loc_sid, receipt_id, register_id, dwh_cal_dt, tendertype_ejr_cd
                ) AS p
                GROUP BY client_id, loc_sid, receipt_id, register_id, dwh_cal_dt
            ) AS paym
            ON  paym.client_id   = rh.client_id
            AND paym.loc_sid     = rh.loc_sid
            AND paym.register_id = rh.register_id
            AND paym.receipt_id  = rh.receipt_id
            AND paym.dwh_cal_dt  = rh.dwh_cal_dt
            
            INNER JOIN
            (
                SELECT
                  client_id
                , loc_sid
                , register_id
                , receipt_id
                , dwh_cal_dt
                , Sum(CASE WHEN transaction_type_cd BETWEEN '100' AND '109' 
                             OR transaction_type_cd BETWEEN '120' AND '129'
                             OR transaction_type_cd = '306' -- i.e. consider XML-receipt-LEVEL discounts
                             OR transaction_type_cd BETWEEN '600' AND '609'
                             OR transaction_type_cd BETWEEN '620' AND '629' -- i.e. consider price changes, relevant FOR GKDOS interfaces
                                    THEN ZeroIfNull(sales_val) * 100 / Coalesce(CASE WHEN Cast(vat_pct_val AS DECIMAL(19,6))+100 = 0 THEN NULL ELSE Cast(vat_pct_val AS DECIMAL(19,6))+100 END,100)
                                    ELSE 0
                      END) AS sales_net_val_ln
                , Sum(CASE WHEN transaction_type_cd BETWEEN '140' AND '149'
                             OR transaction_type_cd BETWEEN '640' AND '649' -- i.e. consider price changes, maybe relevant FOR GKDOS interfaces
                                    THEN ZeroIfNull(sales_val) * 100 / Coalesce(CASE WHEN Cast(vat_pct_val AS DECIMAL(19,6))+100 = 0 THEN NULL ELSE Cast(vat_pct_val AS DECIMAL(19,6))+100 END,100)
                                    ELSE 0
                      END) AS return_net_val_ln
                FROM p_lew_core_ac.v_pos_receiptline_1
                WHERE turnover_relevant_fg = 1
                GROUP BY client_id, loc_sid, register_id, receipt_id, dwh_cal_dt
            ) AS rl
            ON  rl.client_id   = rh.client_id
            AND rl.loc_sid     = rh.loc_sid
            AND rl.register_id = rh.register_id
            AND rl.receipt_id  = rh.receipt_id
            AND rl.dwh_cal_dt  = rh.dwh_cal_dt
            
            WHERE rh.turnover_relevant_fg = 1
        ) AS rcpt

        INNER JOIN
        (
            SELECT
              client_id
            , loc_sid
            , receipt_id
            , register_id
            , dwh_cal_dt
            , tendertype_ejr_cd
            , Sum(payment_val) AS paym_val_sum
            FROM p_lew_core_ac.v_pos_ctrl_payment_1
            WHERE turnover_relevant_fg = 1
            GROUP BY client_id, loc_sid, receipt_id, register_id, dwh_cal_dt, tendertype_ejr_cd
        ) AS paym
        ON  paym.client_id    = rcpt.client_id
        AND paym.loc_sid      = rcpt.loc_sid
        AND paym.receipt_id   = rcpt.receipt_id
        AND paym.register_id  = rcpt.register_id
        AND paym.dwh_cal_dt   = rcpt.dwh_cal_dt
        AND paym.paym_val_sum = rcpt.receipt_paym_val_max

        GROUP BY
          rcpt.client_id
        , rcpt.dwh_cal_dt
        , rcpt.loc_sid
        , rcpt.receipt_id
        , rcpt.register_id
    ) AS a1
    GROUP BY
      client_id
    , dwh_cal_dt
    , loc_sid
    , sales_payment_type
) AS a

INNER JOIN p_lew_core_ac.v_location_1 AS store
ON  store.client_id = a.client_id
AND store.loc_sid   = a.loc_sid

INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS b
ON  b.client_id = a.client_id
AND Current_Date BETWEEN b.active_from_dt AND b.active_to_dt
AND Current_Date BETWEEN b.dwh_valid_from AND b.dwh_valid_to

INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS c
ON  c.client_id       = b.client_id
AND c.x_rate_type_sid = b.x_rate_type_sid
AND c.src_kurst       = '@BEWE'
;