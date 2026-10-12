CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_auftrag_verpackung_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_verpackung_id
OPTIONS(description='ID der Verpackung'), tms_verpackung_lfd_nr
OPTIONS(description='Identifier der Verpackung im Quellsystem'), tms_auftrag_id
OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plau.au_nr'), tms_auftrag_unter_id
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr'),
tms_transportmittel_id OPTIONS(description='ID des Transportmittels auf dem die Verpackung verpackt wird.'),
anz_verpackung OPTIONS(description='Anzahl gleichartiger Verpackungen'), tms_verpackung_bem_txt
OPTIONS(description='Freitext für Bemerkungen zur Verpackung.'))
OPTIONS(DESCRIPTION = `TMS - DIE TABELLE ENTHÄLT VERPACKUNSINFORMATIONEN ZUM AUFTRAG INKLUSIVE DES GENUTZEN TRANSPORTMITTELS DER VERPACKUNG.`)
AS SELECT mandant_id,
 system_id,
 tms_verpackung_id,
 tms_verpackung_lfd_nr,
 tms_auftrag_id,
 tms_auftrag_unter_id,
 tms_transportmittel_id,
 anz_verpackung,
 tms_verpackung_bem_txt
FROM kfl_production_dbp_data.tms_auftrag_verpackung_1;