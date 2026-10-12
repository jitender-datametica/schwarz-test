-- 26.07.2022 twie: SPEC0155060 neue Spezialview, die 4 Entitäten (Prüfprogramm, Haupt-, Teil-, und Unterbereich) in eine_1 vereint (Kapitel)

-- ACHTUNG, View gehört thematisch nicht zu AMX_ Views des Kurzchecks, sondern zu den audimex Views KMR_, welche inhaltlich und vom Datenmodell komplett getrennt sind

-- 08.11.2022 twie: SPEC0175650 View muss nicht mehr aus den 4 Teilbereichen zusammengesetzt werden sondern es gibt jetzt eine_1 eigene Tabelle für Kapitel

-- Kapitel damit ebenfalls Kind von Prüfung, aber ist nicht mehr mit den ursprünglichen 4 Attributen verknüpfbar, sondern nur für einen Spezialbericht gedacht

-- 03.08.2022 twie: kapitel_typ_id eingefügt, um die 4 inhaltlich verschiedenen Typen von Kapitel im Frontend zu unterscheiden. Zugehörige Lookup ist MV_KMR_L_KAPITEL_TYP_1

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_kapitel_1 (amx_system_id, pruefung_id,
kapitel_id, kapitel_nr, kapitel_typ_id, sort_nr, fehlerverdacht_fg, kapitel_bez, gepr_prozess_id, ergebnis,
ergebnis_berechnet, ergebnis_manuell) AS SELECT amx_system_id,
 pruefung_id,
 kapitel_id,
 kapitel_nr,
 kapitel_typ_id,
 sort_nr,
 fehlerverdacht_fg,
 kapitel_bez,
 gepr_prozess_id,
 ergebnis,
 ergebnis_berechnet,
 ergebnis_manuell
FROM dbp_view.v_kmr_pruefprogramm_kapitel_1 AS V01;