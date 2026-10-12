/*
#----------------------------------------------------------------------------
# Description:
# This view provides the precalculated ejr kpis on section and item_2 level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_SECTION_ITEM_EJR_ASIS_2 
(
    periode_id
    ,client_id
    ,spaceman_section_sid
    ,spaceman_item_sid
    ,currency_iso_cd
    ,qty_ejr_asis_per_day
    ,qty_ejr_asis
    ,val_net_ejr_asis
)
AS
SELECT periode_id
     , client_id
     , spaceman_section_sid
     , spaceman_item_sid
     , currency_iso_cd
     , qty_ejr_asis_per_day
     , qty_ejr_asis
     , val_net_ejr_asis
FROM FE_MSTR_TOOLBOX_SPIEGEL.t_agg_section_item_ejr_asis_2;
