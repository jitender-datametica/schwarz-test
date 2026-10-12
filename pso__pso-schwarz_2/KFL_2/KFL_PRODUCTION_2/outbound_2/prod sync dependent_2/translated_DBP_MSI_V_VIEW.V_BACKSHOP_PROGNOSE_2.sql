CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_backshop_prognose_2 (art_id, mandant_id, wup_id, nb_id, dat,
menge_prognose, min_sicherh_bestand, listung_id, aktion_fg, menge_check, anteil_01, anteil_02, anteil_03, anteil_04) AS
SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat,
 menge_prognose,
 min_sicherh_bestand,
 listung_id,
 aktion_fg,
 menge_check,
 anteil_01,
 anteil_02,
 anteil_03,
 anteil_04
FROM kfl_production_dbp_msi_data.backshop_prognose_2;