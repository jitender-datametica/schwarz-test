-- hyg_agg_ebene = 1 => Detail-Ebene
 -- 15.03.2016, AP0007267, srom0404, dat_ende auf dat_real umlegen

-- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_agg_audit_2 AS WITH RECURSIVE CTE_RECURSION AS (SELECT HA.mandant_id,
    WUP.aktuell_wup_id AS wup_id,
    HA.gj,
    DATE(HA.dat_real) AS dat,
    HAD.frage_katalog_id,
    HA.hyg_audit_id,
    HA.audit_instance_id,
    HAD.audit_frage_id,
    1 AS hyg_agg_ebene,
    HAD.hyg_thema_id,
    HAD.hyg_frage_id,
    COALESCE(FTZ.hyg_frage_pos_id, 999) AS hyg_frage_pos_id,
    HAD.audit_frage_bemerkung,
    HAD.hyg_antwort_id,
    HAD.hyg_antwort_punkte,
    HAD.hyg_antwort_max_punkte,
    HAD.hyg_antwort_stufe,
    HAD.hyg_antwort_farbe,
    HAD.hyg_antwort_rel_punkte,
    COALESCE(HAD.hyg_antwort_string, HAD.hyg_antwort_stufe) AS hyg_antwort_string,
    HAD.beantwortet_fg,
    HAD.relevant_fg
   FROM kfl_production_dbp_view.v_hyg_audit_2 AS HA
    INNER JOIN kfl_production_dbp_view.v_hyg_audit_det_2 AS HAD ON HA.hyg_audit_id = HAD.hyg_audit_id AND HA.audit_instance_id
        = HAD.audit_instance_id AND HA.gj = HAD.gj
    LEFT JOIN kfl_production_dbp_view.v_hyg_frage_thema_zu_2 AS FTZ ON HAD.hyg_frage_id = FTZ.hyg_frage_id AND HAD.hyg_thema_id
         = FTZ.hyg_thema_id AND HAD.frage_katalog_id = FTZ.frage_katalog_id AND HAD.gj = FTZ.gj
    INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON HA.mandant_id = WUP.mandant_id AND HA.wup_id = WUP.wup_id
   WHERE HAD.relevant_fg = 1
    OR HAD.hyg_antwort_id <> '00000000-0000-0000-0000-000000000000'
   UNION ALL
   SELECT REC.mandant_id,
    WUP.aktuell_wup_id AS wup_id,
    REC.gj,
    REC.dat,
    REC.frage_katalog_id,
    REC.hyg_audit_id,
    REC.audit_instance_id,
    REC.audit_frage_id,
     REC.hyg_agg_ebene + 1 AS hyg_agg_ebene,
    HT.hyg_thema_mutter_id AS hyg_thema_id,
    REC.hyg_frage_id,
    REC.hyg_frage_pos_id,
    REC.audit_frage_bemerkung,
    REC.hyg_antwort_id,
    REC.hyg_antwort_punkte,
    REC.hyg_antwort_max_punkte,
    REC.hyg_antwort_stufe,
    REC.hyg_antwort_farbe,
    REC.hyg_antwort_rel_punkte,
    REC.hyg_antwort_string,
    REC.beantwortet_fg,
    REC.relevant_fg
   FROM cte_recursion AS REC
    INNER JOIN kfl_production_dbp_view.v_hyg_thema_2 AS HT ON REC.frage_katalog_id = HT.frage_katalog_id AND REC.hyg_thema_id
         = HT.hyg_thema_id AND REC.gj = HT.gj AND HT.hyg_thema_id <> HT.frage_katalog_id
    INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON REC.mandant_id = WUP.mandant_id AND REC.wup_id = WUP.wup_id) (SELECT
   mandant_id,
   wup_id,
   gj,
   dat,
   frage_katalog_id,
   hyg_audit_id,
   audit_instance_id,
   audit_frage_id,
   hyg_agg_ebene,
   hyg_thema_id,
   hyg_frage_id,
   hyg_frage_pos_id,
   audit_frage_bemerkung,
   hyg_antwort_id,
   hyg_antwort_punkte,
   hyg_antwort_max_punkte,
   hyg_antwort_stufe,
   hyg_antwort_farbe,
   hyg_antwort_rel_punkte,
   hyg_antwort_string,
   beantwortet_fg,
   relevant_fg
  FROM cte_recursion);