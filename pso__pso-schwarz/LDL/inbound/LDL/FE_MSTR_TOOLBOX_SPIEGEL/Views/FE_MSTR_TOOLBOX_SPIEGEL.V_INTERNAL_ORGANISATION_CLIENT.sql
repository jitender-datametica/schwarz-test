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
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_INTERNAL_ORGANISATION_CLIENT
(
    int_org_sid
    ,int_org_type_cd
    ,client_id
)
AS
SELECT intorgcl.int_org_sid
     , intorgcl.int_org_type_cd
     , intorgcl.client_id
FROM   P_LEW_CORE_AC.v_internal_organisation_client intorgcl
WHERE int_org_type_cd = 'SPACEMAN';