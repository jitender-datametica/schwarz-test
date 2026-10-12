CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_ABSENDER_1
(
	MANDANT_ID,
	ABS_NAME,
	ABS_ID,
	AKTUELL_WUP_ID,
	DAT_VON,
	DAT_BIS,
	SYSTEM_ID,
	ABS_TYP_ID
) AS
--15.08.2024 twie: SPEC0264080 aktuell_wup_id ergänzt als Elternattribut von wup_id (Filialumgliederung)
--12.11.2024 twie: SPEC0264080 Erweiterung Konzept um Umzugsfilialen. Hier ist im Gegensatz zur Filialumgliederung in der Tabelle keine Zusammenfassung über die aktuell_wup_id vorhanden
-- 					Stattdessen hat die neue Filiale im Feld wup_id_alt die alte wup_id als Zuordnung enthalten.
--					Somit kann bei der alten Filiale die aktuell_wup_id der neuen Filiale ermittelt und ausgegeben werden


          SELECT
          mandant_id,
          gp_name,
          gp_id,
          NULL AS aktuell_wup_id, -- Lieferant nicht definiert in View MV_L_ABSENDER_AKTUELL_1, aktuell_wup_id nur für Märkte
          dat_von,
          dat_bis,
          7 AS system_id,
          3 AS abs_typ_id
          FROM dbp_view.v_gp_1
          WHERE mandant_id = 1
          AND gp_id > 999999

          UNION

          SELECT
          v01.mandant_id,
          v01.wup_standort,
          v01.wup_id,
          --Bei Umzugsfilialen beinhaltet v02.aktuell_wup_id die ID der neuen Filiale, Standardfall ist v01.aktuell_wup_id
          COALESCE (v02.aktuell_wup_id, v01.aktuell_wup_id) AS aktuell_wup_id,
          v01.dat_von,
          v01.dat_bis,
          7 AS system_id,
          CASE WHEN  ((v01.nb_id = -111  AND v01.wup_typ_id IN (1, 2)) OR v01.nb_id=99)  THEN 2 ELSE 1 END AS abs_typ_id
          FROM dbp_view.v_wup_1 v01
          
          --Bei Umzugsfilialen: Den Datensatz der neuen Filiale zuordnen, dieser beinhaltet die alte wup_id
          LEFT JOIN dbp_view.v_wup_1 v02
			ON v01.mandant_id = v02. mandant_id
			AND v01.wup_id = v02.wup_id_alt
			AND v01.nb_id = v02.nb_id
			
          WHERE  v01.mandant_id  = 1
;