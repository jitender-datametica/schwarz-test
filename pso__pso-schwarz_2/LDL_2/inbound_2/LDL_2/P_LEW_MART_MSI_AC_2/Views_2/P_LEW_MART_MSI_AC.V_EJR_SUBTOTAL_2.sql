CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_SUBTOTAL_2
(
    store_id
    , client_id
    , pos_terminal_id
    , dat_formdate
    , time_receipt_ejr
    , orig_receipt_nr_ejr
    , orig_receipt_serial_nr_ejr
    , timezone_cd
    , dat_dayend
    , checker_id
    , transactiontype_id
    , timestamp_begin_ejr
)
AS
SELECT
store_id,
client_id,
pos_terminal_id,
dat_formdate,
time_receipt_ejr,
orig_receipt_nr_ejr,
orig_receipt_serial_nr_ejr,
timezone_cd,
dat_dayend,
checker_id,
transactiontype_id,
timestamp_begin_ejr
FROM p_lew_mart_msi.v_ejr_subtotal_2
;


