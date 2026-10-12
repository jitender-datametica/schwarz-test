CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_REGIONALGESELLSCHAFT_1 (
	MANDANT_ID,
	VS_ID,
	VS_BEZ,
	VSVT_BEZ
)
AS
--2023-02-09, dknop, updating Case to show vs_bez instead of “nicht anwendbar” 
SELECT
v01.mandant_id,
v01.vs_id,
v02.vs_bez,
--CASE WHEN v01.mandant_id <> 1 THEN 'Nicht anwendbar' ELSE v02.vsvt_bez END AS vsvt_bez
v02.vsvt_bez
FROM dbp_view.v_wup_1 v01

INNER JOIN dbp_view.v_vs_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.vs_id = v02.vs_id
AND ((v02.vk_id= 0 AND v01.mandant_id <> 1) OR (v01.mandant_id = 1 AND v02.vk_id = 1))

GROUP BY
  v01.mandant_id
, v01.vs_id
,v02.vs_bez
,v02.vsvt_bez

UNION ALL
SELECT
v11.mandant_id,
-1 AS vs_id,
'Alle (DIF)' AS vs_bez,
'Alle Regionen (DIF)' AS vsvt_bez
FROM dbp_view.v_mandant_1 v11 WHERE mandant_id=1 
;