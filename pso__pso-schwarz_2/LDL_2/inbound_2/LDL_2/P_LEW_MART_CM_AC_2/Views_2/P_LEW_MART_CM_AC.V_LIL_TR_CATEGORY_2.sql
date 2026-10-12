CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_TR_CATEGORY_2
/*
#DescStart#
#$Revision: 12251 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , src_subitemgrp_cd
    , src_familygrp_cd
)
AS
SELECT
client_id,
src_subitemgrp_cd,
src_familygrp_cd
FROM p_lew_mart_cm.v_lil_tr_category_2 ;


