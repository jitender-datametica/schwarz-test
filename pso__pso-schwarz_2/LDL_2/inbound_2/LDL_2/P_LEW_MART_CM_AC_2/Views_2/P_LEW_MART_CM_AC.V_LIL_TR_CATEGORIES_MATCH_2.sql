CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_TR_CATEGORIES_MATCH_2
/*
#DescStart#
#$Revision: 12251 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , subitemgroup_id
    , family_cd
)
AS
SELECT
client_id,
subitemgroup_id,
family_cd
FROM p_lew_mart_cm.v_lil_tr_categories_match_2 ;



