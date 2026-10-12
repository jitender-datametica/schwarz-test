CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_lieferant_2 (in_lief_id, mandant_id, lief_name_1,
lief_name_2, in_lief_nr, gp_ort, werk_id, loesch_fg, in_lief_id_int, subkategorie_1_id, konzern_id, lief_name_lang,
zuordnen_fg, zuordnung_loeschen_fg) AS SELECT DT1.in_lief_id,
 DT1.mandant_id,
 DT1.lief_name_1,
 DT1.lief_name_2,
 LTRIM(CAST(DT1.in_lief_nr AS STRING), '0') AS in_lief_nr,
 DT1.gp_ort,
 DT1.werk_id,
 DT1.loesch_fg,
 COALESCE(DT1.in_lief_id_int, - 1) AS in_lief_id_int,
 DT1.subkategorie_1_id,
 DT1.konzern_id,
   TRIM(DT1.lief_name_1) || ' ' || LTRIM(CAST(DT1.in_lief_nr AS STRING), '0') AS lief_name_lang,
 0 AS zuordnen_fg,
 0 AS zuordnung_loeschen_fg
FROM kfl_production_dbp_view.v_in_lieferant_2 AS DT1
 INNER JOIN kfl_production_dbp_view.v_in_lieferant_ekorg_zu_2 AS DT2 ON DT1.mandant_id = DT2.mandant_id AND DT1.in_lief_id
     = DT2.in_lief_id AND DT2.einkaeufer_grp_id IS NOT NULL
 INNER JOIN kfl_production_dbp_view.v_in_l_ekorg_2 AS DT3 ON DT2.mandant_id = DT3.mandant_id AND DT2.einkaufsorganisation_id
     = DT3.einkaufsorganisation_id AND DT3.sako_fg = 1
QUALIFY (SUM(1) OVER (PARTITION BY CAST(DT1.mandant_id AS STRING), CAST(DT1.in_lief_id AS STRING) ORDER BY DT2.einkaufsorganisation_id
      IS NULL, DT2.einkaufsorganisation_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1;