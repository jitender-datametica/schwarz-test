-- vorher DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_WBS_PROCESSBOARD

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_wbs_customizing_zeitslots_zu AS WITH TAGE AS (SELECT
  DISTINCT V001.mandant_id,
   V001.auslieferungsgruppe_id,
   V000.wtag_id,
   V000.dat
  FROM kfl_production_dbp_view.v_tag AS V000
   INNER JOIN kfl_production_dbp_view.v_wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu AS V001 ON TRUE
  WHERE V000.akt_wo BETWEEN 0 AND 6 -- aktuelle plus die nächsten sechs wochen
) (-- CROSS JOIN damit zu jeder Ausliefergruppe jeder Tag vorhanden ist

  -- pruefung, ob manuell etwas geaendert wurden ist oder nicht

  -- pruefung ob in non adjustable day fuer den mandant gepflegt wurden ist (unabhaengig welches VZ)

  -- wbs_processboard_standard_slots v01
 SELECT DISTINCT v02.mandant_id,
   v02.auslieferungsgruppe_id,
   v02.wtag_id,
   IFNULL(COALESCE(V03.zeitslot_id, V01.zeitslot_id), 0) AS zeitslot_id,
   v02.dat,
    CASE
    WHEN V03.zeitslot_id IS NULL
    THEN 0
    ELSE 1
    END AS flag_manuell,
    CASE
    WHEN V04.non_adjustable_day_fg = 0
    THEN 1
    ELSE 0
    END AS non_adjustable_day_flag
  FROM TAGE AS v02
   LEFT JOIN kfl_production_dbp_view.v_wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu AS V01 ON v02.wtag_id = V01.wtag_id
       AND v02.mandant_id = V01.mandant_id AND v02.auslieferungsgruppe_id -- 
 = V01.auslieferungsgruppe_id
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_zeitslots_aenderung AS V03 ON v02.mandant_id = V03.mandant_id AND v02.auslieferungsgruppe_id
       = V03.auslieferungsgruppe_id AND v02.dat = V03.dat -- pruefen ob etwas im non adjustable day gepflegt ist

   LEFT JOIN kfl_production_dbp_view.v_ts_wbs_vz_tag AS V04 ON v02.mandant_id = V04.mandant_id AND v02.dat = V04.dat);