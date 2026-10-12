-- 2012KW04 TBac: Erweiterung um Brutto-Spalten und Kundenspalten pro Bedienkonzept

-- 2021-03-05 ssch0611 : added transformations kunde_vvj, removed kum, removed bedienkonzept

-- FAKT-AGGREGAT Umsatz/Kunden/Offen pro Filiale/Tag_1
 -- 2011KW07 INITIAL
 -- Datenumfang:  10 GJ

-- 2019.0314 ssch0611 : Erweiterung ums_netto_plan_extern

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wup_transform_1 (mandant_id, nb_id, wup_id, wrg_id
, dat, akt_tag, ums_netto, ums_netto_plan, ums_netto_plan_extern, ums_netto_plan_x, ums_netto_wvj, ums_netto_wvvj,
ums_netto_kvj, ums_netto_kvvj, anz_kunde, anz_kunde_wvj, anz_kunde_wvvj, anz_kunde_kvj, anz_kunde_kvvj, anz_offen,
anz_offen_wvj, anz_offen_wvvj, anz_offen_kvj, anz_offen_kvvj, ums_brutto, ums_brutto_wvj, ums_brutto_wvvj,
ums_brutto_kvj, ums_brutto_kvvj) AS SELECT VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
 VIS.dat,
 VIS.akt_tag,
 VIS.ums_netto,
 VIS.ums_netto_plan,
 VIS.ums_netto_plan_extern,
  CASE
  WHEN VIS.ums_netto_plan_extern <> 0
  THEN VIS.ums_netto_plan_extern
  ELSE VIS.ums_netto_plan
  END AS ums_netto_plan_x,
 VIS.ums_netto_wvj,
 VIS.ums_netto_wvvj,
 VIS.ums_netto_kvj,
 VIS.ums_netto_kvvj,
 VIS.anz_kunde,
 VIS.anz_kunde_wvj,
 VIS_WVVJ.anz_kunde AS anz_kunde_wvvj,
 VIS.anz_kunde_kvj,
 VIS_KVVJ.anz_kunde AS anz_kunde_kvvj,
 VIS.anz_offen,
 VIS.anz_offen_wvj,
 VIS.anz_offen_wvvj,
 VIS.anz_offen_kvj,
 VIS.anz_offen_kvvj,
 VIS.ums_brutto,
 VIS.ums_brutto_wvj,
 VIS.ums_brutto_wvvj,
 VIS.ums_brutto_kvj,
 VIS.ums_brutto_kvvj
FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_1 AS VIS
 LEFT JOIN kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_1 AS VIS_WVVJ ON VIS.mandant_id = VIS_WVVJ.mandant_id
    AND VIS.wup_id = VIS_WVVJ.wup_id AND VIS.wrg_id = VIS_WVVJ.wrg_id AND VIS_WVVJ.dat = DATE_SUB(VIS.dat, INTERVAL 728
    DAY)
 LEFT JOIN kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_1 AS VIS_KVVJ ON VIS.mandant_id = VIS_KVVJ.mandant_id
    AND VIS.wup_id = VIS_KVVJ.wup_id AND VIS.wrg_id = VIS_KVVJ.wrg_id AND VIS_KVVJ.dat = IF(VIS.dat = LAST_DAY(VIS.dat)
    , LAST_DAY(DATE_ADD(VIS.dat, INTERVAL -24 MONTH)), DATE_ADD(VIS.dat, INTERVAL -24 MONTH));