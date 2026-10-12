/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS.
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2021       Michael Morris                Initial Version
#                                                      20210318_2789_itm_store_cons
#                                                      https://jira.schwarz/browse/INTMIG-779
#                                                      SF: https://jira.schwarz/browse/INTMIG-1399
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_item_store_consolidation_2 (client_id, wh_id, aspect_id, store_id,
item_id, itm_consgrp_id, cons_item_id, cons_orig_item_nr, cons_dat_valid_from_item, cons_fg, itm_consgrp_desc, item_desc
) OPTIONS(DESCRIPTION = `ITEM_2/STORE CONSOLIDATIO VIEW`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_itm_item_store_consolidation_2;