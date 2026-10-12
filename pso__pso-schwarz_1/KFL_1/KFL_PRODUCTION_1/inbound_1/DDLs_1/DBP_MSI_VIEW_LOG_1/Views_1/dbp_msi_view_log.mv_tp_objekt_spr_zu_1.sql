CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TP_OBJEKT_SPR_ZU_1(
	TP_OBJEKT_ID,
	MANDANT_ID,
	TP_OBJEKT_BEZ
) AS
--2022-10-28, AP0133256,SPEC0166769,dknop, initial
--2022-11-24, AP0133256,SPEC0166769,dknop, updating logic, previous was giving duplications
--2023-07-17, staeblern Umstellung auf Session Variable 
SELECT
v00.tp_objekt_id,
v00.mandant_id,
v00.tp_objekt_bez
FROM (SELECT
v01.mandant_id,
v01.tp_objekt_id,
v01.spr_id,
v01.tp_objekt_bez,
CASE WHEN v02.spr_id IS NOT NULL THEN 1 WHEN  v03.spr_id=v01.spr_id THEN 2 ELSE 3 END AS prio,
ROW_NUMBER() OVER (PARTITION  BY  v01.mandant_id,v01.tp_objekt_id ORDER BY prio ASC) AS rownum
FROM dbp_view.v_tp_objekt_spr_zu_1 v01
JOIN dbp_view.v_mandant_spr_zu_1 v03
ON v01.mandant_id = v03.mandant_id
LEFT JOIN DBP_MSI_VIEW_LOG.MV_USER_SPR_ZU_1 v02
ON v01.spr_id = v02.spr_id
) v00  WHERE v00.rownum=1
/*
 v01.tp_objekt_id
,v01.mandant_id
,v01.tp_objekt_bez

FROM dbp_view.v_tp_objekt_spr_zu_1 v01

GROUP BY v01.tp_objekt_id,v01.mandant_id,v01.tp_objekt_bez*/;