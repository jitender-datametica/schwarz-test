CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_pruefung (pruefung_id, pruefung_nr, zustand_id,
pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert,
business_unit_id, mandant_id, wup_id) AS SELECT v01.pruefung_id,
 v01.pruefung_nr,
 v01.zustand_id,
 v01.pruefung_bez,
 v01.dat_start,
 v01.dat_ende,
 v01.revisor_id,
 v01.pruefung_typ_id,
 v01.pruefung_klasse_id,
 v01.pruefung_ergebnis_wert,
 v01.business_unit_id,
 v01.mandant_id,
 WUP.aktuell_wup_id AS wup_id
FROM (SELECT pruefung_id,
   pruefung_nr,
   zustand_id,
   pruefung_bez,
   dat_start,
   dat_ende,
   revisor_id,
   pruefung_typ_id,
   pruefung_klasse_id,
   pruefung_ergebnis_wert,
   business_unit_id,
   mandant_id,
   wup_id
  FROM (SELECT pruefung_id,
      pruefung_nr,
      zustand_id,
      pruefung_bez,
      dat_start,
      dat_ende,
      revisor_id,
      pruefung_typ_id,
      pruefung_klasse_id,
      pruefung_ergebnis_wert,
      business_unit_id,
      mandant_id,
      wup_id
     FROM kfl_production_dbp_view.v_amx_pruefung
     WHERE amx_system_id = 1
     UNION DISTINCT
     SELECT pruefung_id,
      pruefung_nr,
      zustand_id,
      pruefung_bez,
      dat_start,
      dat_ende,
      revisor_id,
      pruefung_typ_id,
      pruefung_klasse_id,
      pruefung_ergebnis_wert,
      business_unit_id,
      mandant_id,
      wup_id
     FROM kfl_production_dbp_view.v_amx_de_pruefung) AS t2) AS v01
 INNER JOIN (SELECT business_process_id,
   pruefung_id
  FROM (SELECT business_process_id,
      pruefung_id
     FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu
     WHERE amx_system_id = 1
     UNION DISTINCT
     SELECT business_process_id,
      pruefung_id
     FROM kfl_production_dbp_view.v_amx_de_b_process_pruefung_zu) AS t7) AS v02 ON v01.pruefung_id = v02.pruefung_id AND
   v02.business_process_id = 544687
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON v01.mandant_id = WUP.mandant_id AND CASE
    WHEN v01.wup_id = - 1
    THEN 0
    ELSE v01.wup_id
    END = WUP.wup_id
WHERE v01.zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041);