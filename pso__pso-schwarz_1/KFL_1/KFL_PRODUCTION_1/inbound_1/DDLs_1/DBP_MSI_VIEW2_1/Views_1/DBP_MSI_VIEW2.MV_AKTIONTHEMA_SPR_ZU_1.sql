CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AKTIONTHEMA_SPR_ZU_1
(
	AKTION_THEMA_ID,
	MANDANT_ID,
	AKTION_THEMA_BEZ,
	AKTION_THEMA_BEZ_DE,
	AKTION_THEMA_BEZ_CZ,
	AKTION_THEMA_BEZ_SK,
	AKTION_THEMA_BEZ_HR,
	AKTION_THEMA_BEZ_PL,
	AKTION_THEMA_BEZ_RO,
	AKTION_THEMA_BEZ_BG
) AS
SELECT
 aktion_thema_id
,mandant_id
,COALESCE(MAX(CASE WHEN spr_id =  22  THEN aktion_thema_bez END),'nicht vorhanden') AS aktion_thema_bez
,Coalesce(Max(CASE WHEN spr_id =  22  THEN aktion_thema_bez END),'nicht vorhanden') AS aktion_thema_bez_de
,Coalesce(Max(CASE WHEN spr_id = 124  THEN aktion_thema_bez END), aktion_thema_bez_de) AS aktion_thema_bez_cz
,Coalesce(Max(CASE WHEN spr_id = 108  THEN aktion_thema_bez END), aktion_thema_bez_de) AS aktion_thema_bez_sk
,Coalesce(Max(CASE WHEN spr_id =  65  THEN aktion_thema_bez END), aktion_thema_bez_de) AS aktion_thema_bez_hr
,Coalesce(Max(CASE WHEN spr_id =  90  THEN aktion_thema_bez END), aktion_thema_bez_de) AS aktion_thema_bez_pl
,Coalesce(Max(CASE WHEN spr_id =  95  THEN aktion_thema_bez END), aktion_thema_bez_de) AS aktion_thema_bez_ro
,Coalesce(Max(CASE WHEN spr_id =  18  THEN aktion_thema_bez END), aktion_thema_bez_de) AS aktion_thema_bez_bg

FROM DBP_VIEW.V_AKTION_THEMA_SPR_ZU_1
WHERE mandant_id = 1
GROUP BY
 aktion_thema_id
,mandant_id

UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,1 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1 
WHERE mandant_id = 1
/* Ausgeblendet, da Daten nur für DE existieren
UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,2 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1
WHERE mandant_id = 2

UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,3 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1
WHERE mandant_id = 3

UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,4 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1
WHERE mandant_id = 4

UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,5 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1
WHERE mandant_id = 5

UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,6 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1
WHERE mandant_id = 6

UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,7 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1
WHERE mandant_id = 7

UNION 
SELECT
'nicht vorhanden' AS aktion_thema_id
,8 AS mandant_id
,'nicht vorhanden' AS aktion_thema_bez
,'nicht vorhanden' AS aktion_thema_bez_de
,'not available'   AS aktion_thema_bez_cz
,'not available'   AS aktion_thema_bez_sk
,'not available'   AS aktion_thema_bez_hr
,'not available'   AS aktion_thema_bez_pl
,'not available'   AS aktion_thema_bez_ro
,'not available'   AS aktion_thema_bez_bg
FROM DBP_VIEW.V_MANDANT_1
WHERE mandant_id = 8*/;