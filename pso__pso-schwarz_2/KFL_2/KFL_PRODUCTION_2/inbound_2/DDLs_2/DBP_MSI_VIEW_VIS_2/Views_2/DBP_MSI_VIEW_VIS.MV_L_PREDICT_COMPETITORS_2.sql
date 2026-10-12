CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_PREDICT_COMPETITORS_2
(
	MANDANT_ID,
	COMPETITOR_NAME,
	COMPETITOR_SORT_ID,
	COMPETITOR_SORT_NAME
) AS
SELECT DISTINCT
  mandant_id
 ,competitor_name
 ,CASE 
	--DE:
	WHEN mandant_id = 1 AND competitor_name LIKE '%Lidl%' THEN 10
	WHEN mandant_id = 1 AND competitor_name LIKE '%Edeka%' THEN 20
	WHEN mandant_id = 1 AND competitor_name LIKE '%Aldi Nord%' THEN 30 
	WHEN mandant_id = 1 AND competitor_name LIKE '%Aldi Süd%' THEN 40 
	WHEN mandant_id = 1 AND competitor_name LIKE '%Rewe%' THEN 50
	WHEN mandant_id = 1 AND competitor_name LIKE '%Globus%' THEN 60
	--CZ:
	WHEN mandant_id = 2 AND competitor_name LIKE '%Lidl%' THEN 10
	WHEN mandant_id = 2 AND competitor_name LIKE '%Albert%' THEN 20
	WHEN mandant_id = 2 AND competitor_name LIKE '%Penny%' THEN 30
	WHEN mandant_id = 2 AND competitor_name LIKE '%Tesco%' THEN 40
	WHEN mandant_id = 2 AND competitor_name LIKE '%Billa%' THEN 50
	WHEN mandant_id = 2 AND competitor_name LIKE '%Globus%' THEN 60
	--PL:
	WHEN mandant_id = 3 AND competitor_name LIKE '%Lidl%' THEN 10
	WHEN mandant_id = 3 AND competitor_name LIKE '%Biedronka%' THEN 20
	WHEN mandant_id = 3 AND competitor_name LIKE '%Auchan%' THEN 30
	WHEN mandant_id = 3 AND competitor_name LIKE '%Carrefour%' THEN 40
	WHEN mandant_id = 3 AND competitor_name LIKE '%Netto%' THEN 50
	WHEN mandant_id = 3 AND competitor_name LIKE '%Aldi%' THEN 60
	--MD:
	WHEN mandant_id = 4 AND competitor_name LIKE '%Linella%' THEN 10
	WHEN mandant_id = 4 AND competitor_name LIKE '%Metro%' THEN 20
	WHEN mandant_id = 4 AND competitor_name LIKE '%Green Hills%' THEN 30	
	WHEN mandant_id = 4 AND competitor_name LIKE '%Nr1%' THEN 40
	WHEN mandant_id = 4 AND competitor_name LIKE '%Fidesco%' THEN 50
	WHEN mandant_id = 4 AND competitor_name LIKE '%Fourchette%' THEN 60
	--SK:
	WHEN mandant_id = 5 AND competitor_name LIKE '%Lidl%' THEN 10
	WHEN mandant_id = 5 AND competitor_name LIKE '%COOP%' THEN 20
	WHEN mandant_id = 5 AND competitor_name LIKE '%Tesco%' THEN 30
	WHEN mandant_id = 5 AND competitor_name LIKE '%Billa%' THEN 40
	WHEN mandant_id = 5 AND competitor_name LIKE '%Fresh%' THEN 50
	WHEN mandant_id = 5 AND competitor_name LIKE '%Terno%' THEN 60
	--HR:
	WHEN mandant_id = 6 AND competitor_name LIKE '%Lidl%' THEN 10
	WHEN mandant_id = 6 AND competitor_name LIKE '%Konzum%' THEN 20
	WHEN mandant_id = 6 AND competitor_name LIKE '%Plodine%' THEN 30
	WHEN mandant_id = 6 AND competitor_name LIKE '%InterSpar%' THEN 40
	WHEN mandant_id = 6 AND competitor_name LIKE 'Spar%' THEN 50
	WHEN mandant_id = 6 AND competitor_name LIKE '%Tommy%' THEN 60
	--RO:
	WHEN mandant_id = 7 AND competitor_name LIKE '%Lidl%' THEN 10
	WHEN mandant_id = 7 AND competitor_name LIKE '%Carrefour%' THEN 20
	WHEN mandant_id = 7 AND competitor_name LIKE '%Profi%' THEN 30
	WHEN mandant_id = 7 AND competitor_name LIKE '%Penny%' THEN 40
	WHEN mandant_id = 7 AND competitor_name LIKE '%Auchan%' THEN 50
	WHEN mandant_id = 7 AND competitor_name LIKE '%Mega Image%' THEN 60
	--BG:
	WHEN mandant_id = 8 AND competitor_name LIKE '%Lidl%' THEN 10
	WHEN mandant_id = 8 AND competitor_name LIKE '%Billa%' THEN 20
	WHEN mandant_id = 8 AND competitor_name LIKE '%Fantastico%' THEN 30
	WHEN mandant_id = 8 AND competitor_name LIKE '%T-Market%' THEN 40
	WHEN mandant_id = 8 AND competitor_name LIKE '%CBA%' THEN 50
	WHEN mandant_id = 8 AND competitor_name LIKE '%Metro%' THEN 60
  ELSE 99
  END AS competitor_sort_id 
  
 ,CASE /* group names */
    WHEN mandant_id = 1 AND competitor_name LIKE '%Aldi%' THEN 'Aldi'
    WHEN mandant_id = 6 AND competitor_name LIKE '%Spar%' THEN 'Interspar'
  ELSE competitor_name
  END AS competitor_sort_name
  
FROM dbp_view.v_predict_competitors_2;