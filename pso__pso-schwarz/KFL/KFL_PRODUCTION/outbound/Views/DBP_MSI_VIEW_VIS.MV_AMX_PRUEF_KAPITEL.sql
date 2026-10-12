CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_pruef_kapitel (pruef_kapitel_id, pruefung_id,
pruef_kapitel_bez, kapitel_ergebnis_wert) AS SELECT v01.pruef_kapitel_id,
 v01.pruefung_id,
 v01.pruef_kapitel_bez,
 v01.kapitel_ergebnis_wert
FROM (SELECT pruef_kapitel_id,
   pruefung_id,
   pruef_kapitel_bez,
   hauptbereich_id,
   teilbereich_id,
   kapitel_ergebnis_wert
  FROM (SELECT pruef_kapitel_id,
      pruefung_id,
      pruef_kapitel_bez,
      hauptbereich_id,
      teilbereich_id,
      kapitel_ergebnis_wert
     FROM kfl_production_dbp_view.v_amx_pruef_kapitel
     WHERE amx_system_id = 1
     UNION DISTINCT
     SELECT pruef_kapitel_id,
      pruefung_id,
      pruef_kapitel_bez,
      hauptbereich_id,
      teilbereich_id,
      kapitel_ergebnis_wert
     FROM kfl_production_dbp_view.v_amx_de_pruef_kapitel) AS t2) AS v01
 INNER JOIN (SELECT pruefung_id,
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
     FROM kfl_production_dbp_view.v_amx_de_pruefung) AS t7) AS v02 ON v01.pruefung_id = v02.pruefung_id
 INNER JOIN (SELECT business_process_id,
   pruefung_id
  FROM (SELECT business_process_id,
      pruefung_id
     FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu
     WHERE amx_system_id = 1
     UNION DISTINCT
     SELECT business_process_id,
      pruefung_id
     FROM kfl_production_dbp_view.v_amx_de_b_process_pruefung_zu) AS t12) AS v03 ON v02.pruefung_id = v03.pruefung_id
  AND v03.business_process_id = 544687
WHERE v02.zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041);