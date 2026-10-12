CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_gf_1
AS
-- 2012-11-22 Review + Dummy_1
-- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
-- 2017.0601 ssch0611 : Korrektur durch Umstellung von wup_denorm_1 auf wup_1
-- 2021-03-05 ssch0611 : Review after MA-Update (reference wup_1)
SELECT
mandant_id,
ma_id         AS gf_id,
Max(ma_ldap)   AS ma_ldap,
Max(email)     AS ma_email,
Max(mobil_tel) AS ma_tel,
/* deutsch/default*/
Max(CASE WHEN spr_id = 22 THEN msz.ma_name END)    AS ma_name_de,
Max(CASE WHEN spr_id = 22 THEN msz.ma_vorname END) AS ma_vorname_de,
Max(CASE WHEN spr_id = 22 THEN msz.ma_anrede END)  AS ma_anrede_de,

ma_name_de    AS ma_name,
ma_vorname_de AS ma_vorname,
ma_anrede_de  AS ma_anrede,
Coalesce(Max(CASE WHEN spr_id = 124 THEN msz.ma_name END),  ma_name_de)       AS ma_name_cz,
Coalesce(Max(CASE WHEN spr_id = 124 THEN msz.ma_vorname END), ma_vorname_de) AS ma_vorname_cz,
Coalesce(Max(CASE WHEN spr_id = 124 THEN msz.ma_anrede END),  ma_anrede_de)   AS ma_anrede_cz,
Coalesce(Max(CASE WHEN spr_id = 108 THEN msz.ma_name END), ma_name_de)       AS ma_name_sk,
Coalesce(Max(CASE WHEN spr_id = 108 THEN msz.ma_vorname END),  ma_vorname_de) AS ma_vorname_sk,
Coalesce(Max(CASE WHEN spr_id = 108 THEN msz.ma_anrede END), ma_anrede_de)   AS ma_anrede_sk,
Coalesce(Max(CASE WHEN spr_id = 65 THEN msz.ma_name END),  ma_name_de)        AS ma_name_hr,
Coalesce(Max(CASE WHEN spr_id = 65 THEN msz.ma_vorname END), ma_vorname_de)  AS ma_vorname_hr,
Coalesce(Max(CASE WHEN spr_id = 65 THEN msz.ma_anrede END),  ma_anrede_de)    AS ma_anrede_hr,
Coalesce(Max(CASE WHEN spr_id = 90 THEN msz.ma_name END), ma_name_de)        AS ma_name_pl,
Coalesce(Max(CASE WHEN spr_id = 90 THEN msz.ma_vorname END), ma_vorname_de)  AS ma_vorname_pl,
Coalesce(Max(CASE
WHEN spr_id = 90 THEN msz.ma_anrede END), ma_anrede_de)    AS ma_anrede_pl,
Coalesce(Max(CASE WHEN spr_id = 95 THEN msz.ma_name END),  ma_name_de)        AS ma_name_ro,
Coalesce(Max(CASE WHEN spr_id = 95 THEN msz.ma_vorname END), ma_vorname_de)  AS ma_vorname_ro,
Coalesce(Max(CASE WHEN spr_id = 95 THEN msz.ma_anrede END),  ma_anrede_de)    AS ma_anrede_ro,
Coalesce(Max(CASE WHEN spr_id = 18 THEN msz.ma_name END), ma_name_de)        AS ma_name_bg,
Coalesce(Max(CASE WHEN spr_id = 18 THEN msz.ma_vorname END), ma_vorname_de)  AS ma_vorname_bg,
Coalesce(Max(CASE WHEN spr_id = 18 THEN msz.ma_anrede END), ma_anrede_de)    AS ma_anrede_bg

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
FROM dbp_view.v_ma_spr_zu_1
WHERE (mandant_id, ma_id) IN (SELECT
mandant_id,
gf_id
FROM dbp_view.v_wup_1
 WHERE nb_id IN (0, -1, 2, 7)
)
UNION ALL -- Dummy_1 GF_1 pro Region_1

SELECT
mandant_id,
(1000 + mandant_id * 100 + vs_id * 10) * -1::INTEGER,
'--',
'',
'',
'',
'',
'',
22
FROM dbp_view.v_vs_1
) msz

GROUP BY msz.mandant_id, msz.ma_id;
