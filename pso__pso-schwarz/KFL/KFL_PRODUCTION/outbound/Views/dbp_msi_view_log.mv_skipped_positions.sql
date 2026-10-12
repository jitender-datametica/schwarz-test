CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_skipped_positions (mandant_id, lagerauftrag_id,
lageraufgabe_id, lageraufgabe_pos_id, mandant_lageraufgabe_pos, lagernummer_id, lagersortiment_id, lief_beleg_id,
lief_beleg_pos_id, lief_pal_typ_id, ewm_gv_grp_id, ewm_exc_kategorie_id, dat_lief_soll, wg_verkett_lief, werbeware_id,
status_id, lagerprozessart_id, art_id, artikelsortiment_id, ausnahme_code, bus_kontext, ausfuehr_schritt_id,
menge_ist_bme, manuell_erzeugt_fg, lagerauftrag_status_id, lagerauftrag_has_exc_1_fg, lagerauftrag_has_exc_2_fg,
lagerauftrag_has_exc_3_fg) AS SELECT mandant_id,
 lagerauftrag_id,
 lageraufgabe_id,
 lageraufgabe_pos_id,
   CAST(mandant_id AS STRING) || CAST(lageraufgabe_id AS STRING) || CAST(lageraufgabe_pos_id AS STRING) AS
 mandant_lageraufgabe_pos,
 lagernummer_id,
 lagersortiment_id,
 lief_beleg_id,
 lief_beleg_pos_id,
 lief_pal_typ_id,
 ewm_gv_grp_id,
 ewm_exc_kategorie_id,
 dat_lief_soll,
 wg_verkett_lief,
 werbeware_id,
 lageraufgabe_status_id AS status_id,
 lagerprozessart_id,
 art_id,
 artikelsortiment_id,
 ausnahme_code,
 bus_kontext,
 ausfuehr_schritt_id,
 menge_ist_bme,
 manuell_erzeugt_fg,
 lagerauftrag_status_id,
 lagerauftrag_has_exc_1_fg,
 lagerauftrag_has_exc_2_fg,
 lagerauftrag_has_exc_3_fg
FROM kfl_production_dbp_view.v_skipped_positions_ewm AS V0
WHERE (mandant_id, lagernummer_id, lagerauftrag_id) IN (SELECT (mandant_id, lagernummer_id, lagerauftrag_id)
   FROM kfl_production_dbp_view.v_skipped_positions_ewm
   GROUP BY mandant_id,
    lagernummer_id,
    lagerauftrag_id
   HAVING MAX(CASE
      WHEN ewm_gv_grp_id <> ''
      THEN 1
      ELSE 0
      END) > 0);