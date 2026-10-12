CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_linbew_prog_hc_agg (mandant_id, wup_id, kjmo, anz_prg_beendet
, anz_prg_faellig, anz_prg_gesamt, anz_prg_bearbeitung, anz_prg_ausstehend) AS SELECT V01.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V02.kjmo,
 V01.anz_prg_beendet,
 V01.anz_prg_faellig,
 V01.anz_prg_gesamt,
 V01.anz_prg_bearbeitung,
 V01.anz_prg_ausstehend
FROM kfl_production_dbp_view.v_linbew_prog_hc AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat = V02.dat
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
WHERE V01.wup_id BETWEEN 1 AND 8999
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V02.kjmo AS STRING)
      ORDER BY V01.dat IS NULL, V01.dat)) = 1;