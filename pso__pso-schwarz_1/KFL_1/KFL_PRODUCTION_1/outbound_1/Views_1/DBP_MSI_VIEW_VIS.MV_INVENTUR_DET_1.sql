CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_inventur_det_1 (mandant_id, nb_id, wup_id, dat_buch,
dat_letzt_zaehl, nullzaehl_fg, art_id, wrg_id, erfsngs_menge_einh_id, menge_erf, menge_gezaehlt, menge_gebucht,
menge_differenz, wert_vk_brutto, vk_inventur_diff_brutto, vk_brutto, bestand_korrektur_brutto, wert_vk_netto,
vk_inventur_diff_netto, vk_netto, bestand_korrektur_netto, wert_diff_inv, wert_vk_extern, menge_buch, menge_zaehl) AS
SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.dat_buch,
 V01.dat_letzt_zaehl,
 V01.nullzaehl_fg,
 V01.art_id,
 V02.default_wrg AS wrg_id,
 V01.erfsngs_menge_einh_id,
 V01.menge_erf,
 V01.menge_zaehl AS menge_gezaehlt,
 V01.menge_buch AS menge_gebucht,
  V01.menge_zaehl - V01.menge_buch AS menge_differenz,
 V01.wert_vk_brutto,
 V01.vk_inventur_diff_brutto,
 ABS(V01.wert_vk_brutto / CASE
    WHEN V01.menge_zaehl - V01.menge_buch = 0
    THEN NULL
    ELSE V01.menge_zaehl - V01.menge_buch
    END) AS vk_brutto,
  CASE
  WHEN V01.menge_zaehl - V01.menge_buch < 0
  THEN V01.wert_vk_brutto * - 1
  ELSE V01.wert_vk_brutto
  END AS bestand_korrektur_brutto,
 V01.wert_vk_netto,
 V01.vk_inventur_diff_netto,
 ABS(V01.wert_vk_netto / CASE
    WHEN V01.menge_zaehl - V01.menge_buch = 0
    THEN NULL
    ELSE V01.menge_zaehl - V01.menge_buch
    END) AS vk_netto,
  CASE
  WHEN V01.menge_zaehl - V01.menge_buch < 0
  THEN V01.wert_vk_netto * - 1
  ELSE V01.wert_vk_netto
  END AS bestand_korrektur_netto,
 V01.wert_diff_inv,
 V01.wert_vk_extern,
 V01.menge_buch,
 V01.menge_zaehl
FROM kfl_production_dbp_view.v_inventur_det_1 AS V01
 INNER JOIN kfl_production_dbp_data.mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;