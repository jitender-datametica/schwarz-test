CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hydra_leistung_2 (mandant_id, buchungskreis_id_hydra,
produktivitaetsschl_hydra, lagernummer_id, transport_gv_id, belegart_id_hydra, wg_verkett_lief, artikelsortiment_id, dat
, menge_1, dauer_1, menge_2, dauer_2, menge_3, dauer_3, menge_4, dauer_4, abrechnung_fg, abrechnung_fg_s,
abrechnung_fg_desc) AS SELECT HL.mandant_id,
 HL.buchungskreis_id_hydra,
 HL.produktivitaetsschl_hydra,
 HL.lagernummer_id,
 HL.transport_gv_id,
 HL.belegart_id_hydra,
 HL.wg_verkett_lief,
 COALESCE(ART_SORT.artikelsortiment_id, '-1') AS artikelsortiment_id,
 HL.dat,
 HL.menge_1,
 HL.dauer_1,
 HL.menge_2,
 HL.dauer_2,
 HL.menge_3,
 HL.dauer_3,
 HL.menge_4,
 HL.dauer_4,
 HL.abrechnung_fg,
  CASE
  WHEN HL.abrechnung_fg = 1
  THEN 'X'
  ELSE ''
  END AS abrechnung_fg_s,
  CASE
  WHEN HL.abrechnung_fg = 1
  THEN 'Rechnungslauf abgeschlossen (Hydra)'
  ELSE 'Rechnungslauf noch offen (Hydra)'
  END AS abrechnung_fg_desc
FROM kfl_production_dbp_view.v_hydra_leistung_2 AS HL_2
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_2 AS ART_SORT ON HL.lagernummer_id = ART_SORT.lagernummer_id
    AND HL.mandant_id = ART_SORT.mandant_id;