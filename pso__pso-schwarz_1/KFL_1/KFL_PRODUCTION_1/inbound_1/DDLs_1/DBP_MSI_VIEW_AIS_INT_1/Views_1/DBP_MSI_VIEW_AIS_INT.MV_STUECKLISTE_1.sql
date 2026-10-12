CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_STUECKLISTE_1(
	MANDANT_ID,
	STUECKLISTE_ID,
	DAT,
	KJWO_KL,
	KOMPONENTE_DAT_VON,
	KOMPONENTE_DAT_BIS,
	DISPLAY_ART_ID,
	ART_ID,
	KOMPONENTENMENGE,
	KOMPONENTENMENGE_EINH_ID,
	GP_ID,
	DISPLAY_FLAG,
	STUECKLISTE_ANTEIL,
	ANZAHL_KOMPONENTENMENGE_GESAMT
) AS
--AP0210596/SPEC0280480 Erweiterung um Spalte gp_id / prescherad 16.12.2024
--AP0210596/SPEC0313328 Filtern auf Wewa_1 und artbew_1 / prescherad 22.07.2025
WITH Steuckliste_komplett AS 
(SELECT
    s.mandant_id mandant_id,
    s.stueckliste_id stueckliste_id,
    t.dat,
    t.kjwo_kl,
    s.dat_vON AS komponente_dat_von,
    s.dat_bis AS komponente_dat_bis,
    s.art_id AS display_art_id,
    s.art_id ,
    0 AS komponentenmenge,
    '-' AS komponentenmenge_einh_id,
    0 AS gp_id,
    1 AS DISPLAY_FLAG
FROM
dbp_data.stueckliste_1 s
JOIN dbp_data.tag_1 t 
ON t.dat BETWEEN s.dat_von AND s.dat_bis
WHERE t.akt_gj <= 2

UNION ALL
SELECT
    a.mandant_id mandant_id,
    a.stueckliste_id stueckliste_id,
    t.dat,
    t.kjwo_kl,
    a.dat_vON komponente_dat_von,
    a.dat_bis komponente_dat_bis,
    b.art_id AS display_art_id,
    a.art_id ,
    a.komponentenmenge komponentenmenge,
    a.komponentenmenge_einh_id komponentenmenge_einh_id,
    0 AS gp_id,
    0 AS DISPLAY_FLAG    
FROM
    dbp_data.stueckliste_det_1 a
    JOIN dbp_data.stueckliste_1 b 
    ON a.mandant_id = b.mandant_id
    AND a.stueckliste_id = b.stueckliste_id 
  
    JOIN dbp_data.tag_1 t 
    ON t.dat BETWEEN a.dat_vON AND a.dat_bis
    WHERE t.akt_gj <= 2
    
     )

SELECT 
    v1.mandant_id,
    v1.stueckliste_id,
    v1.dat,
    v1.kjwo_kl,
    v1.komponente_dat_von,
    v1.komponente_dat_bis,
    v1.display_art_id,
    v1.art_id,
    v1.komponentenmenge,
    v1.komponentenmenge_einh_id,
    v3.gp_id AS gp_id,
    v1.DISPLAY_FLAG,
    CASE WHEN v1.DISPLAY_FLAG = 0 THEN  CONCAT(CAST(((v1.komponentenmenge/v2.total_amount_display) * 100) AS NUMBER(38,2)),'%') END AS stueckliste_anteil,
    CASE WHEN v1.DISPLAY_FLAG = 1 THEN v2.total_amount_display ELSE 0 END AS anzahl_komponentenmenge_gesamt

FROM Steuckliste_komplett v1
JOIN (SELECT
a.mandant_id
,a.stueckliste_id
,t.dat
,SUM(a.komponentenmenge) AS total_amount_display
FROM dbp_data.stueckliste_det_1 a
JOIN dbp_data.tag_1 t 
    ON t.dat BETWEEN a.dat_vON AND a.dat_bis
    WHERE t.akt_gj <= 2 
GROUP BY mandant_id
,stueckliste_id, t.dat) v2
ON v1.mandant_id = v2.mandant_id
AND v1.stueckliste_id = v2.stueckliste_id
AND v1.dat = v2.dat

JOIN (
SELECT mandant_id,gp_id, art_id --,dat_von, dat_bis 
FROM dbp_data.art_gp_nm_zu_per_1 GROUP BY ALL) v3
ON v1.mandant_id = v3.mandant_id AND v1.display_art_id = v3.art_id 

WHERE (v1.mandant_id, v1.display_art_id, v3.gp_id, v1.dat) IN
(
(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat_buch FROM
(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat_buch, SUM(ZEROIFNULL(a.menge_basis)) AS we_menge_inkl_ret FROM dbp_msi_view_ais_int.mv_wewa_1  a
JOIN dbp_data.tag_1 t ON t.dat = a.dat_buch
WHERE t.akt_gj <= 2
GROUP BY ALL 
HAVING we_menge_inkl_ret != 0) a
GROUP BY ALL)
UNION 

(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat FROM
(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat,SUM(a.menge) AS absatz FROM dbp_data.artbew_1 a 
JOIN dbp_data.tag_1 t ON a.dat = t.dat WHERE t.akt_gj <= 2 
GROUP BY ALL
HAVING absatz != 0)a
GROUP BY ALL)
)

UNION ALL

SELECT
a.mandant_id,
-1 AS stueckliste_id,
b.dat,
b.kjwo_kl,
NULL,
NULL,
--a.dat_von, 
--a.dat_bis,			 
-2 AS display_art_id,
a.art_id,
NULL AS kompONentenmenge,
NULL AS kompONentenmenge_ein_id,
a.gp_id,
0 AS display_fg,
NULL AS stueckliste_anteil,
NULL AS Anzahl_KompONentenmenge_gesamt

FROM dbp_data.art_gp_nm_zu_per_1 a
JOIN dbp_data.tag_1 b
ON b.dat BETWEEN a.dat_vON AND a.dat_bis
AND b.akt_gj <= 2
AND (a.mandant_id, a.art_id, a.gp_id) NOT IN

(
SELECT a.mandant_id, a.art_id, b.gp_id
FROM dbp_data.stueckliste_1 a
JOIN (SELECT mandant_id, gp_id, art_id FROM dbp_data.art_gp_nm_zu_per_1 GROUP BY ALL)b
GROUP BY ALL

UNION ALL

SELECT a.mandant_id, a.art_id, b.gp_id
FROM dbp_data.stueckliste_det_1 a
JOIN (SELECT mandant_id, gp_id, art_id FROM dbp_data.art_gp_nm_zu_per_1 GROUP BY ALL)b
GROUP BY ALL)

WHERE (a.mandant_id, a.art_id, a.gp_id, b.dat) IN
(
(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat_buch FROM
(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat_buch, SUM(ZEROIFNULL(a.menge_basis)) AS we_menge_inkl_ret FROM dbp_msi_view_ais_int.mv_wewa_1 a
JOIN dbp_data.tag_1 t ON t.dat = a.dat_buch
WHERE t.akt_gj <= 2
GROUP BY ALL
HAVING we_menge_inkl_ret != 0) a
GROUP BY ALL)
UNION

(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat FROM
(SELECT a.mandant_id, a.art_id, a.gp_id, a.dat,SUM(a.menge) AS absatz FROM dbp_data.artbew_1 a
JOIN dbp_data.tag_1 t ON a.dat = t.dat WHERE t.akt_gj <= 2
GROUP BY ALL
HAVING absatz != 0)a
GROUP BY ALL)
)
GROUP BY ALL;