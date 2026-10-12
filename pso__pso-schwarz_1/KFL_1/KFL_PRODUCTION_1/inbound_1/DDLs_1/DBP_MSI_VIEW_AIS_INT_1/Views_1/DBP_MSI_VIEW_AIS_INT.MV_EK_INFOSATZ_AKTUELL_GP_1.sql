CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_EK_INFOSATZ_AKTUELL_GP_1(
	MANDANT_ID,
	EK_INFOSATZ_ID,
	MAX_EK_INFOSATZ_ID,
	ART_ID,
	AKT_GP_ID,
	EINKAUFSORGANISATION_ID,
	DAT_ERSTELLUNG,
	GP_ART_ID,
	DAT_VON,
	DAT_BIS,
	KONDITIONSGRUPPE_ID,
	GP_KONDITIONSGRUPPE_BEZ
) AS
--Es erfolgt eine_1 dreistufige Überprüfung für die Ermittlung des aktuellen Lieferants in Kombination der Konditionsgruppe: (Uniqueness, Regel_GP, Max_Infosatz)
--Uniqueness ermittlung. Ermittlung alle Art_1 die nur einen GP_1 gepflegt haben bei der die Bedingung gilt, dass der current date zwischen den dat_von und dat_bis gilt + Filterung zur Berücksichtigun nur diese die in der art_gp_nm_zu_per_1 vorliegen
--Keine Bedingung von Loesch_fgs, max ek infosatz oder regel gp_1 fg 
SELECT
ek_info.akt_mandant_id,
ek_info.akt_ek_infosatz_id,
ek_info.akt_max_ek_infosatz_id,
ek_info.akt_art_id,
ek_info.akt_gp_id,
ek_info.akt_einkaufsorganisation_id,
ek_info.dat_erstellung,
ek_info.gp_art_id,
ek_info.akt_dat_von,
ek_info.akt_dat_bis,
/*ek_info.akt_lieferbar_fg,
ek_info.akt_regel_gp_fg,
ek_info.akt_loesch_fg,
ek_info.akt_max_ek_infosatz_fg,
ek_info.akt_apollo_ian
ek_info.akt_gp_teilsortiment_id, */
ek_info.akt_konditionsgruppe_id,
gp_konditionsgruppe_bez
FROM
(SELECT
v01.mandant_id akt_mandant_id,
v01.ek_infosatz_id akt_ek_infosatz_id,
v01.art_id akt_art_id,
v01.gp_id akt_gp_id,
v01.einkaufsorganisation_id akt_einkaufsorganisation_id,
v01.dat_erstellung dat_erstellung,
v01.gp_art_id gp_art_id,
v01.dat_von akt_dat_von,
v01.dat_bis akt_dat_bis,
CASE
WHEN (CURRENT_DATE - 1 BETWEEN v01.dat_von AND v01.dat_bis) THEN 'X'
ELSE ' ' END akt_lieferbar_fg,
CASE
WHEN (v01.regel_gp_fg = 1) THEN 'X'
ELSE ' ' END akt_regel_gp_fg,
CASE
WHEN (v01.loesch_fg = 1) THEN 'X'
ELSE ' ' END akt_loesch_fg,
CASE
WHEN (v02.max_ek_infosatz_id IS NOT NULL) THEN 'X'
ELSE ' ' END akt_max_ek_infosatz_fg,
v02.max_ek_infosatz_id akt_max_ek_infosatz_id,
COALESCE(gp_teilsortiment_id, '999999') akt_gp_teilsortiment_id,
v01.konditionsgruppe_id akt_konditionsgruppe_id,
v01.apollo_ian akt_apollo_ian
FROM dbp_view.v_ek_infosatz_1 v01
LEFT JOIN

(SELECT
MANDANT_ID,
art_id,
MAX(ek_infosatz_id) AS max_ek_infosatz_id
FROM dbp_view.v_ek_infosatz_1

WHERE MANDANT_ID = 1

GROUP BY 1,2) v02

ON v01.MANDANT_ID = v02.MANDANT_ID
AND v01.art_id = v02.art_id
AND v01.ek_infosatz_id = v02.max_ek_infosatz_id

WHERE v01.MANDANT_ID = 1
QUALIFY RANK() OVER(PARTITION BY v01.MANDANT_ID, v01.art_id, v01.gp_id ORDER BY v01.ek_infosatz_id DESC NULLS LAST) = 1)ek_info
LEFT JOIN
(SELECT
MANDANT_ID,
gp_id,
konditionsgruppe_id,
spr_id,
gp_konditionsgruppe_bez
FROM dbp_view.v_gp_konditionsgruppe_spr_zu_1
WHERE MANDANT_ID = 1) v03
ON ek_info.akt_MANDANT_ID = v03.MANDANT_ID AND ek_info.akt_gp_id = v03.gp_id AND ek_info.akt_konditionsgruppe_id = v03.konditionsgruppe_id

