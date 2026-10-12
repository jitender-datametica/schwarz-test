CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_besch_lief_arbeitsbereiche_2 (mandant_id, lagerort_id
, wup_id, nb_id, kunde_id, wtag_id, dat_lief_soll, wg_id, arthiertyp_id, disponent_id, wg_verkett_id,
disposition_rhythmus_ltf_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id,
auslieferungsgruppe_id, kunde_bez, disposition_rhythmus_id, disponent_name, wup_standort, bestellart_id, lief_pal_typ_id
, diff_id, menge_lief_ist_kolli, menge_lief_soll_kolli, betrag_lief_ist, betrag_lief_soll, menge_lief_palette,
mandant_id_kunde) AS SELECT mandant_id,
 lagerort_id,
 wup_id,
 nb_id,
 kunde_id,
 wtag_id,
 dat_lief_soll,
 wg_id,
 arthiertyp_id,
 disponent_id,
 wg_verkett_id,
 disposition_rhythmus_ltf_id,
 terminierungsgruppe_1_id,
 terminierungsgruppe_2_id,
 terminierungsgruppe_3_id,
 auslieferungsgruppe_id,
 kunde_bez,
 disposition_rhythmus_id,
 disponent_name,
 wup_standort,
 bestellart_id,
 CAST(lief_pal_typ_id AS STRING) AS lief_pal_typ_id,
 diff_id,
  CASE
  WHEN dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE menge_lief_ist_kolli
  END AS menge_lief_ist_kolli,
  CASE
  WHEN dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE menge_lief_soll_kolli
  END AS menge_lief_soll_kolli,
  CASE
  WHEN dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE betrag_lief_ist
  END AS betrag_lief_ist,
  CASE
  WHEN dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE betrag_lief_soll
  END AS betrag_lief_soll,
  CASE
  WHEN dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE menge_lief_palette
  END AS menge_lief_palette,
 mandant_id_kunde
FROM kfl_production_dbp_view.v_besch_lief_arbeitsbereiche_2 AS V01
WHERE EXTRACT(YEAR FROM dat_lief_soll) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;