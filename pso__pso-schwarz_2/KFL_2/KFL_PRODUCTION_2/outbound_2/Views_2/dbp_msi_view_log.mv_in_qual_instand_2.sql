CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_qual_instand_2 (mandant_id, qual_meldung_id, ausfall_fg,
ausfallzeit_sekunden, auftrag_id, auftragsart_id, dat_buch, werk_id, tp_objekt_id) AS SELECT IN_Q.mandant_id,
 IN_Q.qual_meldung_id,
 IN_Q.ausfall_fg,
 IN_Q.ausfallzeit_sekunden,
 INST.auftrag_id,
 IN_A.auftragsart_id,
 dat.dat_buch,
 IN_A.werk_id,
 INST.tp_objekt_id
FROM kfl_production_dbp_view.v_in_qual_instand_2 AS IN_Q
 INNER JOIN kfl_production_dbp_view.v_in_instandhaltung_2 AS INST ON IN_Q.qual_meldung_id = INST.qual_meldung_id AND IN_Q
   .mandant_id = INST.mandant_id
 INNER JOIN kfl_production_dbp_view.v_in_auftrag_2 AS IN_A ON INST.auftrag_id = IN_A.auftrag_id AND INST.mandant_id = IN_A
   .mandant_id
 INNER JOIN (SELECT V01.auftrag_id,
   V01.mandant_id,
   COALESCE(MAX(v02.dat_buch), MAX(v03.dat_start)) AS dat_buch
  FROM kfl_production_dbp_view.v_in_auftrag_2 AS V01
   LEFT JOIN (SELECT DISTINCT mandant_id,
     auftrag_id,
     dat_buch
    FROM kfl_production_dbp_view.v_in_auftrag_rm_2) AS v02 ON V01.auftrag_id = v02.auftrag_id AND V01.mandant_id = v02.mandant_id
     
   LEFT JOIN (SELECT auftrag_id,
     mandant_id,
     dat_start
    FROM kfl_production_dbp_view.v_in_auftrag_pps_2) AS v03 ON V01.auftrag_id = v03.auftrag_id AND V01.mandant_id = v03.mandant_id
     
  GROUP BY V01.auftrag_id,
   V01.mandant_id) AS dat ON INST.mandant_id = dat.mandant_id AND INST.auftrag_id = dat.auftrag_id;