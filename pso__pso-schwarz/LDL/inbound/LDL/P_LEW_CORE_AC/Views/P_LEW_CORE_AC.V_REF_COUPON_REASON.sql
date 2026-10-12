CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_COUPON_REASON

(
    coupon_reason_nr COMMENT 'identifier of the coupon reason in SCRM'
    , coupon_reason_descr COMMENT 'description of the coupon reason in SCRM'
    , emp_coupon_fg COMMENT 'indicates whether a coupon reason is related to employees only or not. That means that a coupon with a reason which has themp_coupon_fg = 1 can be assigned only to employees.'
    , dwh_load_id COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
    , dwh_created COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
    , dwh_updated COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
)
AS
   SELECT
    coupon_reason_nr
    , coupon_reason_descr
    , emp_coupon_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
  FROM p_lew_core.T_REF_COUPON_REASON
;