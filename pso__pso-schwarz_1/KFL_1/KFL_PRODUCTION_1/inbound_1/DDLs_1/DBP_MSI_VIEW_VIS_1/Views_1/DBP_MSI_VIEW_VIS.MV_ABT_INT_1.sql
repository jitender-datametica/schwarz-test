CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT_INT_1 (
	ARTHIERTYP_ID,
	ABT_ID,
	SORT_ID,
	ORIG_SORT_ID
) AS 
 
/*
	LOOKUP : Abteilung International
	2015.0907 srom: neue View ohne mandant_1
	2017.0314 ssch0611 : neue Struktur HWG/Abteilung
	2018.09 : WG Refresh
	2024-09-04 : Sortierung + Review
*/
 
SELECT
  abt.arthiertyp_id
, abt.abt_id
, CASE 
	WHEN abt.abt_id = 0 THEN 100
	WHEN abt.abt_id = 4 THEN 10
	ELSE abt.abt_id 
  END ::SMALLINT AS sort_id
, CASE WHEN abt.abt_id < 5 THEN 1000 - abt_id ELSE abt.abt_id END ::SMALLINT AS orig_sort_id
FROM dbp_view.v_abt_per_1 abt_1
 
WHERE abt.arthiertyp_id = 2 AND abt.dat_bis = '9999-12-31'
 
GROUP BY ALL;