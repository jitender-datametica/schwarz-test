CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_linbew_prog_hc_org_agg (mandant_id, hr_objekt_id, kjmo,
anz_prg_beendet, anz_prg_faellig, anz_prg_gesamt, anz_prg_bearbeitung, anz_prg_ausstehend) AS SELECT V01.mandant_id,
 V01.hr_objekt_id,
 V02.kjmo,
 V01.anz_prg_beendet,
 V01.anz_prg_faellig,
 V01.anz_prg_gesamt,
 V01.anz_prg_bearbeitung,
 V01.anz_prg_ausstehend
FROM kfl_production_dbp_view.v_linbew_prog_hc_org AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat = V02.dat
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.hr_objekt_id AS STRING), CAST(V02.kjmo AS STRING)
      ORDER BY V01.dat IS NULL, V01.dat)) = 1;