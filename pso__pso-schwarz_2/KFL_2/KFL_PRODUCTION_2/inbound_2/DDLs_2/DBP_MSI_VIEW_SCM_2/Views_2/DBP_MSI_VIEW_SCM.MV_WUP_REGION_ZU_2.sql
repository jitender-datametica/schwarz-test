CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WUP_REGION_ZU_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	REGION_ID
) AS
--2025-06-13 | nwag | initial
--2025-07-03 | nwag | add -1
SELECT 
    w.MANDANT_ID, 
    w.WUP_ID, 
    w.NB_ID, 
    COALESCE(wcz.WUP_CLUSTER_ID,-1) AS REGION_ID 
FROM DBP_VIEW.V_WUP_2 W
LEFT JOIN DBP_VIEW.V_TS_SCM_WUP_CLUSTER_ZU_2 WCZ 
    ON w.mandant_id =wcz.mandant_id
    AND w.wup_id = wcz.wup_id
    AND w.nb_id = wcz.nb_id
    AND wcz.WUP_CLUSTER_ID   IN (101,102,103,106,107,108)
WHERE w.nb_id=0;