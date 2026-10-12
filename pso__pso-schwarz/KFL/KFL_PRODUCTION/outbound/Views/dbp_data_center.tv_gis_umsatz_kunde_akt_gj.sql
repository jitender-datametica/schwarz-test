CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_gis_umsatz_kunde_akt_gj (gj, iso_code, wup_id,
umsatz_netto_land, umsatz_brutto_land, umsatz_netto_eur, umsatz_brutto_eur, ums_netto_plan_land, ums_netto_plan_eur,
kunden, durchschnitt_bon_netto_land, durchschnitt_bon_brutto_land, durchschnitt_bon_netto_eur,
durchschnitt_bon_brutto_eur, umsatz_vt_netto_eur, umsatz_vt_netto_land, durchschnitt_bon_vt_netto_eur,
durchschnitt_bon_vt_netto_land) AS SELECT sub_ek.gj,
  CASE
  WHEN sub_ek.mandant_id = 1
  THEN 'DEU'
  WHEN sub_ek.mandant_id = 2
  THEN 'CZE'
  WHEN sub_ek.mandant_id = 3
  THEN 'POL'
  WHEN sub_ek.mandant_id = 4
  THEN 'MDA'
  WHEN sub_ek.mandant_id = 5
  THEN 'SVK'
  WHEN sub_ek.mandant_id = 6
  THEN 'HRV'
  WHEN sub_ek.mandant_id = 7
  THEN 'ROU'
  WHEN sub_ek.mandant_id = 8
  THEN 'BGR'
  ELSE NULL
  END AS iso_code,
 sub_ek.wup_id,
 sub_ek.umsatz_netto_land,
 sub_ek.umsatz_brutto_land,
 sub_ek.umsatz_netto_eur,
 sub_ek.umsatz_brutto_eur,
 sub_vt.ums_netto_plan_land,
 sub_vt.ums_netto_plan_eur,
 sub_vt.kunden,
  sub_ek.umsatz_netto_land / IF(sub_vt.kunden = 0, NULL, sub_vt.kunden) AS durchschnitt_bon_netto_land,
  sub_ek.umsatz_brutto_land / IF(sub_vt.kunden = 0, NULL, sub_vt.kunden) AS durchschnitt_bon_brutto_land,
  sub_ek.umsatz_netto_eur / IF(sub_vt.kunden = 0, NULL, sub_vt.kunden) AS durchschnitt_bon_netto_eur,
  sub_ek.umsatz_brutto_eur / IF(sub_vt.kunden = 0, NULL, sub_vt.kunden) AS durchschnitt_bon_brutto_eur,
 sub_vt.ums_vt_netto_eur AS umsatz_vt_netto_eur,
 sub_vt.ums_vt_netto_land AS umsatz_vt_netto_land,
  sub_vt.ums_vt_netto_eur / IF(sub_vt.kunden = 0, NULL, sub_vt.kunden) AS durchschnitt_bon_vt_netto_eur,
  sub_vt.ums_vt_netto_land / IF(sub_vt.kunden = 0, NULL, sub_vt.kunden) AS durchschnitt_bon_vt_netto_land
FROM (SELECT AIS.mandant_id,
   WUP.aktuell_wup_id AS wup_id,
   ZEIT.gj,
   SUM(AIS.umsatz_netto) AS umsatz_netto_land,
   SUM(AIS.umsatz_netto + AIS.umsatz_mwst_betrag) AS umsatz_brutto_land,
   SUM(COALESCE(AIS.diff_umsatz_netto_konz, AIS.umsatz_netto)) AS umsatz_netto_eur,
   SUM(COALESCE(AIS.diff_umsatz_netto_konz + AIS.diff_umsatz_mwst_betrag_konz, AIS.umsatz_netto + AIS.umsatz_mwst_betrag
      )) AS umsatz_brutto_eur
  FROM kfl_production_dbp_data.artbew_wg_tp2_sum AS AIS
   INNER JOIN kfl_production_dbp_data.wup AS WUP ON AIS.mandant_id = WUP.mandant_id AND AIS.wup_id = WUP.wup_id
   INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT ON AIS.dat = ZEIT.dat
  WHERE ZEIT.akt_gj = 0
  GROUP BY AIS.mandant_id,
   wup_id,
   ZEIT.gj) AS sub_ek
 LEFT JOIN (SELECT VIS.mandant_id,
   VIS.wup_id,
   ZEIT0.gj,
   SUM(CASE
     WHEN VIS.wrg_id <> 'EUR' OR LAND.default_wrg = 'EUR'
     THEN VIS.ums_netto_plan
     ELSE NULL
     END) AS ums_netto_plan_land,
   SUM(CASE
     WHEN VIS.wrg_id = 'EUR'
     THEN VIS.ums_netto_plan
     ELSE NULL
     END) AS ums_netto_plan_eur,
   SUM(CASE
     WHEN VIS.wrg_id = 'EUR'
     THEN VIS.anz_kunde
     ELSE NULL
     END) AS kunden,
   SUM(CASE
     WHEN VIS.wrg_id <> 'EUR' OR LAND.default_wrg = 'EUR'
     THEN VIS.ums_netto
     ELSE NULL
     END) AS ums_vt_netto_land,
   SUM(CASE
     WHEN VIS.wrg_id = 'EUR'
     THEN VIS.ums_netto
     ELSE NULL
     END) AS ums_vt_netto_eur
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wup AS VIS
   INNER JOIN kfl_production_dbp_data.mandant AS LAND ON VIS.mandant_id = LAND.mandant_id
   INNER JOIN kfl_production_dbp_data.monat AS ZEIT0 ON VIS.kjmo = ZEIT0.kjmo
  WHERE VIS.nb_id = 0
   AND ZEIT0.akt_gj = 0
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   ZEIT0.gj) AS sub_vt ON sub_ek.mandant_id = sub_vt.mandant_id AND sub_ek.wup_id = sub_vt.wup_id AND sub_ek.gj = sub_vt
   .gj
WHERE sub_ek.umsatz_netto_land > 0;