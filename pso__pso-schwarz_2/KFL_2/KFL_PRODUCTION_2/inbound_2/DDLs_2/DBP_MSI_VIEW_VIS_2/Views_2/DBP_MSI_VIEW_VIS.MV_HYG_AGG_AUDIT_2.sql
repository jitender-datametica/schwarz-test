CREATE OR REPLACE RECURSIVE VIEW DBP_MSI_VIEW_VIS.MV_HYG_AGG_AUDIT_2(
   mandant_id
   , wup_id
   , gj
   , dat
   , frage_katalog_id
   , hyg_audit_id
   , audit_instance_id
   , audit_frage_id
   , hyg_agg_ebene
   , hyg_thema_id
   , hyg_frage_id
   , hyg_frage_pos_id
   , audit_frage_bemerkung
   , hyg_antwort_id
   , hyg_antwort_punkte
   , hyg_antwort_max_punkte
   , hyg_antwort_stufe
   , hyg_antwort_farbe
   , hyg_antwort_rel_punkte
   , hyg_antwort_string
   , beantwortet_fg
   , relevant_fg
) AS

-- 15.03.2016, AP0007267, srom0404, dat_ende auf dat_real umlegen
-- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

 SELECT
   ha.mandant_id
   , wup.aktuell_wup_id AS wup_id
   , ha.gj
   , CAST(ha.dat_real AS DATE)   dat
   , had.frage_katalog_id
   , ha.hyg_audit_id
   , ha.audit_instance_id
   , had.audit_frage_id
   , 1 AS hyg_agg_ebene               -- hyg_agg_ebene = 1 => Detail-Ebene
   , had.hyg_thema_id, had.hyg_frage_id
   , COALESCE (ftz.hyg_frage_pos_id, 999)
   , had.audit_frage_bemerkung
   , had.hyg_antwort_id
   , had.hyg_antwort_punkte
   , had.hyg_antwort_max_punkte
   , had.hyg_antwort_stufe
   , had.hyg_antwort_farbe
   , had.hyg_antwort_rel_punkte
   , COALESCE(had.hyg_antwort_string, had.hyg_antwort_stufe)  _hyg_antwort_string
   , had.beantwortet_fg
   , had.relevant_fg
FROM dbp_view.v_hyg_audit_2  ha
INNER JOIN dbp_view.v_hyg_audit_det_2  had
ON  ha.hyg_audit_id = had.hyg_audit_id
AND ha.audit_instance_id = had.audit_instance_id
AND ha.gj = had.gj

LEFT OUTER JOIN dbp_view.v_hyg_frage_thema_zu_2 ftz
ON  had.hyg_frage_id = ftz.hyg_frage_id
AND had.hyg_thema_id = ftz.hyg_thema_id
AND had.frage_katalog_id = ftz.frage_katalog_id
AND had.gj = ftz.gj

INNER JOIN dbp_view.v_wup_2 wup_2
ON ha.mandant_id = wup.mandant_id AND ha.wup_id = wup.wup_id

WHERE had.relevant_fg = 1
OR had.hyg_antwort_id <> '00000000-0000-0000-0000-000000000000'

UNION ALL

SELECT
   rec.mandant_id
   , wup.aktuell_wup_id AS wup_id
   , rec.gj
   , rec.dat
   , rec.frage_katalog_id
   , rec.hyg_audit_id
   , rec.audit_instance_id
   , rec.audit_frage_id
   , rec.hyg_agg_ebene + 1 _hyg_agg_ebene               -- hyg_agg_ebene = 1 => Detail-Ebene
   , ht.hyg_thema_mutter_id
   , rec.hyg_frage_id
   , rec.hyg_frage_pos_id
   , rec.audit_frage_bemerkung
   , rec.hyg_antwort_id
   , rec.hyg_antwort_punkte
   , rec.hyg_antwort_max_punkte
   , rec.hyg_antwort_stufe
   , rec.hyg_antwort_farbe
   , rec.hyg_antwort_rel_punkte
   , rec.hyg_antwort_string
   , rec.beantwortet_fg, rec.relevant_fg
FROM mv_hyg_agg_audit_2 rec

INNER JOIN dbp_view.v_hyg_thema_2  ht
ON  rec.frage_katalog_id = ht.frage_katalog_id
AND rec.hyg_thema_id = ht.hyg_thema_id
AND rec.gj = ht.gj
AND ht.hyg_thema_id <> ht.frage_katalog_id

INNER JOIN dbp_view.v_wup_2 wup_2
ON rec.mandant_id = wup.mandant_id AND rec.wup_id = wup.wup_id
;