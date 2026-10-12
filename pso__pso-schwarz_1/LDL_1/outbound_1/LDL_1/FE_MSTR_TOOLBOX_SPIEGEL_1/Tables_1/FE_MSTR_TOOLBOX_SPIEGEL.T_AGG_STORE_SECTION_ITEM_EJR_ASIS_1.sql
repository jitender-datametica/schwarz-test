/*
#----------------------------------------------------------------------------
# Description:
# This table provides the precalculated ejr kpis on store, section and item_1 level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_agg_store_section_item_ejr_asis_1 (
periode_id BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0),
move_to_store_id BIGNUMERIC(38,0),
spaceman_section_sid BIGNUMERIC(38,0),
spaceman_item_sid BIGNUMERIC(38,0),
currency_iso_cd STRING(3) COLLATE 'und:ci',
qty_ejr_asis_per_day BIGNUMERIC(38,11),
qty_ejr_asis BIGNUMERIC(38,11),
val_net_ejr_asis BIGNUMERIC(38,12)
);