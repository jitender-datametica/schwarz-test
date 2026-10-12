/*
#----------------------------------------------------------------------------
# Description:
# This table provides the dedicated aisle information on section and store level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_spaceman_section_store_aisle_1 (
spaceman_section_sid BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
move_to_store_id BIGNUMERIC(38,0) NOT NULL,
aisle STRING(20),
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL
);