/*
#-------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#
#  1.0 2023-04-20 Pawel Wieczorek         AP0157806 Initial version
#
#-------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_ref_pcwo_coupon_reason_ldpl
COMMENT = 'Reasons or purposes for LidlPlus coupon'
(
    coupon_reason_nr          COMMENT 'identifier of the coupon reason in SCRM'
   ,coupon_reason_descr       COMMENT 'description of the coupon reason in SCRM'
   ,pcwo_reason_id            COMMENT 'WaWi unique ID of reasons for writeoffs and price changees'
   ,pcwo_reason_desc          COMMENT 'WaWi unique ID of reasons for writeoffs and price changees description'
   ,is_price_change_fg        COMMENT 'Is price change flag'
   ,is_writeoff_fg            COMMENT 'Is writeoff glag'
)
AS
SELECT 
 coupon_reason_nr
,coupon_reason_descr
,pcwo_reason_id
,pcwo_reason_desc
,is_price_change_fg
,is_writeoff_fg
FROM p_lew_mart_lidl_digital.v_ref_pcwo_coupon_reason_ldpl
;