create or replace view DBP_MSI_VIEW_RPW_MATERIALIZED.MV_WUP_AKTUELL(
	AKTUELL_WUP_ID,
	MANDANT_ID,
	WUP_STANDORT
) as
--15.08.2024 twie: SPEC0264080 neue View mit aktuell_wup_id als PK, ist Elternattribut zu wup_id, vereint alte und neue wup_id bei Filialumgliederung in einem Datensatz, deshalb gruppieren
--20.11.2024 twie: SPEC0264080 Erweiterung Konzept um Umzugsfilialen. Hier ist im Gegensatz zur Filialumgliederung in der Tabelle keine Zusammenfassung über die aktuell_wup_id vorhanden
--				   Stattdessen hat die neue Filiale im Feld wup_id_alt die alte wup_id als Zuordnung enthalten.
--				   Darüber können die Datensätze der alten Filiale ermittelt und ausgeschlossen werden.


                   SELECT
                   v01.aktuell_wup_id,
                   v01.mandant_id,
                   MAX(CASE
                   WHEN v01.dat_bis < '9999-12-31'
                   --ASCII Codes stehen für geschweifte Klammern, wegen Darstellungsproblem in der View als Code
                   THEN CHR(123) || v01.wup_standort || CHR(125)
                   ELSE  v01.wup_standort
                   END) AS wup_standort

                   FROM dbp_view.v_wup v01
                   
                   --Bei Umzugsfilialen: Den Datensatz der neuen Filiale zuordnen, dieser beinhaltet die alte wup_id
                   LEFT JOIN dbp_view.v_wup v02
			   		ON v01.mandant_id = v02. mandant_id
			   		AND v01.wup_id = v02.wup_id_alt
			   		AND v01.nb_id = v02.nb_id
			   			
                   WHERE  v01.mandant_id  = 1
                   
                   --nur wenn keine neue Filiale gefunden wurde, den Datensatz ausgeben, somit alte Filialen ausschließen
                   AND v02.wup_id_alt IS NULL
                   
                   -- 07.07.10: NB 99 IWT aufgenommen
                   AND (v01.nb_id IN (0,-111,2, 99)
                   OR (v01.wup_id = 0 AND v01.nb_id = -1)
                   --für WUP 8120 Internet Direktversand
                   OR (v01.nb_id = -1 AND v01.vw_id = 6))
                   
                   GROUP BY
                   v01.aktuell_wup_id,
                   v01.mandant_id;