create or replace view DBP_MSI_VIEW_RPW_MATERIALIZED.MV_L_ABSENDER_AKTUELL_1(
	AKTUELL_WUP_ID,
	MANDANT_ID,
	WUP_STANDORT
) as
--15.08.2024 twie: SPEC0264080 neue View mit aktuell_wup_id als PK, ist Elternattribut zu Absender, vereint alte und neue wup_id bei Filialumgliederung in einem Datensatz, deshalb gruppieren
--				   im Gegensatz zu mv_l_absender_1 beinhaltet diese View nur WUP_1 (abs_typ_id = 1) keine VZ und Lieferanten (2,3)
--20.11.2024 twie: SPEC0264080 Erweiterung Konzept um Umzugsfilialen. Hier ist im Gegensatz zur Filialumgliederung in der Tabelle keine Zusammenfassung über die aktuell_wup_id vorhanden
--				   Stattdessen hat die neue Filiale im Feld wup_id_alt die alte wup_id als Zuordnung enthalten.
--				   Darüber können die Datensätze der alten Filiale ermittelt und ausgeschlossen werden.

SELECT
v01.aktuell_wup_id,
v01.mandant_id,
MAX(v01.wup_standort) AS wup_standort

FROM dbp_view.v_wup_1 v01

--Bei Umzugsfilialen: Den Datensatz der neuen Filiale zuordnen, dieser beinhaltet die alte wup_id
LEFT JOIN dbp_view.v_wup_1 v02
 ON v01.mandant_id = v02. mandant_id
 AND v01.wup_id = v02.wup_id_alt
 AND v01.nb_id = v02.nb_id
			   		
WHERE  v01.mandant_id  = 1

--nur wenn keine neue Filiale gefunden wurde, den Datensatz ausgeben, somit alte Filialen ausschließen
AND v02.wup_id_alt IS NULL

-- VZ ausschließen, es sollen nur Märkte ausgegeben werden
AND NOT((v01.nb_id = -111  AND v01.wup_typ_id IN (1, 2)) OR v01.nb_id=99)

GROUP BY
v01.aktuell_wup_id,
v01.mandant_id;