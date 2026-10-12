-- Darüber können die Datensätze der alten Filiale ermittelt und ausgeschlossen werden.

-- 20.11.2024 twie: SPEC0264080 Erweiterung Konzept um Umzugsfilialen. Hier ist im Gegensatz zur Filialumgliederung in der Tabelle keine Zusammenfassung über die aktuell_wup_id vorhanden

-- im Gegensatz zu mv_l_absender_2 beinhaltet diese View nur WUP_2 (abs_typ_id = 1) keine VZ und Lieferanten (2,3)

-- Stattdessen hat die neue Filiale im Feld wup_id_alt die alte wup_id als Zuordnung enthalten.

-- 15.08.2024 twie: SPEC0264080 neue View mit aktuell_wup_id als PK, ist Elternattribut zu Absender, vereint alte und neue wup_id bei Filialumgliederung in einem Datensatz, deshalb gruppieren

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw_materialized.mv_l_absender_aktuell_2 (aktuell_wup_id, mandant_id,
wup_standort) AS -- Bei Umzugsfilialen: Den Datensatz der neuen Filiale zuordnen, dieser beinhaltet die alte wup_id

-- VZ ausschließen, es sollen nur Märkte ausgegeben werden
 SELECT V01.aktuell_wup_id,
 V01.mandant_id,
 MAX(V01.wup_standort) AS wup_standort
FROM kfl_production_dbp_view.v_wup_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id_alt AND
   V01.nb_id = V02.nb_id
WHERE V01.mandant_id = 1
  -- nur wenn keine neue Filiale gefunden wurde, den Datensatz ausgeben, somit alte Filialen ausschließen

 AND V02.wup_id_alt IS NULL
 AND (V01.nb_id <> -111 OR V01.wup_typ_id NOT IN (1, 2))
 AND V01.nb_id <> 99
GROUP BY V01.aktuell_wup_id,
 V01.mandant_id;