WHERE ek_info.akt_MANDANT_ID = 1
AND (ek_info.akt_MANDANT_ID, ek_info.akt_art_id, ek_info.akt_gp_id)
IN (SELECT MANDANT_ID, art_id, gp_id FROM dbp_data.art_gp_nm_zu_per_1 WHERE MANDANT_ID = 1 AND dat_bis = '9999-12-31')
AND CURRENT_DATE BETWEEN ek_info.akt_dat_von AND ek_info.akt_dat_bis

AND (ek_info.akt_MANDANT_ID, ek_info.akt_art_id) IN
(SELECT a.MANDANT_ID, a.art_id
FROM (SELECT a.MANDANT_ID, a.art_id, COUNT(*) AS dub
FROM (SELECT MANDANT_ID, art_id, gp_id FROM dbp_data.ek_infosatz_1 WHERE dat_bis = '9999-12-31' AND MANDANT_ID = 1 AND (MANDANT_ID, art_id, gp_id)
IN (SELECT MANDANT_ID, art_id, gp_id FROM dbp_data.art_gp_nm_zu_per_1 WHERE MANDANT_ID = 1 AND dat_bis = '9999-12-31') )a
GROUP BY ALL HAVING dub = 1)a GROUP BY ALL)


UNION

--berücksichtigung nur von denen mit einem REGEL_GP_FG
---Berücksichtigung nur der Kombination die mindestens zwei GPs gepflegt haben. Mit der Bedingung , dASs der current date zwischen den dat_von und dat_bis gilt + Filterung zur Berücksichtigun nur diese die in der art_gp_nm_zu_per_1 vorliegen
--Nur die mit einem Regel_GP_FG = X und keinem Löschflag werden ausgegeben
SELECT
ek_info.akt_mandant_id,
ek_info.akt_ek_infosatz_id,
ek_info.akt_max_ek_infosatz_id,
ek_info.akt_art_id,
ek_info.akt_gp_id,
ek_info.akt_einkaufsorganisation_id,
ek_info.dat_erstellung,
ek_info.gp_art_id,
ek_info.akt_dat_von,
ek_info.akt_dat_bis,
/*ek_info.akt_lieferbar_fg,
ek_info.akt_regel_gp_fg,
ek_info.akt_loesch_fg,
ek_info.akt_max_ek_infosatz_fg,
ek_info.akt_apollo_ian
ek_info.akt_gp_teilsortiment_id, */
ek_info.akt_konditionsgruppe_id,
gp_konditionsgruppe_bez
FROM
(SELECT
v01.mandant_id akt_mandant_id,
v01.ek_infosatz_id akt_ek_infosatz_id,
v01.art_id akt_art_id,
v01.gp_id akt_gp_id,
v01.einkaufsorganisation_id akt_einkaufsorganisation_id,
v01.dat_erstellung dat_erstellung,
v01.gp_art_id gp_art_id,
v01.dat_von akt_dat_von,
v01.dat_bis akt_dat_bis,
CASE
WHEN (CURRENT_DATE - 1 BETWEEN v01.dat_von AND v01.dat_bis) THEN 'X'
ELSE ' ' END akt_lieferbar_fg,
CASE
WHEN (v01.regel_gp_fg = 1) THEN 'X'
ELSE ' ' END akt_regel_gp_fg,
CASE
WHEN (v01.loesch_fg = 1) THEN 'X'
ELSE ' ' END akt_loesch_fg,
CASE
WHEN (v02.max_ek_infosatz_id IS NOT NULL) THEN 'X'
ELSE ' ' END akt_max_ek_infosatz_fg,
v02.max_ek_infosatz_id akt_max_ek_infosatz_id,
COALESCE(gp_teilsortiment_id, '999999') akt_gp_teilsortiment_id,
v01.konditionsgruppe_id akt_konditionsgruppe_id,
v01.apollo_ian akt_apollo_ian
FROM dbp_view.v_ek_infosatz_1 v01
LEFT JOIN

(SELECT
MANDANT_ID,
art_id,
MAX(ek_infosatz_id) AS max_ek_infosatz_id
FROM dbp_view.v_ek_infosatz_1

WHERE MANDANT_ID = 1

GROUP BY 1,2) v02

ON v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v01.ek_infosatz_id = v02.max_ek_infosatz_id

WHERE v01.mandant_id = 1
QUALIFY RANK() OVER(PARTITION BY v01.MANDANT_ID, v01.art_id, v01.gp_id ORDER BY v01.ek_infosatz_id DESC NULLS LAST) = 1)ek_info
LEFT JOIN
(SELECT
MANDANT_ID,
gp_id,
konditionsgruppe_id,
spr_id,
gp_konditionsgruppe_bez
FROM dbp_view.v_gp_konditionsgruppe_spr_zu_1
WHERE MANDANT_ID = 1) v03
ON ek_info.akt_MANDANT_ID = v03.MANDANT_ID AND ek_info.akt_gp_id = v03.gp_id AND ek_info.akt_konditionsgruppe_id = v03.konditionsgruppe_id

