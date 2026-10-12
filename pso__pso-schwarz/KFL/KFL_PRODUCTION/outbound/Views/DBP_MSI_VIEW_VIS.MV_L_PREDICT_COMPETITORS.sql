CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_predict_competitors (mandant_id, competitor_name,
competitor_sort_id, competitor_sort_name) AS SELECT DISTINCT mandant_id,
 competitor_name,
  CASE
  WHEN mandant_id = 1 AND competitor_name LIKE '%Lidl%'
  THEN 10
  WHEN mandant_id = 1 AND competitor_name LIKE '%Edeka%'
  THEN 20
  WHEN mandant_id = 1 AND competitor_name LIKE '%Aldi Nord%'
  THEN 30
  WHEN mandant_id = 1 AND competitor_name LIKE '%Aldi Süd%'
  THEN 40
  WHEN mandant_id = 1 AND competitor_name LIKE '%Rewe%'
  THEN 50
  WHEN mandant_id = 1 AND competitor_name LIKE '%Globus%'
  THEN 60
  WHEN mandant_id = 2 AND competitor_name LIKE '%Lidl%'
  THEN 10
  WHEN mandant_id = 2 AND competitor_name LIKE '%Albert%'
  THEN 20
  WHEN mandant_id = 2 AND competitor_name LIKE '%Penny%'
  THEN 30
  WHEN mandant_id = 2 AND competitor_name LIKE '%Tesco%'
  THEN 40
  WHEN mandant_id = 2 AND competitor_name LIKE '%Billa%'
  THEN 50
  WHEN mandant_id = 2 AND competitor_name LIKE '%Globus%'
  THEN 60
  WHEN mandant_id = 3 AND competitor_name LIKE '%Lidl%'
  THEN 10
  WHEN mandant_id = 3 AND competitor_name LIKE '%Biedronka%'
  THEN 20
  WHEN mandant_id = 3 AND competitor_name LIKE '%Auchan%'
  THEN 30
  WHEN mandant_id = 3 AND competitor_name LIKE '%Carrefour%'
  THEN 40
  WHEN mandant_id = 3 AND competitor_name LIKE '%Netto%'
  THEN 50
  WHEN mandant_id = 3 AND competitor_name LIKE '%Aldi%'
  THEN 60
  WHEN mandant_id = 4 AND competitor_name LIKE '%Linella%'
  THEN 10
  WHEN mandant_id = 4 AND competitor_name LIKE '%Metro%'
  THEN 20
  WHEN mandant_id = 4 AND competitor_name LIKE '%Green Hills%'
  THEN 30
  WHEN mandant_id = 4 AND competitor_name LIKE '%Nr1%'
  THEN 40
  WHEN mandant_id = 4 AND competitor_name LIKE '%Fidesco%'
  THEN 50
  WHEN mandant_id = 4 AND competitor_name LIKE '%Fourchette%'
  THEN 60
  WHEN mandant_id = 5 AND competitor_name LIKE '%Lidl%'
  THEN 10
  WHEN mandant_id = 5 AND competitor_name LIKE '%COOP%'
  THEN 20
  WHEN mandant_id = 5 AND competitor_name LIKE '%Tesco%'
  THEN 30
  WHEN mandant_id = 5 AND competitor_name LIKE '%Billa%'
  THEN 40
  WHEN mandant_id = 5 AND competitor_name LIKE '%Fresh%'
  THEN 50
  WHEN mandant_id = 5 AND competitor_name LIKE '%Terno%'
  THEN 60
  WHEN mandant_id = 6 AND competitor_name LIKE '%Lidl%'
  THEN 10
  WHEN mandant_id = 6 AND competitor_name LIKE '%Konzum%'
  THEN 20
  WHEN mandant_id = 6 AND competitor_name LIKE '%Plodine%'
  THEN 30
  WHEN mandant_id = 6 AND competitor_name LIKE '%InterSpar%'
  THEN 40
  WHEN mandant_id = 6 AND competitor_name LIKE 'Spar%'
  THEN 50
  WHEN mandant_id = 6 AND competitor_name LIKE '%Tommy%'
  THEN 60
  WHEN mandant_id = 7 AND competitor_name LIKE '%Lidl%'
  THEN 10
  WHEN mandant_id = 7 AND competitor_name LIKE '%Carrefour%'
  THEN 20
  WHEN mandant_id = 7 AND competitor_name LIKE '%Profi%'
  THEN 30
  WHEN mandant_id = 7 AND competitor_name LIKE '%Penny%'
  THEN 40
  WHEN mandant_id = 7 AND competitor_name LIKE '%Auchan%'
  THEN 50
  WHEN mandant_id = 7 AND competitor_name LIKE '%Mega Image%'
  THEN 60
  WHEN mandant_id = 8 AND competitor_name LIKE '%Lidl%'
  THEN 10
  WHEN mandant_id = 8 AND competitor_name LIKE '%Billa%'
  THEN 20
  WHEN mandant_id = 8 AND competitor_name LIKE '%Fantastico%'
  THEN 30
  WHEN mandant_id = 8 AND competitor_name LIKE '%T-Market%'
  THEN 40
  WHEN mandant_id = 8 AND competitor_name LIKE '%CBA%'
  THEN 50
  WHEN mandant_id = 8 AND competitor_name LIKE '%Metro%'
  THEN 60
  ELSE 99
  END AS competitor_sort_id,
  CASE
  WHEN mandant_id = 1 AND competitor_name LIKE '%Aldi%'
  THEN 'Aldi'
  WHEN mandant_id = 6 AND competitor_name LIKE '%Spar%'
  THEN 'Interspar'
  ELSE competitor_name
  END AS competitor_sort_name
FROM kfl_production_dbp_view.v_predict_competitors;