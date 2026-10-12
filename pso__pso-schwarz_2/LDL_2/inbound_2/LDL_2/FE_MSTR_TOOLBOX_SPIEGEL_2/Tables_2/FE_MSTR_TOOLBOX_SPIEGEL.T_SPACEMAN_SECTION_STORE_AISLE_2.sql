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

CREATE TABLE FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_SECTION_STORE_AISLE_2 
(
	spaceman_section_sid NUMBER(38,0) NOT NULL,
	client_id NUMBER(38,0) NOT NULL,
    move_to_store_id NUMBER(38,0) NOT NULL,
	aisle VARCHAR(20),
	dwh_created TIMESTAMP_LTZ(9) NOT NULL,
	dwh_updated TIMESTAMP_LTZ(9) NOT NULL
);