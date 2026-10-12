create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_BV_QUELLE_SPR_ZU_2(
	BV_QUELLE_ID,
	BV_QUELLE_BEZ
) as


SELECT
 v01.bv_quelle_id
,v01.bv_quelle_bez
FROM dbp_view.v_bv_quelle_spr_zu_2 v01
GROUP BY v01.bv_quelle_id, bv_quelle_bez
UNION
SELECT
0
,'Kein BV';