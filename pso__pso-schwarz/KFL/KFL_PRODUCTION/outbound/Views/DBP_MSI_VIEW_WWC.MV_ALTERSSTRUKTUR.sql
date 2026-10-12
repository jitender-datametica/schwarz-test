CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_altersstruktur AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 COALESCE(V02.altersstruktur_tag_id, 7) AS altersstruktur_tag_id,
 COALESCE(V02.altersstruktur_woche_id, 7) AS altersstruktur_woche_id,
 COALESCE(V02.altersstruktur_monat_id, 7) AS altersstruktur_monat_id
FROM kfl_production_dbp_view.v_wup AS V01
 LEFT JOIN kfl_production_dbp_msi_v_view.v_altersstruktur_eis AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02
    .mandant_id AND V01.nb_id = V02.nb_id;