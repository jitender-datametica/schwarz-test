CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_wbl_frische
AS
-- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
-- 2021-03-05 ssch0611 : Review after MA-Update (reference wup_denorm)
SELECT
mandant_id,
ma_id          AS wbl_frische_id,
Max(ma_ldap)   AS ma_ldap,
Max(email)     AS ma_email,
Max(mobil_tel) AS ma_tel,
Max(CASE WHEN spr_id = 22 THEN msz.ma_name END)    AS ma_name_de,
Max(CASE WHEN spr_id = 22 THEN msz.ma_vorname END) AS ma_vorname_de,
Max(CASE WHEN spr_id = 22 THEN msz.ma_anrede END)  AS ma_anrede_de,
ma_name_de                                                                     AS ma_name,
ma_vorname_de                                                                  AS ma_vorname,
Coalesce(Max(CASE
WHEN spr_id = 124 THEN msz.ma_name END), 
 ma_name_de)       AS ma_name_cz,
Coalesce(Max(CASE
WHEN spr_id = 124 THEN msz.ma_vorname END), 
 ma_vorname_de) AS ma_vorname_cz,
Coalesce(Max(CASE
WHEN spr_id = 108 THEN msz.ma_name END), 
 ma_name_de)       AS ma_name_sk,
Coalesce(Max(CASE
WHEN spr_id = 108 THEN msz.ma_vorname END), 
 ma_vorname_de) AS ma_vorname_sk,
Coalesce(Max(CASE
WHEN spr_id = 65 THEN msz.ma_name END), 
 ma_name_de)        AS ma_name_hr,
Coalesce(Max(CASE
WHEN spr_id = 65 THEN msz.ma_vorname END), 
 ma_vorname_de)  AS ma_vorname_hr,
Coalesce(Max(CASE
WHEN spr_id = 90 THEN msz.ma_name END), 
 ma_name_de)        AS ma_name_pl,
Coalesce(Max(CASE
WHEN spr_id = 90 THEN msz.ma_vorname END), 
 ma_vorname_de)  AS ma_vorname_pl,
Coalesce(Max(CASE
WHEN spr_id = 95 THEN msz.ma_name END), 
 ma_name_de)        AS ma_name_ro,
Coalesce(Max(CASE
WHEN spr_id = 95 THEN msz.ma_vorname END), 
 ma_vorname_de)  AS ma_vorname_ro,
Coalesce(Max(CASE
WHEN spr_id = 18 THEN msz.ma_name END), 
 ma_name_de)        AS ma_name_bg,
Coalesce(Max(CASE
WHEN spr_id = 18 THEN msz.ma_vorname END), 
 ma_vorname_de)  AS ma_vorname_bg,
/* helper/default/unused*/

ma_anrede_de                                                                   AS ma_anrede,
Coalesce(Max(CASE WHEN spr_id = 124 THEN msz.ma_anrede END), ma_anrede_de)   AS ma_anrede_cz,
Coalesce(Max(CASE WHEN spr_id = 108 THEN msz.ma_anrede END), ma_anrede_de)   AS ma_anrede_sk,
Coalesce(Max(CASE WHEN spr_id = 65 THEN msz.ma_anrede END),  ma_anrede_de)    AS ma_anrede_hr,
Coalesce(Max(CASE WHEN spr_id = 90 THEN msz.ma_anrede END),  ma_anrede_de)    AS ma_anrede_pl,
Coalesce(Max(CASE WHEN spr_id = 95 THEN msz.ma_anrede END), ma_anrede_de)    AS ma_anrede_ro,
Coalesce(Max(CASE WHEN spr_id = 18 THEN msz.ma_anrede END),  ma_anrede_de)    AS ma_anrede_bg

FROM (SELECT
mandant_id,
ma_id,
ma_name,
ma_vorname,
ma_anrede,
email,
mobil_tel,
ma_ldap,
spr_id
FROM dbp_view.v_ma_spr_zu
WHERE (mandant_id, ma_id) IN (SELECT
mandant_id,
wbl_frische_id
FROM dbp_msi_v_view.v_wup_denorm
)
UNION ALL  -- Dummy WBL per Land

SELECT
mandant_id,
-1::INTEGER,
'--',
'',
'',
'',
'',
'',
22
FROM dbp_view.v_mandant
) msz

GROUP BY msz.mandant_id, msz.ma_id;
