CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_ART_KEINE_BEWEGUNG_2

-- 16.08.2017 ttez: Initial: Dieser View berechnet die Menge und Wert von Artikeln die in den letzten 60 Tagen keine relevante Lagerbewegung hatten:
--  Relevant bedeutet, dass es keine Bewegung mit bewart_id in (645,647,101) und dass die Bewegung nicht storniert worden ist.
--  Der View kann erweitert werden um einzelne flags aus der Tabelle in_art_per_2 aufzunehmen allerdings wird dadurch noch ein self-join zu in_art_per_2 benötigt. Aus Performancegründen wurde hier darauf verzichtet.
-- 04.09.2017: ttez Währungsumrechnung hinzugekommen im BEWKREIS-Teil
-- 04.09.2017: ttez Einschränkung im ersten Subselect auf die relevanten Artikel_2
--11.09.2017 twie: in_bewart_id ist CHAR

(
mandant_id
,in_art_id
,kjmo
,menge_bestand_bme
,betrag_preis_bestand
)

AS

SELECT
bew.mandant_id
,bew.in_art_id
,bew.kjmo
,bewkreis.menge_bestand_bme
,bewkreis.betrag_preis_bestand
FROM
-- Artikel_2 die keine relevante Lagerbewegung in den letzten 60 Tagen hatten
(
SELECT
a.mandant_id
,a.in_art_id
,b.kjmo
FROM dbp_view.v_in_art_per_2 a
JOIN dbp_view.v_monat_2 b
ON b.max_dat between a.dat_von and a.dat_bis

JOIN dbp_view.v_in_art_2 e
ON e.mandant_id = a.mandant_id and e.in_art_id = a.in_art_id

-- Einschraenken auf die BIS-relevanten Artikel_2
WHERE  (e.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')  OR e.in_art_nr like 'W%'  OR e.in_art_id = -1) and a.normalposition_fg = 1 and a.aktiv_fg = 1
GROUP BY 1,2,3

MINUS

-- Artikel_2 pro KJMO und Mandant_2 die in den letzten 60 Tagen eine_2 relevante Lagerbewegung hatten
SELECT
v1.mandant_id
,v1.in_art_id
,v0.kjmo
FROM
(
SELECT
a.kjmo
,to_number(to_varchar(add_months(to_date(to_char(a.kjmo),'YYYYMM'),-1),'YYYYMM')) AS kjmo_vm
--,ADD_MONTHS(CAST(a.kjmo*100-19000000+1 AS DATE),-1)/100 + 190000 AS kjmo_vm
,b.max_dat as dat_periode_ende
  ,dat_periode_ende - 59 as dat_periode_beginn
FROM dbp_view.v_monat_2 a
JOIN dbp_view.v_monat_2 b
ON to_number(to_varchar(add_months(to_date(to_char(a.kjmo),'YYYYMM'),-1),'YYYYMM')) = b.kjmo
) v0
JOIN
( -- Artikel_2 die eine_2 relevante Lagerbewegung in den letzten 60 Tagen hatten
SELECT
v1.mandant_id
,v1.in_art_id
,v0.dat_buch
FROM   dbp_view.v_in_lagerbew_2 v0
JOIN dbp_view.v_in_lagerbew_det_2 v1
ON v0.mandant_id  = v1.mandant_id and v0.kj = v1.kj and v0.lagerbew_beleg_id = v1.lagerbew_beleg_id
JOIN dbp_view.v_in_werk_2 v2
ON v1.mandant_id = v2.mandant_id and v1.werk_id = v2.werk_id
WHERE (v1.in_bewart_id in ('645','647','101') and v1.lagerbew_beleg_storno_id is null) AND v2.werk_nr in ('DE01', 'PL02', 'CZ02', 'SK02', 'HR02', 'RO02', 'BG02')
) v1
ON v1.dat_buch between v0.dat_periode_beginn and v0.dat_periode_ende
GROUP BY 1,2,3
) bew

LEFT JOIN

--Hole die Werte für den letzten Tag_2 des Vormonats aus in_art_bewertungskreis_tag_2
(
SELECT
v0.mandant_id
,v0.in_art_id
,to_number(to_varchar(add_months(to_date(to_char(kjmo),'YYYYMM'),1),'YYYYMM')) AS kjmo
--,ADD_MONTHS(CAST(v1.kjmo*100-19000000+1 AS DATE), 1) / 100 + 190000 as kjmo -- Der Wert wird abgebildet auf den nächsten Monat_2 für den JOIN
,sum(v0.menge_bestand_bme) as menge_bestand_bme
,sum(v0.betrag_preis_bestand) as betrag_preis_bestand
FROM
(SELECT
v00.mandant_id
,v00.in_art_id
,v00.dat
,v00.menge_bestand_bme
,CASE WHEN v04.wrg_typ_id = 0
THEN CAST(v00.betrag_preis_bestand AS NUMBER(38,5))  * v05.umrechnungskurs
ELSE CAST(v00.betrag_preis_bestand AS NUMBER(38,5))
END as betrag_preis_bestand
FROM dbp_view.v_in_art_bewertungskreis_tag_2 v00

INNER JOIN  dbp_view.v_mandant_2 v03
ON v00.mandant_id=v03.mandant_id

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04

JOIN dbp_view.v_kurs_2 AS v05
ON  v05.von_wrg_id = v03.default_wrg
AND v00.dat BETWEEN v05.dat_von AND v05.dat_bis
AND v05.kurstyp_id = 9
AND v05.nach_wrg_id = 'EUR'
) v0
JOIN dbp_view.v_monat_2 v1
ON v0.dat = v1.max_dat
GROUP BY 1,2,3
) bewkreis
ON bewkreis.mandant_id = bew.mandant_id and bewkreis.kjmo = bew.kjmo and bewkreis.in_art_id = bew.in_art_id;