/*
#----------------------------------------------------------------------------
# Description:
# This view provides the precalculated ejr kpis on section and item_1 level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_section_item_ejr_asis_1 (periode_id, client_id,
spaceman_section_sid, spaceman_item_sid, currency_iso_cd, qty_ejr_asis_per_day, qty_ejr_asis, val_net_ejr_asis) AS
SELECT periode_id,
 client_id,
 spaceman_section_sid,
 spaceman_item_sid,
 currency_iso_cd,
 qty_ejr_asis_per_day,
 qty_ejr_asis,
 val_net_ejr_asis
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_section_item_ejr_asis_1;