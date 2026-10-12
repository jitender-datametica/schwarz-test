CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_regionale_psb
AS
-- 2021-03-05 ssch0611 : Review after MA-Update (reference wup_denorm) - DE only
SELECT
mandant_id,
ma_id          AS regionale_psb_id,
Max(ma_ldap)   AS ma_ldap,
Max(email)     AS ma_email,
Max(mobil_tel) AS ma_tel,
Max(CASE
WHEN spr_id = 22 THEN msz.ma_name END)    AS ma_name,
Max(CASE
WHEN spr_id = 22 THEN msz.ma_vorname END) AS ma_vorname,
Max(CASE
WHEN spr_id = 22 THEN msz.ma_anrede END)  AS ma_anrede
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
regionale_psb_id
FROM dbp_msi_v_view.v_wup_denorm
)
UNION ALL  -- Dummy PSB pro Land

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
