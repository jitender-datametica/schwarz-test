CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_artbew_wg_sum_1 (mandant_id, wup_id, wg_id, bewart_id, dat, nb_id
, arthiertyp_id, umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, kjmo, menge, quelle) AS
SELECT mandant_id,
 wup_id,
 wg_id,
 bewart_id,
 dat,
 nb_id,
 arthiertyp_id,
 umsatz_brutto,
 umsatz_netto,
 umsatz_wrg,
 umsatz_brutto_konz,
 umsatz_netto_konz,
 kjmo,
 menge,
 quelle
FROM kfl_production_dbp_view.v_artbew_wg_sum_1 AS V01;