WHERE ek_info.akt_MANDANT_ID = 1
AND (ek_info.akt_MANDANT_ID, ek_info.akt_art_id, ek_info.akt_gp_id)
IN (SELECT MANDANT_ID, art_id, gp_id FROM dbp_data.art_gp_nm_zu_per_1 WHERE MANDANT_ID = 1 AND dat_bis = '9999-12-31')
AND CURRENT_DATE BETWEEN ek_info.akt_dat_von AND ek_info.akt_dat_bis
AND ek_info.akt_regel_gp_fg = 'X' AND ek_info.akt_loesch_fg != 'X'

AND (ek_info.akt_mandant_id, ek_info.akt_art_id) IN
(SELECT a.mandant_id, a.art_id
FROM (SELECT a.mandant_id, a.art_id, COUNT(*) AS dub
FROM (SELECT mandant_id, art_id, gp_id FROM dbp_data.ek_infosatz_1 WHERE dat_bis = '9999-12-31' AND MANDANT_ID = 1 AND (MANDANT_ID, art_id, gp_id)
IN (SELECT MANDANT_ID, art_id, gp_id FROM dbp_data.art_gp_nm_zu_per_1 WHERE MANDANT_ID = 1 AND dat_bis = '9999-12-31') )a
GROUP BY ALL HAVING dub != 1)a GROUP BY ALL)

UNION

