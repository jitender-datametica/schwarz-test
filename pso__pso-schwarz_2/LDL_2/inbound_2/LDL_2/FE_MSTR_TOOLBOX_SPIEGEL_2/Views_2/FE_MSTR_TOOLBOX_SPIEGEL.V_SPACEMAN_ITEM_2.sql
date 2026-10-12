/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup table for spaceman item_2
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_ITEM_2
(
     int_org_sid
    ,spaceman_item_sid
    ,spaceman_item_nr
    ,spaceman_item_name  
    ,spaceman_item_segment_sid
    ,spaceman_item_grp_sid
)
AS
SELECT spitem.int_org_sid
     , spitem.spaceman_item_sid
     , CAST(TO_NUMBER(spitem.spaceman_item_nr) AS INTEGER) AS spaceman_item_nr 
     , spitemhist.spaceman_item_name
     , spitemhist.spaceman_item_segment_sid
     , spitemhist.spaceman_item_grp_sid
FROM   P_LEW_CORE_AC.v_spaceman_item_2 spitem 
 INNER JOIN P_LEW_CORE_AC.v_spaceman_item_hist_2 spitemhist 
    ON spitem.spaceman_item_sid = spitemhist.spaceman_item_sid
WHERE  spitemhist.dwh_valid_to = '9999-12-30' 
   AND spitemhist.deleted_fg = 0;
