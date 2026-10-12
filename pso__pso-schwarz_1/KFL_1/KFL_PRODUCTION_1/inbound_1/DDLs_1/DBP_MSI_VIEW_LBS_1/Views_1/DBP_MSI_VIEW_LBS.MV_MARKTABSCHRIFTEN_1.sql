CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_MARKTABSCHRIFTEN_1(
	MANDANT_ID,
	WUP_ID,
	WUP_ABSCHRIFT_ID,
	POSITIONSNUMMER_ID,
	ABSCHRIFTART_ID,
	NB_ID,
	DAT,
	WOCHE_ID,
	ABSCH_MENGE,
	ART_ID,
	GP_ID,
	LASTUPD_DAT,
	ABSCHRIFTBETRAG_NETTO,
	ABSCHRIFTBETRAG_BRUTTO,
	POSTEN_KZ_PER
) AS
SELECT
v01.mandant_id,
v01.wup_id,
v01.wup_abschrift_id,
v01.positionsnummer_id,
v01.abschriftart_id,
v01.nb_id,
v01.dat,
v01.woche_id,
CASE
WHEN v01.abschrift_menge_einh_id = 'G' THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
ELSE CAST(v01.menge_abschrift AS DECIMAL(13,4)) END  * -1 AS absch_menge,
v01.art_id,
v04.gp_id,
v01.lastupd_dat,
CASE
WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 0 THEN CAST(abschriftbetrag_netto * v300.umrechnungskurs AS NUMBER(18,6))
WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 1 THEN CAST(abschriftbetrag_netto * v400.umrechnungskurs AS NUMBER(18,6))
ELSE CAST(abschriftbetrag_netto AS DECIMAL(18,6)) END AS abschriftbetrag_netto,
--CAST(abschriftbetrag_netto *-1 as DECIMAL(18,6)) AS abschriftbetrag_netto,
CASE
WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 0 THEN CAST(abschriftbetrag_brutto * v300.umrechnungskurs AS NUMBER(18,6))
WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 1 THEN CAST(abschriftbetrag_brutto * v400.umrechnungskurs AS NUMBER(18,6))
ELSE CAST(abschriftbetrag_brutto AS DECIMAL(18,6)) END AS abschriftbetrag_brutto,
CASE WHEN v05.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
--CAST(abschriftbetrag_brutto *-1 as DECIMAL(18,6)) AS abschriftbetrag_brutto
FROM dbp_view.v_marktabschriften_1 v01
-- AP0092241, SPEC0109744 - KG logic changed - dbe_data_fed_ais_de.art_1 not needed anymore
-- gewart_id not used anymore
/*JOIN dbe_data_fed_ais_int.art_1 v03
ON v01.mandant_id = v03.mandant_id AND
	v01.art_id = v03.art_id*/

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v2
/* 
JOIN dbp_view.v_kurs_1 v3
    ON v01.dat BETWEEN v3.dat_von AND v3.dat_bis
    AND v01.wrg_id = v3.von_wrg_id
    AND v3.kurstyp_id = 9
    AND v3.nach_wrg_id ='EUR' */
	
   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v300
   ON v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v400
   ON v01.dat BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 v04
    ON v01.art_id = v04.art_id
    AND v01.wup_id = v04.wup_id
    AND v01.mandant_id = v04.mandant_id
    AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis

LEFT JOIN dbp_view.v_art_per_1 v05
ON v01.art_id = v05.art_id
AND v01.mandant_id = v05.mandant_id
AND v01.dat BETWEEN v05.dat_von-1 AND v05.dat_bis-1

WHERE
--v01.abschriftart_id BETWEEN 905 AND 994 -- Filter falsch für angeforderte Kennzahlen (Saldo Ab-/Aufschriften)
v01.mandant_id <> 1
AND
NOT (v01.abschriftart_id = 955
AND v01.mandant_id = 2)

UNION ALL

SELECT
v01.mandant_id,
v01.wup_id,
v01.wup_abschrift_id,
v01.positionsnummer_id,
v01.abschriftart_id,
v01.nb_id,
v01.dat,
v01.woche_id,
CASE
WHEN v01.abschrift_menge_einh_id = 'G' AND v01.abschriftart_id <> '-1' THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
ELSE CAST (v01.menge_abschrift  AS DECIMAL(13,4)) END AS absch_menge,
v01.art_id,
v04.gp_id,
v01.lastupd_dat,
CASE
WHEN v2.wrg_typ_id = 0 THEN CAST(v01.abschriftbetrag_netto * v3.umrechnungskurs AS NUMBER(18,6))
ELSE CAST(v01.abschriftbetrag_netto AS DECIMAL(18,6)) END AS abschriftbetrag_netto,
--CAST(v01.abschriftbetrag_netto AS DECIMAL(18,6)) AS abschriftbetrag_netto,
CASE
WHEN v2.wrg_typ_id = 0 THEN CAST(v01.abschriftbetrag_brutto * v3.umrechnungskurs AS NUMBER(18,6))
ELSE CAST(v01.abschriftbetrag_brutto AS DECIMAL(18,6)) END AS abschriftbetrag_brutto,
CASE WHEN v05.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
--CAST(v01.abschriftbetrag_brutto AS DECIMAL(18,6)) AS abschriftbetrag_brutto
FROM dbp_view.v_marktabschriften_1 v01
-- AP0092241, SPEC0109744 - KG logic changed - dbe_data_fed_ais_de.art_1 not needed anymore
-- gewart_id not used anymore
/*INNER JOIN
(
SELECT
art_id
, gewart_id
FROM dbe_data_fed_ais_int.art_1
WHERE mandant_id = 1
) v03

ON v01.art_id = v03.art_id*/

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v2
  
JOIN dbp_view.v_kurs_1 v3
    ON v01.dat BETWEEN v3.dat_von AND v3.dat_bis
    AND v01.wrg_id = v3.von_wrg_id
    AND v3.kurstyp_id = 9
    AND v3.nach_wrg_id ='EUR'

LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 v04
   ON v01.art_id = v04.art_id
   AND v01.wup_id = v04.wup_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis

LEFT JOIN dbp_view.v_art_per_1 v05
ON v01.art_id = v05.art_id
AND v01.mandant_id = v05.mandant_id
AND v01.dat BETWEEN v05.dat_von-1 AND v05.dat_bis-1

WHERE v01.mandant_id = 1;