---Berücksichtigung nur der Kombination die mindestens zwei GPs gepflegt haben. Mit der Bedingung , dASs der current date zwischen den dat_von und dat_bis gilt + Filterung zur Berücksichtigun nur diese die in der art_gp_nm_zu_per_1 vorliegen
-- Es werden nur diese Berücksichtigt die KEINEN Regel_GP_FG und Losch_fg haben
--Es wird der mit dem höchsten Infosatz ausgegeben
SELECT
ek_info.akt_mandant_id,
ek_info.akt_ek_infosatz_id,
ek_info.akt_max_ek_infosatz_id,
ek_info.akt_art_id,
ek_info.akt_gp_id,
ek_info.akt_einkaufsorganisation_id,
ek_info.dat_erstellung,
ek_info.gp_art_id,
ek_info.akt_dat_von,
ek_info.akt_dat_bis,
/*ek_info.akt_lieferbar_fg,
ek_info.akt_regel_gp_fg,
ek_info.akt_loesch_fg,
ek_info.akt_max_ek_infosatz_fg,
ek_info.akt_apollo_ian
ek_info.akt_gp_teilsortiment_id, */
ek_info.akt_konditionsgruppe_id,
gp_konditionsgruppe_bez
FROM
(SELECT
v01.MANDANT_ID akt_MANDANT_ID,
v01.ek_infosatz_id akt_ek_infosatz_id,
v01.art_id akt_art_id,
v01.gp_id akt_gp_id,
v01.einkaufsorganisation_id akt_einkaufsorganisation_id,
v01.dat_erstellung dat_erstellung,
v01.gp_art_id gp_art_id,
v01.dat_von akt_dat_von,
v01.dat_bis akt_dat_bis,
CASE
WHEN (CURRENT_DATE - 1 BETWEEN v01.dat_von AND v01.dat_bis) THEN 'X'
ELSE ' ' END akt_lieferbar_fg,
CASE
WHEN (v01.regel_gp_fg = 1) THEN 'X'
ELSE ' ' END akt_regel_gp_fg,
CASE
WHEN (v01.loesch_fg = 1) THEN 'X'
ELSE ' ' END akt_loesch_fg,
CASE
WHEN (v02.max_ek_infosatz_id IS NOT NULL) THEN 'X'
ELSE ' ' END akt_max_ek_infosatz_fg,
v02.max_ek_infosatz_id akt_max_ek_infosatz_id,
COALESCE(gp_teilsortiment_id, '999999') akt_gp_teilsortiment_id,
v01.konditionsgruppe_id akt_konditionsgruppe_id,
v01.apollo_ian akt_apollo_ian
FROM dbp_view.v_ek_infosatz_1 v01
LEFT JOIN

(SELECT
MANDANT_ID,
art_id,
MAX(ek_infosatz_id) AS max_ek_infosatz_id
FROM dbp_view.v_ek_infosatz_1

WHERE MANDANT_ID = 1

GROUP BY 1,2) v02

ON v01.MANDANT_ID = v02.MANDANT_ID
AND v01.art_id = v02.art_id
AND v01.ek_infosatz_id = v02.max_ek_infosatz_id

WHERE v01.MANDANT_ID = 1
QUALIFY RANK() OVER(PARTITION BY v01.MANDANT_ID, v01.art_id, v01.gp_id ORDER BY v01.ek_infosatz_id DESC NULLS LAST) = 1)ek_info
LEFT JOIN
(SELECT
MANDANT_ID,
gp_id,
konditionsgruppe_id,
spr_id,
gp_konditionsgruppe_bez
FROM dbp_view.v_gp_konditionsgruppe_spr_zu_1
WHERE MANDANT_ID = 1) v03
ON ek_info.akt_MANDANT_ID = v03.MANDANT_ID AND ek_info.akt_gp_id = v03.gp_id AND ek_info.akt_konditionsgruppe_id = v03.konditionsgruppe_id

WHERE ek_info.akt_MANDANT_ID = 1
AND (ek_info.akt_MANDANT_ID, ek_info.akt_art_id, ek_info.akt_gp_id)
IN (SELECT MANDANT_ID, art_id, gp_id FROM dbp_data.art_gp_nm_zu_per_1 WHERE MANDANT_ID = 1 AND dat_bis = '9999-12-31')
AND CURRENT_DATE BETWEEN ek_info.akt_dat_von AND ek_info.akt_dat_bis

AND ek_info.akt_regel_gp_fg != 'X' AND ek_info.akt_max_ek_infosatz_fg = 'X' AND ek_info.akt_loesch_fg != 'X'
AND (ek_info.akt_mandant_id, ek_info.akt_art_id) IN
(SELECT a.mandant_id, a.art_id
FROM (SELECT a.mandant_id, a.art_id, COUNT(*) AS dub
FROM (SELECT mandant_id, art_id, gp_id FROM dbp_data.ek_infosatz_1 WHERE dat_bis = '9999-12-31' AND mandant_id = 1 AND (mandant_id, art_id, gp_id)
IN (SELECT mandant_id, art_id, gp_id FROM dbp_data.art_gp_nm_zu_per_1 WHERE mandant_id = 1 AND dat_bis = '9999-12-31') )a
GROUP BY ALL HAVING dub != 1)a GROUP BY ALL)

AND (ek_info.akt_mandant_id, ek_info.akt_art_id) NOT IN
(SELECT mandant_id, art_id FROM dbp_data.ek_infosatz_1 WHERE mandant_id = 1 AND regel_gp_fg = 1 AND CURRENT_DATE BETWEEN dat_von AND dat_bis
AND (mandant_id, art_id, gp_id) IN (SELECT mandant_id, art_id, gp_id FROM dbp_data.art_gp_nm_zu_per_1 WHERE mandant_id = 1 AND dat_bis = '9999-12-31')
)
;