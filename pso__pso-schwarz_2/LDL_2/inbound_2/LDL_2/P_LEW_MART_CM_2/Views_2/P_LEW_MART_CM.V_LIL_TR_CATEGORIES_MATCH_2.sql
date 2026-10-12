CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_TR_CATEGORIES_MATCH_2
(
client_id
, subitemgroup_id
, family_cd
)
AS
SELECT
client_id,
src_subitemgrp_cd,
CASE WHEN src_familygrp_cd IS NULL THEN 3333 ELSE src_familygrp_cd END AS src_familygrp_cd
FROM p_lew_mart_cm.v_lil_tr_category_2;


