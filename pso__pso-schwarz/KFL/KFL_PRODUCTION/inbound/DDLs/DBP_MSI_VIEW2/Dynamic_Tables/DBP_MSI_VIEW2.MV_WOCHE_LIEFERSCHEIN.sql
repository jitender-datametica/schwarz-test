CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_WOCHE_LIEFERSCHEIN
(
	KJWO,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	DATEINUM,
	DATEINUM_MAX,
	REFERENZNUMMER_BEZ,
	LIEFERSCHEIN_NR,
	SCHICKEN_DAT,
	GULTIG_VON,
	GULTIG_BIS,
	BURDA_BELEG_DAT
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
kjwo, 
wup_id, 
nb_id, 
mandant_id, 
(KW) || (TRIM(dateinum)) || (YY)  AS dateinum, (KW) || TRIM(MAX(dateinum) OVER (PARTITION BY kjwo)) || (YY)  AS dateinum_max, 
'KW '|| SUBSTRING(CAST(kjwo AS INTEGER), 10, 2)||'/'|| SUBSTRING(CAST(kjwo AS INTEGER), 6, 4) || '; ' || 'Referenz =' || ' ' || (KW) || (TRIM(dateinum)) || (YY) || 'XXXX' AS referenznummer_bez, 
(KW) || (TRIM(dateinum)) || (YY) || TRIM(wup_id) AS lieferschein_nr, schicken_dat, gultig_von, gultig_bis, burda_beleg_dat

FROM
   (
   SELECT
   kjwo, 
   akt_mo, 
   SUBSTR(CAST(kjwo AS CHAR(6)),5,2) AS KW, 
   SUBSTR(CAST(kjwo AS CHAR(6)),3,2) AS YY, 
   ROW_NUMBER() OVER ( PARTITION BY kjwo  ORDER BY akt_mo ) AS dateinum, 
   MIN(min_dat) OVER ( PARTITION BY kjwo ) AS burda_beleg_dat, 
   CASE WHEN  EXTRACT (MONTH FROM max_dat ) <> EXTRACT (MONTH FROM  max_dat +1 ) AND  anz_tage <> 7 THEN max_dat+2 ELSE max_dat +1 END AS schicken_dat, 
   min_dat AS gultig_von, 
   max_dat  AS gultig_bis

   FROM
   (
   SELECT
   v01.kjwo, 
   v01.akt_mo, 
   MAX(v01.dat) max_dat, 
   MIN(v01.dat) min_dat, 
   COUNT(*)  anz_tage
   
   FROM dbp_view.v_tag v01
   GROUP BY
   kjwo
   ,akt_mo
   ) t
   ) tab
CROSS JOIN dbp_view.v_wup v01
WHERE v01.mandant_id = 1;
