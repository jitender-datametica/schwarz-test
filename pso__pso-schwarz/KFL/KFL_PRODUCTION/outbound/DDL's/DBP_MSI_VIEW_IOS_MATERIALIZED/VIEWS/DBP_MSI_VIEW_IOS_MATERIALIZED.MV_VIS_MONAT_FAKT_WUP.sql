CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_vis_monat_fakt_wup (mandant_id, nb_id, wup_id, rpm_immobilie_id
, vs_id, kjmo, umsatz_netto, umsatz_netto_vj, umsatz_netto_vvj, umsatz_netto_plan, expansionsbereinigung_dat,
dat_eroeffnung, umsatz_netto_plan_euro, umsatz_netto_vj_euro) AS -- Ermittlung der eingestellter Währung
 SELECT V01.mandant_id
 ,
 V01.nb_id,
 V01.wup_id,
 V01.rpm_hierarchie_id AS rpm_immobilie_id,
 V01.vs_id,
 V01.kjmo -- , v01.wrg_id                AS umsatz_wrg
,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.ums_netto, 0)
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ums_netto, 0) / V300.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS umsatz_netto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.ums_netto_kvj, 0)
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ums_netto_kvj, 0) / V300.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS umsatz_netto_vj,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.ums_netto_kvvj, 0)
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ums_netto_kvvj, 0) / V300.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS umsatz_netto_vvj,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.ums_netto_plan, 0)
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ums_netto_plan, 0) / V300.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS umsatz_netto_plan,
 V01.expansionsbereinigung_dat,
 V01.dat_eroeffnung,
 V01.umsatz_netto_plan_euro,
 V01.umsatz_netto_vj_euro -- umsatzentwicklung

FROM dbp_msi_view_ios_materialized.tbl_mv_vis_monat_fakt_wup AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN dbp_msi_view_ios_materialized.mv_mandant AS V250 ON V01.mandant_id = V250.mandant_id
  -- Umrechnung Standardkurs, Berichtkurs

 INNER JOIN dbp_msi_view_ios_materialized.mv_kurs AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V250.default_wrg =
     V300.von_wrg_id AND V300.kurstyp_id = 3 AND V01.wrg_id = V300.nach_wrg_id;