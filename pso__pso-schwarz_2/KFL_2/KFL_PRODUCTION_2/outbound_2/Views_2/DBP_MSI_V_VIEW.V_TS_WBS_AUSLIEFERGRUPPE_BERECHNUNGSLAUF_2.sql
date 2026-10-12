CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wbs_ausliefergruppe_berechnungslauf_2 (mandant_id
OPTIONS(description='Mandant_2'), ausliefergruppe_id OPTIONS(description='Ausliefergruppe'), berechnungsprozess_id
OPTIONS(description='ID des Berechnungsprozesses. 1 = Initiale Belieferung,  2 = Replenishment'), berechnungslauf_nr
OPTIONS(description='Nummer des Berechnungslaufs für die Berechnungsprozess.'), zeitslot_id
OPTIONS(description='ID des Zeitslots für die Kalkulation und Bestellung von zusätzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.'))
OPTIONS(DESCRIPTION = `SCM-WBS - DIE TABELLE ENTHÄLT DIE ATTRIBUTE (Z. B. ZEITSLOT_ID) DER VERSCHIEDENEN BERECHNUNGSLÄUFE (ERSTER, ZWEITER USW.) FÜR DIE VERSCHIEDENEN BERECHNUNGSPROZESSE (Z. B. INITIALE BELIEFERUNG). DER INHALT WIRD VON TRANSAKTION SERVICES GEPFLEGT.`)
AS SELECT mandant_id,
 ausliefergruppe_id,
 berechnungsprozess_id,
 berechnungslauf_nr,
 zeitslot_id
FROM kfl_production_dbp_msi_data.ts_wbs_ausliefergruppe_berechnungslauf_2;