-- 2026-01-26, dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_avq_werbung_tag_1 (mandant_id,
wup_id, nb_id, art_id, dat_aktion_bis, dat_aktion_von, tag_index, dat, menge_bestand, menge_abverkauf,
menge_abverkauf_af, menge_we, wrg_id, betrag_umsatz_netto, exc209_fg, nullbestand_fg, exc214_fg, minusbestand_fg) AS
SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_aktion_bis,
 dat_aktion_von,
 tag_index,
 dat,
 menge_bestand,
 menge_abverkauf,
 menge_abverkauf_af,
 menge_we,
 wrg_id,
 betrag_umsatz_netto,
 exc209_fg,
 nullbestand_fg,
 exc214_fg,
 minusbestand_fg
FROM kfl_production_dbp_view.v_avq_werbung_tag_1 AS WT
WHERE tag_index <> 0;