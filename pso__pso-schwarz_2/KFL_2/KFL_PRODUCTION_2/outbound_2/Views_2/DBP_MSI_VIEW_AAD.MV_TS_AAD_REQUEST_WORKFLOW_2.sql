CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ts_aad_request_workflow_2 AS WITH T_ANTRAEGE_VERLAUF AS (SELECT
   aad_request_id,
   dwh_created_tmsp,
   MIN(dwh_created_tmsp) OVER (PARTITION BY CAST(aad_request_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS antragsdatum_zeitraumerweiterung,
   MIN(dwh_created_tmsp) OVER (PARTITION BY CAST(aad_request_id AS STRING), CAST(request_status_type_id AS STRING), CAST(request_reason_type_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS datum_status_aenderung,
   MIN(request_type_id) OVER (PARTITION BY CAST(aad_request_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS zusammenfassung_fg,
   RANK() OVER (PARTITION BY CAST(aad_request_id AS STRING) ORDER BY dwh_created_tmsp IS NULL DESC, dwh_created_tmsp
      DESC) AS antraege_verlauf
  FROM kfl_production_dbp_msi_data.ts_aad_request_workflow_2) (SELECT V01.aad_request_id,
   V01.creator_user_id,
   V01.scenario_id,
   V03.aktuell_wup_id AS wup_id,
   V01.mandant_id,
   V01.hashed_cashier_id,
   V01.request_reason_type_id,
   V01.scenario_hit_receipts_cnt,
   V01.fraud_value_gross_local_val,
    CASE
    WHEN V01.request_type_id = 0
    THEN DATE(v02.antragsdatum_zeitraumerweiterung)
    ELSE DATE(V01.dwh_created_tmsp)
    END AS dwh_created_tmsp,
   V01.request_type_id,
   V01.wrg_id,
   V01.creation_reason_comment_txt,
   V01.comment_txt,
   V01.first_approver_user_id,
   V01.second_approver_user_id,
   V01.request_status_type_id,
   V01.expiration_tmsp,
   V01.approve_by_council_fg,
    CASE
    WHEN V01.criminal_complain_fg = 1
    THEN 'Ja'
    WHEN V01.criminal_complain_fg = 0
    THEN 'Nein'
    ELSE '-'
    END AS criminal_complain_fg,
   V01.criminal_complain_fg AS criminal_complain_fg_id,
    CASE
    WHEN V01.request_status_type_id IN (2, 4, 12)
    THEN 1
    WHEN V01.request_status_type_id = 7
    THEN 0
    ELSE NULL
    END AS genehmigt_flag_genehmiger,
    CASE
    WHEN V01.request_status_type_id = 4
    THEN 1
    WHEN V01.request_status_type_id = 7
    THEN 0
    ELSE NULL
    END AS genehmigt_flag_2_genehmiger,
   v02.antraege_verlauf,
   DATETIME_DIFF(v02.datum_status_aenderung, v02.antragsdatum_zeitraumerweiterung, DAY) AS dauer,
   V01.loss_amount_gross_local_val,
   V01.taken_measure_comment_txt,
    CASE
    WHEN V01.request_status_type_id = 4 AND v02.antraege_verlauf = 1
    THEN 'Antrag abschlie\u00dfen'
    WHEN V01.request_type_id = 0 AND v02.antraege_verlauf = 1
    THEN 'Antrag einsehen'
    ELSE ''
    END AS link_anlage_zusammenfassung,
    CASE
    WHEN (V01.request_status_type_id = 4 OR V01.request_type_id = 0) AND v02.antraege_verlauf = 1
    THEN 'weitere Bons hinzufuegen'
    ELSE ''
    END AS link_weitere_bons,
    CASE
    WHEN v02.zusammenfassung_fg = 0
    THEN 1
    ELSE 0
    END AS zusammenfassung_fg
  FROM kfl_production_dbp_msi_data.ts_aad_request_workflow_2 AS V01
   INNER JOIN T_ANTRAEGE_VERLAUF AS v02 ON V01.aad_request_id = v02.aad_request_id AND V01.dwh_created_tmsp = v02.dwh_created_tmsp
     
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V03 ON V01.wup_id = V03.wup_id AND V01.mandant_id = V03.mandant_id);