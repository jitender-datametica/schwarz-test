CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_abrechnungsqualitaet_1 (kjmo, gp_id, rechnung_anz, rechnung_netto,
rechnung_maschinell_anz, rechnung_manuell_anz, belastungsanzeigen_anz, belastungsanzeigen_netto,
rueckbelastungsanzeigen_anz, rueckbelastungsanzeigen_netto) AS SELECT kjmo,
 gp_id,
 rechnung_anz,
 rechnung_netto,
 rechnung_maschinell_anz,
 rechnung_manuell_anz,
 belastungsanzeigen_anz,
 belastungsanzeigen_netto,
 rueckbelastungsanzeigen_anz,
 rueckbelastungsanzeigen_netto
FROM kfl_production_dbp_view.v_abrechnungsqualitaet_1;