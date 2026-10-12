CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_problemmeldung_2 (system_id, mandant_id, problemmeldung_id,
ecm_vorgang, beleg_pos_id, problemcode_id, zeitstempel, belegklasse_id, ursprung_beleg_id, ursprung_beleg_pos_id,
ursprung_beleg_gj, gp_rech_id, gp_rech_pos_id, auto_fg, loesch_fg, gp_id, gp_id_last, einkaufsorganisation_id, art_id,
wup_id, nb_id, betrag_brutto, betrag_netto, betrag_mwst, wrg_id, ersteller_id, verursacher_id, imprint_nr, edi_nr,
beleg_id, beleg_gj, dat, dat_erfasst, dat_buch, double_fg, kopf_kz, rpw_beleg_zu_id, prozessbereich_id, last_fg) AS
SELECT 7 AS system_id,
 mandant_id,
 problemmeldung_id,
 ecm_vorgang,
 beleg_pos_id,
 problemcode_id,
 zeitstempel,
 belegklasse_id,
 ursprung_beleg_id,
 ursprung_beleg_pos_id,
 ursprung_beleg_gj,
 gp_rech_id,
 gp_rech_pos_id,
  CASE
  WHEN manuelle_buchung_fg = 0
  THEN 1
  ELSE 0
  END AS auto_fg,
 loesch_fg,
 gp_id,
 last_gp_id AS gp_id_last,
 einkaufsorganisation_id,
 art_id,
 wup_id,
 nb_id,
 betrag_brutto,
 betrag_netto,
 betrag_mwst,
 wrg_id,
 ersteller_id,
 verursacher_id,
 imprint_nr,
 edi_nr,
 beleg_id,
 beleg_gj,
 dat,
 dat_erfasst,
 dat_buch,
  CASE
  WHEN problemcode_id = '0458' AND loesch_fg = 0
  THEN 1
  ELSE 0
  END AS double_fg,
  CASE
  WHEN beleg_pos_id = 0
  THEN 'Kopf'
  ELSE 'Position'
  END AS kopf_kz,
 beleg_id_orig AS rpw_beleg_zu_id,
 prozessbereich_id,
 last_fg
FROM kfl_production_dbp_view.v_problemmeldung_2 AS V01
WHERE mandant_id = 1;