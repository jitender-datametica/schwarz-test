
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_MSI_DRILL_DETAIL
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
SELECT
base.client_id,
base.adv_week_id,
CAST( (base.adv_week_id * 100) + base.client_id AS INTEGER) AS adv_week_sid,
base.rltd_adv_week_id,
CAST( (base.rltd_adv_week_id * 100) + base.client_id AS INTEGER) AS adv_week_rltd_sid,
base.adv_period_id,
base.action_type_id,
CAST(1 AS INTEGER) AS _count,
CASE WHEN base.action_type_id = 1 AND base.adv_period_id <> -2 THEN
        /* PV */
        pa.pa01_value
        || '<a style="color:#ffffff" title="Detailanzeige f&uuml;r '
        || aty.action_type_descr
        || ' für Werbewoche '
        || adw.adv_week_descr
        || ' und Werbetermin: '
        || CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Gesamt' ELSE adp.adv_period_descr END
        || '" HREF="mstrWeb'
        /* ? */
        || CHR(63)
        /* PIT-20.01 Standard-Werbetermine Artikel PV */
        || 'evt=2048001&src=mstrWeb.2048001&documentID='
        || pa.pa18_value
        || '&elementsPromptAnswers='
        /* E  Land ( Basic ) = ?! */
        || CASE WHEN pa.pa06_value IS NOT NULL THEN
            pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
           ELSE NULL END
        /* E Typ = ?! */
        || CASE WHEN pa.pa19_value IS NOT NULL THEN
            pa.pa19_value || CAST(aty.action_type_id AS VARCHAR(5)) || ','
           ELSE NULL END
        /* E Werbetermin = ?! */
        || CASE WHEN pa.pa20_value IS NOT NULL THEN
            pa.pa20_value|| CAST(base.adv_period_id AS VARCHAR(5))  || ','
           ELSE NULL END
        /* E Werbewoche = ?! */
        || CASE WHEN pa.pa08_value IS NOT NULL THEN
            pa.pa08_value || CAST( (base.adv_week_id * 100) + base.client_id  AS VARCHAR(12)) || ','
           ELSE NULL END
        /* E Vergleichswerbewoche = ?! */
        || CASE WHEN pa.pa09_value IS NOT NULL THEN
            pa.pa09_value || CAST( CAST( COALESCE(base.rltd_adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
ELSE NULL END
|| '" '
|| pa.pa26_value
|| '> '
|| pa.pa02_value
|| '</a></span>'
WHEN base.action_type_id = 1 AND base.adv_period_id = -2 THEN
/* PV */
/* Color code #00A3E4 Regular blue */
pa.pa12_value
|| '<a style="color:#ffffff" title="Detailanzeige f&uuml;r '
|| aty.action_type_descr
|| ' für Werbewoche '
|| adw.adv_week_descr
|| ' und Werbetermin: '
|| CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Alle Werbetermine' ELSE adp.adv_period_descr END
|| '" HREF="mstrWeb'
/* ? */
|| CHR(63)
/* PIT-20.19 Werbetermine Artikel PV (Alle Termine) */
|| 'evt=2048001&src=mstrWeb.2048001&documentID='
|| pa.pa21_value
|| '&elementsPromptAnswers='
/* E  Land ( Basic ) = ?! */
|| CASE WHEN pa.pa06_value IS NOT NULL THEN
 pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
ELSE NULL END
/* E Typ = ?! */
|| CASE WHEN pa.pa19_value IS NOT NULL THEN
 pa.pa19_value || CAST(aty.action_type_id AS VARCHAR(5)) || ','
ELSE NULL END
/* E Werbewoche = ?! */
|| CASE WHEN pa.pa08_value IS NOT NULL THEN
 pa.pa08_value || CAST( (base.adv_week_id * 100) + base.client_id  AS VARCHAR(12)) || ','
ELSE NULL END
/* E Vergleichswerbewoche = ?! */
|| CASE WHEN pa.pa09_value IS NOT NULL THEN
 pa.pa09_value || CAST( CAST( COALESCE(base.rltd_adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
ELSE NULL END
|| '" '
|| pa.pa26_value
|| '> '
|| pa.pa02_value
|| '</a></span>'
WHEN base.action_type_id IN (2,3) AND base.adv_period_id <> -2 THEN
/* Drill auf Non Food and Food Actions */
pa.pa01_value
|| '<a style="color:#ffffff" title="Detailanzeige f&uuml;r '
|| aty.action_type_descr
|| ' für Werbewoche '
|| adw.adv_week_descr
|| ' und Werbetermin: '
|| CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Gesamt' ELSE adp.adv_period_descr END
|| '" HREF="mstrWeb'
/* ? */
|| CHR(63)
/* PIT-20.20 Werbetermine Artikel NF+FA */
|| 'evt=2048001&src=mstrWeb.2048001&documentID='
|| pa.pa22_value
|| '&elementsPromptAnswers='
/* E  Land ( Basic ) = ?! */
|| CASE WHEN pa.pa06_value IS NOT NULL THEN
 pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
ELSE NULL END
/* E Typ = ?! */
|| CASE WHEN pa.pa19_value IS NOT NULL THEN
 pa.pa19_value || CAST(aty.action_type_id AS VARCHAR(5)) || ','
ELSE NULL END
/* E Werbetermin = ?! */
|| CASE WHEN pa.pa20_value IS NOT NULL THEN
 pa.pa20_value|| CAST(base.adv_period_id AS VARCHAR(5))  || ','
ELSE NULL END
/* E Werbewoche = ?! */
|| CASE WHEN pa.pa08_value IS NOT NULL THEN
 pa.pa08_value || CAST( (base.adv_week_id * 100) + base.client_id  AS VARCHAR(12)) || ','
ELSE NULL END
/* E Vergleichswerbewoche = ?! */
|| CASE WHEN pa.pa09_value IS NOT NULL THEN
 pa.pa09_value || CAST( CAST( COALESCE(base.rltd_adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
ELSE NULL END
|| '" '
|| pa.pa26_value
|| '> '
|| pa.pa02_value
|| '</a></span>'
WHEN base.action_type_id IN (2,3) AND base.adv_period_id = -2 THEN
/* Drill auf Non Food and Food Actions */
/* Color code #00A3E4 Regular blue */
pa.pa12_value
|| '<a style="color:#ffffff" title="Detailanzeige f&uuml;r '
|| aty.action_type_descr
|| ' für Werbewoche '
|| adw.adv_week_descr
|| ' und Werbetermin: '
|| CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Alle Werbetermine' ELSE adp.adv_period_descr END
|| '" HREF="mstrWeb'
/* ? */
|| CHR(63)
/* PIT-20.29 Werbetermine Artikel NF+FA (Alle Termine) */
|| 'evt=2048001&src=mstrWeb.2048001&documentID='
|| pa.pa23_value
|| '&elementsPromptAnswers='
/* E  Land ( Basic ) = ?! */
|| CASE WHEN pa.pa06_value IS NOT NULL THEN
 pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
ELSE NULL END
/* E Typ = ?! */
|| CASE WHEN pa.pa19_value IS NOT NULL THEN
 pa.pa19_value || CAST(aty.action_type_id AS VARCHAR(5)) || ','
ELSE NULL END
/* E Werbewoche = ?! */
|| CASE WHEN pa.pa08_value IS NOT NULL THEN
 pa.pa08_value || CAST( (base.adv_week_id * 100) + base.client_id  AS VARCHAR(12)) || ','
ELSE NULL END
/* E Vergleichswerbewoche = ?! */
|| CASE WHEN pa.pa09_value IS NOT NULL THEN
 pa.pa09_value || CAST( CAST( COALESCE(base.rltd_adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
ELSE NULL END
|| '" '
|| pa26_value
|| '> '
|| pa.pa02_value
|| '</a></span>'
ELSE
NULL
END AS drill_to_dokument_link_html
FROM p_lew_mart_analytics.v_pit_base_period_all AS base
INNER JOIN p_lew_mart_analytics.t_action_type AS aty
ON  base.action_type_id = aty.action_type_id
INNER JOIN p_lew_mart_analytics.t_advert_period AS adp
ON  base.adv_period_id = adp.adv_period_id
INNER JOIN p_lew_mart_analytics.t_advert_week AS adw
ON  base.client_id   = adw.client_id
AND base.adv_week_id = adw.adv_week_id
/* CROSS JOIN Parameter Values */
CROSS JOIN
(SELECT
MAX(CASE WHEN param_id =  1 THEN COALESCE(param_value,'<!-- ERROR SPAN Tag -->') END)          AS pa01_value,
MAX(CASE WHEN param_id =  2 THEN COALESCE(param_value,'<!-- ERROR IMG Tag  -->') END)          AS pa02_value,
MAX(CASE WHEN param_id =  3 THEN COALESCE(param_value,'<!-- ERROR Target Attribute -->') END)  AS pa03_value,
MAX(CASE WHEN param_id =  4 THEN param_value END)                                              AS pa04_value,
MAX(CASE WHEN param_id =  5 THEN param_value END)                                              AS pa05_value,
MAX(CASE WHEN param_id =  6 THEN param_value END)                                              AS pa06_value,
MAX(CASE WHEN param_id =  7 THEN COALESCE(param_value,'N/a')END)                               AS pa07_value,
MAX(CASE WHEN param_id =  8 THEN param_value END)                                              AS pa08_value,
MAX(CASE WHEN param_id =  9 THEN param_value END)                                              AS pa09_value,
MAX(CASE WHEN param_id = 10 THEN param_value END)                                              AS pa10_value,
MAX(CASE WHEN param_id = 11 THEN param_value END)                                              AS pa11_value,
MAX(CASE WHEN param_id = 12 THEN COALESCE(param_value,'N/a') END)                              AS pa12_value,
MAX(CASE WHEN param_id = 13 THEN param_value END)                                              AS pa13_value,
MAX(CASE WHEN param_id = 14 THEN param_value END)                                              AS pa14_value,
MAX(CASE WHEN param_id = 15 THEN COALESCE(param_value,'<!-- ERROR IMG Tag  -->') END)          AS pa15_value,
MAX(CASE WHEN param_id = 16 THEN param_value END)                                              AS pa16_value,
MAX(CASE WHEN param_id = 17 THEN param_value END)                                              AS pa17_value,
MAX(CASE WHEN param_id = 18 THEN param_value END)                                              AS pa18_value,
MAX(CASE WHEN param_id = 19 THEN param_value END)                                              AS pa19_value,
MAX(CASE WHEN param_id = 20 THEN param_value END)                                              AS pa20_value,
MAX(CASE WHEN param_id = 21 THEN param_value END)                                              AS pa21_value,
MAX(CASE WHEN param_id = 22 THEN param_value END)                                              AS pa22_value,
MAX(CASE WHEN param_id = 23 THEN param_value END)                                              AS pa23_value,
MAX(CASE WHEN param_id = 24 THEN param_value END)                                              AS pa24_value,
MAX(CASE WHEN param_id = 25 THEN param_value END)                                              AS pa25_value,
MAX(CASE WHEN param_id = 26 THEN param_value END)                                              AS pa26_value
FROM p_lew_mart_analytics.v_pit_param
) AS pa
/* Keeping only the nearest related advertising week (no related week on item level needed) */
WHERE base.nearest_rltd_adv_week_fg = 1
;
