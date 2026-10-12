-- 20230124 twie: SPEC0173748 neue audimex View für Massnahme Antrag

-- PK ist wie bei kmr_massnahme_2 die massnahme_id, es wird nur der letzte Status_2 einer Massnahme gespeichert

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_massnahme_antrag_2 (amx_system_id,
massnahme_id, auditee_letzter_antrag_id, auditee_letzter_antrag_bez, dat_auditee_letzter_antrag,
auditor_letzte_antwort_id, auditor_letzte_antwort_bez, dat_auditor_letzte_antwort) AS SELECT amx_system_id,
 massnahme_id,
 auditee_letzter_antrag_id,
 auditee_letzter_antrag_bez,
 dat_auditee_letzter_antrag,
 auditor_letzte_antwort_id,
 auditor_letzte_antwort_bez,
 dat_auditor_letzte_antwort
FROM dbp_view.v_kmr_massnahme_antrag_2;