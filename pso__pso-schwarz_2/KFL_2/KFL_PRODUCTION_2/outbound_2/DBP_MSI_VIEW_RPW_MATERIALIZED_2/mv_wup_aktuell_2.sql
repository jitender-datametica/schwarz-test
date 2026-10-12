-- 20.11.2024 twie: SPEC0264080 Erweiterung Konzept um Umzugsfilialen. Hier ist im Gegensatz zur Filialumgliederung in der Tabelle keine Zusammenfassung über die aktuell_wup_id vorhanden

-- Stattdessen hat die neue Filiale im Feld wup_id_alt die alte wup_id als Zuordnung enthalten.

-- 15.08.2024 twie: SPEC0264080 neue View mit aktuell_wup_id als PK, ist Elternattribut zu wup_id, vereint alte und neue wup_id bei Filialumgliederung in einem Datensatz, deshalb gruppieren

-- Darüber können die Datensätze der alten Filiale ermittelt und ausgeschlossen werden.

CREATE OR REPLACE VIEW dbp_msi_view_rpw_materialized.mv_wup_aktuell_2 (aktuell_wup_id, mandant_id,
wup_standort) AS -- ASCII Codes stehen für geschweifte Klammern, wegen Darstellungsproblem in der View als Code

-- Bei Umzugsfilialen: Den Datensatz der neuen Filiale zuordnen, dieser beinhaltet die alte wup_id

-- 07.07.10: NB_2 99 IWT aufgenommen
 -- für WUP_2 8120 Internet Direktversand
 SELECT V01.aktuell_wup_id,
 V01.mandant_id,
 MAX(CASE
   WHEN V01.dat_bis < DATE '9999-12-31'
   THEN CHR(123) || V01.wup_standort || CHR(125)
   ELSE V01.wup_standort
   END) AS wup_standort
FROM dbp_view.v_wup_2 AS V01
 LEFT JOIN dbp_view.v_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id_alt AND
   V01.nb_id = V02.nb_id
WHERE V01.mandant_id = 1
  -- nur wenn keine neue Filiale gefunden wurde, den Datensatz ausgeben, somit alte Filialen ausschließen

 AND V02.wup_id_alt IS NULL
 AND (V01.nb_id IN (0, -111, 2, 99) OR V01.wup_id = 0 AND V01.nb_id = -1 OR V01.nb_id = -1 AND V01.vw_id = 6)
GROUP BY V01.aktuell_wup_id,
 V01.mandant_id;