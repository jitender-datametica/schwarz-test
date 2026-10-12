CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_EINKAUFSPREISSTAMM_AKT_1 
   (
	MANDANT_ID,
	ART_ID,
	EK_NETTONETTO,
	EINSTANDSPREIS,
	UMRECHNUNGSKURS
   ) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
   AS 
   SELECT
   v01.mandant_id,
   v01.art_id,
   ek_nettonetto,
   einstandspreis,
   v300.umrechnungskurs
   FROM
   (
   SELECT    v011.mandant_id,
   v011.art_id,
   v011.ek_nettonetto,
   v011.einstandspreis

   FROM dbp_view.v_art_gp_wup_zu_per_1 v011
   INNER JOIN

   (SELECT mandant_id,
   art_id,
   gp_id,
   COUNT (*) anz_wup
  FROM dbp_view.v_art_gp_nm_zu_per_1 v011
   WHERE  dat_bis='9999-12-31'
   GROUP BY  mandant_id, art_id, gp_id
   QUALIFY  ROW_NUMBER() OVER (PARTITION BY v011.mandant_id, v011.art_id  ORDER BY anz_wup DESC NULLS LAST) = 1 )   v014
   ON   v011.art_id = v014.art_id
   AND v011.mandant_id = v014.mandant_id
   AND v011.gp_id = v014.gp_id

   WHERE  v011.wup_id  =-1
   AND  v011.dat_bis='9999-12-31'
   ) v01

   JOIN dbp_view.v_mandant_1 v100
   ON  v01.mandant_id = v100.mandant_id
   
   -- AP0202325/SPEC0286323 Erweiterung nur akt. Berichtskurs, da es kein Datum gibt und nur aktuelle Preis angezeigt werden sollen / sschuecke 10.01.2025
   -- Umrechnung Aktuell Standardkurs, Tageskurs
   /*JOIN dbp_view.v_kurs_1 v300
   ON  CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/
   
    -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v300
   ON v300.dat_bis = '9999-12-31'
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   WHERE v01.mandant_id >1
   ;