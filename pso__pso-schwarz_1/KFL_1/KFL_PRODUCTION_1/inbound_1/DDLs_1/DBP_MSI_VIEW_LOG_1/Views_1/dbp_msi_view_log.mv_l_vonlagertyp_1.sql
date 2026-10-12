CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_VONLAGERTYP_1(
	LAGERTYP_ID_VON
) AS
SELECT
v01.lagertyp_id AS lagertyp_id_von
FROM dbp_view.v_l_lagertyp_1 v01
WHERE LENGTH(TRIM(v01.lagertyp_id))=4 
AND v01.wup_id > 0
GROUP BY v01.lagertyp_id

UNION

SELECT 
''
;