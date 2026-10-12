CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_AKTIONTHEMA_SPR_ZU
(
 aktion_thema_id
,mandant_id
,aktion_thema_bez
,aktion_thema_bez_de
,aktion_thema_bez_cz
,aktion_thema_bez_sk
,aktion_thema_bez_hr
,aktion_thema_bez_pl
,aktion_thema_bez_ro
,aktion_thema_bez_bg
)
AS
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

FROM DBP_VIEW.V_AKTION_THEMA_SPR_ZU
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
FROM DBP_VIEW.V_MANDANT 
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
FROM DBP_VIEW.V_MANDANT
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
FROM DBP_VIEW.V_MANDANT
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
FROM DBP_VIEW.V_MANDANT
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
FROM DBP_VIEW.V_MANDANT
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
FROM DBP_VIEW.V_MANDANT
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
FROM DBP_VIEW.V_MANDANT
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
FROM DBP_VIEW.V_MANDANT
WHERE mandant_id = 8*/;