/*
#----------------------------------------------------------------------------
# Description:
# # This view provides the lookup for internal organisation client.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_internal_organisation_client_2 (int_org_sid, int_org_type_cd,
client_id) AS SELECT int_org_sid,
 int_org_type_cd,
 client_id
FROM ldl_p_lew_core_ac.v_internal_organisation_client_2 AS INTORGCL
WHERE int_org_type_cd = 'SPACEMAN';