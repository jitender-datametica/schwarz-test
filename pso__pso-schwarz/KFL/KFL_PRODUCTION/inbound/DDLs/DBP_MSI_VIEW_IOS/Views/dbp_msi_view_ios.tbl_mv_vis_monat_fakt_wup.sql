CREATE OR REPLACE VIEW dbp_msi_view_ios.tbl_mv_vis_monat_fakt_wup
AS

SELECT
v01.mandant_id
, v01.nb_id
, v01.wup_id
, v888.rpm_hierarchie_id
, COALESCE(v999.vs_id,0) AS vs_id
, v01.kjmo
--, v01.wrg_id                AS umsatz_wrg

,ADD_MONTHS (SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF (( (EXTRACT ( YEAR FROM CURRENT_DATE()) - 1900) * 10000 + 301 )), -24)
AS expansionsbereinigung_dat


, v999.dat_eroeffnung
, CAST(COALESCE(v01.ums_netto_plan, 0) AS DECIMAL(18,8)) AS umsatz_netto_plan_euro
, CAST(COALESCE(v01.ums_netto_kvj, 0) AS DECIMAL(18,8)) AS umsatz_netto_vj_euro

, v01.ums_netto -- necessary for CROSS JOIN 
, v01.ums_netto_kvj
, v01.ums_netto_kvvj
, v01.ums_netto_plan
, v01.wrg_id

--umsatzentwicklung
FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup v01
-- Ermittlung der eingestellter Währung


JOIN dbp_msi_view_ios.mv_mandant v250
ON v01.mandant_id = v250.mandant_id

-- Umrechnung Standardkurs, Berichtkurs
JOIN  dbp_msi_view_ios.mv_kurs v300
ON v300.dat_bis = '9999-12-31'
AND v250.default_wrg = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id = v01.wrg_id

inner JOIN  dbp_view.v_rpm_immobilie_per v888
ON v01.wup_id = v888.wup_id
AND v01.nb_id = v888.nb_id
AND v01.mandant_id = v888.mandant_id
AND v888.dat_bis =  '9999-12-31'

JOIN  dbp_msi_view_ios.mv_wup v999
ON v01.wup_id = v999.wup_id
AND v01.nb_id = v999.nb_id
AND v01.mandant_id = v999.mandant_id

JOIN
(
SELECT
v98.wup_id
, v98.nb_id
, v98.mandant_id
,  ((  CAST ((MIN(kjmo) / 100) AS INTEGER) -1900) *10000) + (MOD(MIN(kjmo), 100)) * 100 + 1 AS min_kjmo_wup_umsatz

FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup  v98

GROUP BY
v98.wup_id
, v98.nb_id
, v98.mandant_id
) v97
ON v97.wup_id = v999.wup_id
AND v97.nb_id = v999.nb_id
AND v97.mandant_id = v999.mandant_id

WHERE v01.wrg_id = 'EUR';
