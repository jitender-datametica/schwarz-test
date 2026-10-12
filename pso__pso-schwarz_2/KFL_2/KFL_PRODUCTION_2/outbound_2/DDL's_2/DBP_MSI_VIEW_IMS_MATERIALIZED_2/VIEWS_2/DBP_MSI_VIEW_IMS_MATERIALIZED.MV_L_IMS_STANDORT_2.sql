-- 04.04.2013 twie: Lookup Standort, Daten wenn vorhanden aus wup_2, sonst aus standort

-- 19.06.2013 AL bei Dummy_2 WUP_2 =-1 keine Info aus wup_2 übernehmen wup_2

-- 14.01.2014 twie: neue Spalte umsatz_ea_land aus wup_2
 -- 09.07.2013 AL nicht vorhandene wup_id als 0 ausgeben

-- 11.09.2013 AL datenquelle_kz Spalte aufgenommen

-- 03.07.2013 AL kein nb_id aus wup_2 übernehmen, Join auf wup_id rausgenommen

-- 29.05.2013 twie: Filialattribute, Flächen etc. entfernt, wird in Planungselement Lookup ermittelt

-- 04.07.2013 twie: weitere Felder aus standort ausgeben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.mv_l_ims_standort_2 (mandant_id, standort_id, wup_id,
standort_name, sparte_id, eigentum_kz, umzugsfiliale_fg, neu_standort_fg, ginfo_markt_typ, umsatz_ea, umsatz_ea_land,
verkaufsflaeche, konzessionaersflaeche, betriebsflaeche, datenquelle_kz) AS SELECT I.mandant_id,
 I.standort_id,
 COALESCE(W.wup_id, 0) AS wup_id,
 I.standort_name,
 I.sparte_id,
 COALESCE(I.eigentum_kz, -1) AS eigentum_kz,
 COALESCE(I.umzugsfiliale_fg, 0) AS umzugsfiliale_fg,
 COALESCE(I.neu_standort_fg, 0) AS neu_standort_fg,
 COALESCE(I.ginfo_markt_typ, '') AS ginfo_markt_typ,
 COALESCE(I.umsatz_ea, 0) AS umsatz_ea,
 COALESCE(W.umsatz_ea_land, 0) AS umsatz_ea_land,
 COALESCE(I.verkaufsflaeche, 0) AS verkaufsflaeche,
 COALESCE(I.konzessionaersflaeche, 0) AS konzessionaersflaeche,
 COALESCE(I.betriebsflaeche, 0) AS betriebsflaeche,
 I.datenquelle_kz
FROM kfl_production_dbp_view.v_ims_standort_2 AS I
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS W ON I.wup_id = W.wup_id AND I.mandant_id = W.mandant_id;