CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_ims_standort_2 AS SELECT I.mandant_id,
 I.standort_id,
 COALESCE(W.wup_id, 0) AS wup_id,
 I.standort_name,
 I.sparte_id,
 COALESCE(I.eigentum_kz, - 1) AS eigentum_kz,
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