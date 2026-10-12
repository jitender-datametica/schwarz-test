/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of spaceman section status.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_SPACEMAN_SECTION_STATUS_2
(
    section_status_cd
    ,section_status_name
    ,section_status_descr
)
AS
SELECT secstat.section_status_cd
     , secstat.section_status_name
     , secstat.section_status_descr
FROM   P_LEW_CORE_AC.v_ref_spaceman_section_status_2 secstat;