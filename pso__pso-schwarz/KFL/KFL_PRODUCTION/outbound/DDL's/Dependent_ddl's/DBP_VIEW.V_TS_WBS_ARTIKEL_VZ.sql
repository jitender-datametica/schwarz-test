CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_wbs_artikel_vz (mandant_id OPTIONS(description='Mandant im DWH.'),
kjwo OPTIONS(description='Kalenderwoche Aktionsstart.'), angebot_nr
OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), aktion_id
OPTIONS(description='Aktionsnummer.'), ausliefergruppe_id
OPTIONS(description='Ausliefergruppe (sollte vielleicht irgendwann in auslieferungsgruppe_id umbenannt werden, da es die gleichen Daten sind).'),
art_id OPTIONS(description='Artikelnummer.'), wup_id_vz OPTIONS(description='Verteilzentrum VZ.'), nb_id_vz
OPTIONS(description='Nebenbetriebsnummer VZ.'), mandant_id_vz OPTIONS(description='Mandant im DWH VZ.'), bezugsweg_id
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).'),
gp_id OPTIONS(description='Lieferantenummer aus lifnr., Kontonummer des Lieferanten bzw. Kreditors.'), clear_stock_id
OPTIONS(description='Clear-Stock ID that says how to distribute stock. The goal is to change the clear-stock-flag-logic so, that the user has the possibility to use a third option for distributing the DC stock:\n1) 0 = do not apply the logic (distribute according to demand in the stores)\n2) 1 = distribute the whole blocked stock in DC\n3) 2 = distribute the whole stock in DC (blocked stock + free stock)'),
lieferung_tag_offset OPTIONS(description='Delivery Date UBP.'), estimation_fg
OPTIONS(description='Flag: Sagt aus, ob der betrachtete Artikel bei der Werbemengenfindung durch WBS berücksichtigt wird.'),
adjustment_id
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n2 = Platzhalter (Stand 28.03.2025)\n3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine manuelle Bestellanlage durch das Land notwendig. '),
max_kapa_fg OPTIONS(description='Flag: Max. Kapa.'), dat_letzte_nachversorgung
OPTIONS(description='Datum letzte Nachversorgung.'), max_kapa_endbestand_proz
OPTIONS(description='Max. Kapa für Endbestand in %'), rest_von_normalbestand_proz
OPTIONS(description='Restbestand in % vom Normalbestand'), nachversorgung_schwellwert_pal_abrundung_proz
OPTIONS(description='WBS Nachversorgung: Paletten Abrundung Schwellwert in %'),
nachversorgung_schwellwert_pal_aufrundung_proz
OPTIONS(description='WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %')) AS SELECT mandant_id,
 kjwo,
 angebot_nr,
 aktion_id,
 ausliefergruppe_id,
 art_id,
 wup_id_vz,
 nb_id_vz,
 mandant_id_vz,
 bezugsweg_id,
 gp_id,
 clear_stock_id,
 lieferung_tag_offset,
 estimation_fg,
 adjustment_id,
 max_kapa_fg,
 dat_letzte_nachversorgung,
 max_kapa_endbestand_proz,
 rest_von_normalbestand_proz,
 nachversorgung_schwellwert_pal_abrundung_proz,
 nachversorgung_schwellwert_pal_aufrundung_proz
FROM kfl_production_dbp_data.ts_wbs_artikel_vz;