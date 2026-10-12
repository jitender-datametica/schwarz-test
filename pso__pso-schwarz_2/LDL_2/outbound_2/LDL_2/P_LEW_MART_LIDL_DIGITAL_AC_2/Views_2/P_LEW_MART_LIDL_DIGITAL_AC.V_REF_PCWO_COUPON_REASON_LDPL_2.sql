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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_pcwo_coupon_reason_ldpl_2 (coupon_reason_nr
OPTIONS(description='identifier of the coupon reason in SCRM'), coupon_reason_descr
OPTIONS(description='description of the coupon reason in SCRM'), pcwo_reason_id
OPTIONS(description='WaWi unique ID of reasons for writeoffs and price changees'), pcwo_reason_desc
OPTIONS(description='WaWi unique ID of reasons for writeoffs and price changees description'), is_price_change_fg
OPTIONS(description='Is price change flag'), is_writeoff_fg OPTIONS(description='Is writeoff glag'))
OPTIONS(DESCRIPTION = `REASONS OR PURPOSES FOR LIDLPLUS COUPON`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_ref_pcwo_coupon_reason_ldpl_2;