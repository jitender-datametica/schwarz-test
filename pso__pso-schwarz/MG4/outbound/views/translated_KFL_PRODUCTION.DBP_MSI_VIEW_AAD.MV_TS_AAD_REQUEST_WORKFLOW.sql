CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ts_aad_request_workflow AS WITH t_antraege_verlauf AS (SELECT
   aad_request_id,
   dwh_created_tmsp,
   MIN(dwh_created_tmsp) OVER (PARTITION BY aad_request_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   antragsdatum_zeitraumerweiterung,
   MIN(dwh_created_tmsp) OVER (PARTITION BY aad_request_id, request_status_type_id, request_reason_type_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS datum_status_aenderung,
   MIN(request_type_id) OVER (PARTITION BY aad_request_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   zusammenfassung_fg,
   RANK() OVER (PARTITION BY aad_request_id ORDER BY dwh_created_tmsp IS NULL DESC, dwh_created_tmsp DESC) AS
   antraege_verlauf
  FROM kfl_production_dbp_msi_data.ts_aad_request_workflow) (SELECT v01.aad_request_id,
   v01.creator_user_id,
   v01.scenario_id,
   v03.aktuell_wup_id AS wup_id,
   v01.mandant_id,
   v01.hashed_cashier_id,
   v01.request_reason_type_id,
   v01.scenario_hit_receipts_cnt,
   v01.fraud_value_gross_local_val,
    CASE
    WHEN v01.request_type_id = 0
    THEN DATE(v02.antragsdatum_zeitraumerweiterung)
    ELSE DATE(v01.dwh_created_tmsp)
    END AS dwh_created_tmsp,
   v01.request_type_id,
   v01.wrg_id,
   v01.creation_reason_comment_txt,
   v01.comment_txt,
   v01.first_approver_user_id,
   v01.second_approver_user_id,
   v01.request_status_type_id,
   v01.expiration_tmsp,
   v01.approve_by_council_fg,
    CASE
    WHEN v01.criminal_complain_fg = 1
    THEN 'Ja'
    WHEN v01.criminal_complain_fg = 0
    THEN 'Nein'
    ELSE '-'
    END AS criminal_complain_fg,
   v01.criminal_complain_fg AS criminal_complain_fg_id,
    CASE
    WHEN v01.request_status_type_id IN (2, 4, 12)
    THEN 1
    WHEN v01.request_status_type_id = 7
    THEN 0
    ELSE NULL
    END AS genehmigt_flag_genehmiger,
    CASE
    WHEN v01.request_status_type_id = 4
    THEN 1
    WHEN v01.request_status_type_id = 7
    THEN 0
    ELSE NULL
    END AS genehmigt_flag_2_genehmiger,
   v02.antraege_verlauf,
   DATETIME_DIFF(v02.datum_status_aenderung, v02.antragsdatum_zeitraumerweiterung, DAY) AS dauer,
   v01.loss_amount_gross_local_val,
   v01.taken_measure_comment_txt,
    CASE
    WHEN v01.request_status_type_id = 4 AND v02.antraege_verlauf = 1
    THEN 'Antrag abschlie\u00dfen'
    WHEN v01.request_type_id = 0 AND v02.antraege_verlauf = 1
    THEN 'Antrag einsehen'
    ELSE ''
    END AS link_anlage_zusammenfassung,
    CASE
    WHEN (v01.request_status_type_id = 4 OR v01.request_type_id = 0) AND v02.antraege_verlauf = 1
    THEN 'weitere Bons hinzufuegen'
    ELSE ''
    END AS link_weitere_bons,
    CASE
    WHEN v02.zusammenfassung_fg = 0
    THEN 1
    ELSE 0
    END AS zusammenfassung_fg
  FROM kfl_production_dbp_msi_data.ts_aad_request_workflow AS v01
   INNER JOIN t_antraege_verlauf AS v02 ON v01.aad_request_id = v02.aad_request_id AND v01.dwh_created_tmsp = v02.dwh_created_tmsp
     
   INNER JOIN kfl_production_dbp_view.v_wup AS v03 ON v01.wup_id = v03.wup_id AND v01.mandant_id = v03.mandant_id);