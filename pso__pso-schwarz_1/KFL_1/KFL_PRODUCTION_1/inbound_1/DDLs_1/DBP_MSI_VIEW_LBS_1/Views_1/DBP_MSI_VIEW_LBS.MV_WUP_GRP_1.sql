CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WUP_GRP_1(
	WUPGRP_ID,
	WUPGRP_BEZ,
	WUPGRPTYP_ID
) AS SELECT
    wupgrp_id,
    wupgrp_bez,
    wupgrptyp_id
FROM dbp_view.v_wup_grp_1;