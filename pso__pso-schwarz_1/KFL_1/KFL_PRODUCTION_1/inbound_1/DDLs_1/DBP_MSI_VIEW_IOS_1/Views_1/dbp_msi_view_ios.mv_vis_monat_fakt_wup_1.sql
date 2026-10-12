CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_vis_monat_fakt_wup_1
(
mandant_id
, nb_id
, wup_id
, rpm_immobilie_id
, vs_id
, kjmo
, umsatz_netto
, umsatz_netto_vj
, umsatz_netto_vvj
, umsatz_netto_plan
, expansionsbereinigung_dat
, dat_eroeffnung
, umsatz_netto_plan_euro
, umsatz_netto_vj_euro
)
AS

SELECT
v01.mandant_id
, v01.nb_id
, v01.wup_id
, v01.rpm_hierarchie_id
, v01.vs_id
, v01.kjmo
--, v01.wrg_id                AS umsatz_wrg
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto   ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto_kvj   ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto_kvj   ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto_vj
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto_kvvj    ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto_kvvj    ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto_vvj
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto_plan   ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto_plan   ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto_plan

, v01.expansionsbereinigung_dat

, v01.dat_eroeffnung
, v01.umsatz_netto_plan_euro
, v01.umsatz_netto_vj_euro

--umsatzentwicklung
FROM dbp_msi_view_ios.tbl_mv_vis_monat_fakt_wup_1 v01
-- Ermittlung der eingestellter Währung

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200

JOIN dbp_msi_view_ios.mv_mandant_1 v250
ON v01.mandant_id = v250.mandant_id

-- Umrechnung Standardkurs, Berichtkurs
JOIN  dbp_msi_view_ios.mv_kurs_1 v300
ON v300.dat_bis = '9999-12-31'
AND v250.default_wrg = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id = v01.wrg_id
;