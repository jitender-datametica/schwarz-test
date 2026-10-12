/*
#----------------------------------------------------------------------------
# Description:
# This view provides the combination of stores and their dedicated sections.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SECTION_STORE_1
(
    client_id
    ,spaceman_section_sid
    ,loc_sid_store
)
AS
SELECT storehist.client_id
     , storehist.spaceman_section_sid
     , storehist.loc_sid_store
 FROM  P_LEW_CORE_AC.v_spaceman_section_store_hist_1 storehist
 WHERE storehist.dwh_valid_to = '9999-12-30' 
   AND storehist.deleted_fg = 0;