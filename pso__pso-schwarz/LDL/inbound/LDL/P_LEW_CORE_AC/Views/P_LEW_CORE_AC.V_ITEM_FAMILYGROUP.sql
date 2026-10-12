create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_ITEM_FAMILYGROUP(
	CLIENT_ID,
	ITEM_FAM_GRP_SID,
	SRC_NODE,
	SRC_FAMILYGRP_CD,
	SRC_FAMILYGRP_ID,
	ITEM_FAM_GRP_NAME,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT
client_id,
item_fam_grp_sid,
src_node,
src_familygrp_cd,
src_familygrp_id,
item_fam_grp_name,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_item_familygroup
;
