CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_F_IT_PROJEKT_VERTEILUNG_1
-- 24.10.2017 twie: SPEC0029703 neue View
-- 05.01.2018 twie: SPEC0032314 mandant_id durch it_plan_ebene_id ersetzt, it_projekt_verteilung_int entfällt dadurch
-- 04.01.2019 twie: SPEC0046436 neue Ermittlung der Länderverteilung
-- 28.05.2019 twie: SPEC0056411 Betrag für Verteilung aus verteilung_laender nehmen, nicht über Quote selbst berechnen
-- 07.06.2019 lwei: SPEC0056411 Die Berichtsposition 14 wurde entfernt und bei dem Innerjoin wurde unabhängig der Berichtsposition auf die Maximale Planversion beschränkt.
-- 12.06.2019 twie: SPEC0056411 Filterung auf Berichtsposition 14 so geändert, dass sie in dieser View gar nicht mehr ausgegeben wird.
-- 09.02.2021 twie: SPEC0098275 Filterung erweitert um die 20
-- 10.02.2023 prescherad: SPEC0186488 Filterung erweitert um die 21
(
 it_plan_ebene_id
,it_projekt_id
,gj
,berichts_position_it_id
,verteilung_quote
,verteilung_betrag
)

AS
SELECT
 v01.it_plan_ebene_id
,v01.it_projekt_id
,v01.gj
,v01.berichts_position_it_id
,v01.verteilung_quote
,v01.verteilung_betrag

--Tabelle beinhaltet nur die aktuellste (höchste) Revision
FROM dbp_view.v_it_projekt_verteilung_laender_1 v01

--diese Positionen nicht aufteilen sondern immer auf it_plan_ebene_id = 1, siehe nächster Step
--Berichtsposition 14 soll in der Länderverteilung gar nicht mehr reportet werden, deshalb hier zusätzlich explizit ausgeschlossen
WHERE v01.berichts_position_it_id NOT IN (1,3,5,7,8,9,10,13,17,18,19,20,14,21)


UNION ALL


--definierte Berichspositionen nicht auf Länder aufteilen sondern komplett auf KI (it_plan_ebene_id = 1) mappen
SELECT
1 AS it_plan_ebene_id --KI
,v01.it_projekt_id
,v01.gj
,v01.berichts_position_it_id
,100 AS verteilung_quote -- immer 100%
,v01.plan_betrag AS verteilung_betrag

FROM dbp_view.v_it_projekt_plan_det_1  v01

--Im Gegensatz zur verteilung_laender hat die plan_det eine_1 Versionierung mittels plan_revision_id, deshalb hier nur die höchste Revision ermitteln und ausgeben
--Revision unabhängig von der berichts_position_it_id ermitteln, deshalb diese hier nicht berücksichtigen. Somit pro it_projekt_id und gj eine_1 einheitliche plan_revision_id
INNER JOIN (SELECT
it_projekt_id
,gj
,MAX(plan_revision_id) AS max_revision
FROM dbp_view.v_it_projekt_plan_det_1
GROUP BY
it_projekt_id
,gj
) v02

ON v01. it_projekt_id = v02. it_projekt_id
AND v01.plan_revision_id = v02.max_revision
AND v01.gj = v02.gj

WHERE v01.berichts_position_it_id IN (1,3,5,7,8,9,10,13,17,18,19,20,21)
;