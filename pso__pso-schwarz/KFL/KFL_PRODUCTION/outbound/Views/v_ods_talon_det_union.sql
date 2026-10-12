CREATE OR REPLACE VIEW kfl_production_dbp_spezial.v_ods_talon_det_union (mandant_id, talon_id, talon_pos_id, wup_id,
kl_art_id, umsatz_brutto, menge, mwst, wg_id, turnover_fg, artbew_fg, aktion_id) AS SELECT mandant_id,
 talon_id,
 talon_pos_id,
 wup_id,
 kl_art_id,
 umsatz_brutto,
 menge,
 mwst,
 wg_id,
 turnover_fg,
 artbew_fg,
 aktion_id
FROM kfl_production_dbp_ods.ods_talon_det
UNION ALL
SELECT mandant_id,
 talon_id,
 talon_pos_id,
 wup_id,
 kl_art_id,
 umsatz_brutto,
 menge,
 mwst,
 wg_id,
 turnover_fg,
 artbew_fg,
 aktion_id
FROM kfl_production_dbp_ods_archiv.ods_talon_det;