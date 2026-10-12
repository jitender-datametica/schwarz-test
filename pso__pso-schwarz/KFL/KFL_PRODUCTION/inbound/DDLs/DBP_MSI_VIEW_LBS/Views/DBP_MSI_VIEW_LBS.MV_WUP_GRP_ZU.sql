CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WUP_GRP_ZU(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	WUPGRP_ID,
	REFERENZIERT,
	REFERENZIEREND
) AS SELECT
    wup_id,
    nb_id,
    mandant_id,
    wupgrp_id,
    referenziert,
    referenzierend
FROM dbp_view.v_wup_grp_zu;