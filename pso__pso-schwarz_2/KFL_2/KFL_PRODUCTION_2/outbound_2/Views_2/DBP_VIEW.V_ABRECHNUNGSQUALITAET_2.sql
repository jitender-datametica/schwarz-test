CREATE OR REPLACE VIEW kfl_production_dbp_view.v_abrechnungsqualitaet_2 AS SELECT kjmo,
 gp_id,
 system_id,
 mandant_id,
 einkaufsorganisation_id,
 rechnung_anz,
 rechnung_netto,
 rechnung_maschinell_anz,
 rechnung_manuell_anz,
 belastungsanzeigen_anz,
 belastungsanzeigen_netto,
 rueckbelastungsanzeigen_anz,
 rueckbelastungsanzeigen_netto
FROM kfl_production_dbp_data.abrechnungsqualitaet_2;