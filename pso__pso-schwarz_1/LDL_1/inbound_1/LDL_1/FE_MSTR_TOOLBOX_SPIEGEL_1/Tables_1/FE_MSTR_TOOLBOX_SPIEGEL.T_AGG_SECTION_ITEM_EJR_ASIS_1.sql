/*
#----------------------------------------------------------------------------
# Description:
# This table provides the precalculated ejr kpis on section and item_1 level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE TABLE FE_MSTR_TOOLBOX_SPIEGEL.T_AGG_SECTION_ITEM_EJR_ASIS_1 
(
    periode_id NUMBER(38,0),
    client_id NUMBER(38,0),
    spaceman_section_sid NUMBER(38,0),
    spaceman_item_sid NUMBER(38,0),
    currency_iso_cd VARCHAR(3) COLLATE 'en-ci',
    qty_ejr_asis_per_day NUMBER(38,12),
    qty_ejr_asis NUMBER(38,12),
    val_net_ejr_asis NUMBER(38,12)
);