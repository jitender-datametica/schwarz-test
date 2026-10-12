CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_HYDRA_PRAEMIENGRUPPE_1(
	MANDANT_ID,
	PERS_TEILBEREICH_ID,
	PRAEMIENGRP_ID,
	PRAEMIENGRP_BEZ
) AS
--2023-06-29, AP0145540,SPEC0182434, dknop, initial 
--2023-10-06, AP0145540,SPEC0182434, nwag, chg id-1 
SELECT
 mandant_id
,pers_teilbereich_id
,COALESCE(CASE WHEN praemiengrp_id='' THEN NULL ELSE praemiengrp_id END ,'-1') AS praemiengrp_id
,COALESCE(CASE WHEN praemiengrp_id='' THEN 'fehlende ''Kein Pick/BDE PG''' WHEN praemiengrp_bez='' THEN NULL ELSE praemiengrp_bez END,'n/a') AS praemiengrp_bez
FROM dbp_view.v_l_hydra_praemiengruppe_1;
