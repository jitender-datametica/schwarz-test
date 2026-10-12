CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IMS_STANDORT_2 AS
-- 04.04.2013 twie: Lookup Standort, Daten wenn vorhanden aus wup_2, sonst aus standort
-- 29.05.2013 twie: Filialattribute, Flächen etc. entfernt, wird in Planungselement Lookup ermittelt
-- 19.06.2013 AL bei Dummy_2 WUP_2 =-1 keine Info aus wup_2 übernehmen wup_2
-- 03.07.2013 AL kein nb_id aus wup_2 übernehmen, Join auf wup_id rausgenommen
-- 04.07.2013 twie: weitere Felder aus standort ausgeben
-- 09.07.2013 AL nicht vorhandene wup_id als 0 ausgeben
-- 11.09.2013 AL datenquelle_kz Spalte aufgenommen
-- 14.01.2014 twie: neue Spalte umsatz_ea_land aus wup_2

   SELECT

   i.mandant_id,
   i.standort_id,
   COALESCE(w.wup_id, 0) AS wup_id,
   i.standort_name,
   i.sparte_id,
   COALESCE (i.eigentum_kz, -1) AS eigentum_kz,
   COALESCE (i.umzugsfiliale_fg, 0) AS umzugsfiliale_fg,
   COALESCE (i.neu_standort_fg, 0) AS neu_standort_fg,
   COALESCE (i.ginfo_markt_typ, '') AS ginfo_markt_typ,
   COALESCE (i.umsatz_ea, 0) AS umsatz_ea,
   COALESCE (w.umsatz_ea_land, 0) AS umsatz_ea_land,
   COALESCE (i.verkaufsflaeche, 0) AS verkaufsflaeche,
   COALESCE (i.konzessionaersflaeche, 0)      AS konzessionaersflaeche,
   COALESCE (i.betriebsflaeche, 0)  AS betriebsflaeche,
   i.datenquelle_kz

   FROM dbp_view.v_ims_standort_2 i
   LEFT OUTER JOIN dbp_view.v_wup_2 w
   ON i.wup_id =w.wup_id AND
   i.mandant_id =w.mandant_id;