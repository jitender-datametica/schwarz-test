CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_BV_QUELLE_SPR_ZU_1(
	BV_QUELLE_ID,
	BV_QUELLE_BEZ
) AS
--  2023-09-04, dknop, initial
--2025-07-04, dknop, adding 0
SELECT
 v01.bv_quelle_id
,v01.bv_quelle_bez
FROM dbp_view.v_bv_quelle_spr_zu_1 v01
GROUP BY v01.bv_quelle_id, bv_quelle_bez
UNION
SELECT
0
,'Kein BV'
;
