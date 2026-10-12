/*
#----------------------------------------------------------------------------
# Description:
# Transactional Service table for KOP
#
#-----------------------------------------------------------------------------
# History:
#  1.0     21.11.2024      Simeon Nikolaev         Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_spaceman_kop_ts (
int_org_sid BIGNUMERIC(38,0) NOT NULL,
spaceman_item_sid BIGNUMERIC(38,0) NOT NULL,
heavy_sort STRING(300),
center_pull STRING(300),
easy_ident STRING(300),
reason STRING(300),
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL
);