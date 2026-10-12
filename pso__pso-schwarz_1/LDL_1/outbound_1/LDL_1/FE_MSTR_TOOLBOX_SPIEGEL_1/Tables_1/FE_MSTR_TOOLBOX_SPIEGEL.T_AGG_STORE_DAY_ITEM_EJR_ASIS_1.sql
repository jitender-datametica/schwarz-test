/*
#----------------------------------------------------------------------------
# Description:
# This table provides the last 366 days of ejr kpis on store, day and item_1 level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_agg_store_day_item_ejr_asis_1 (
client_id BIGNUMERIC(38,0),
currency_iso_cd STRING(3) COLLATE 'und:ci',
store_id BIGNUMERIC(38,0),
item_id BIGNUMERIC(38,0),
dat_formdate DATE,
qty_ejr_asis NUMERIC(20,5),
val_net_ejr_asis BIGNUMERIC(29,11)
);