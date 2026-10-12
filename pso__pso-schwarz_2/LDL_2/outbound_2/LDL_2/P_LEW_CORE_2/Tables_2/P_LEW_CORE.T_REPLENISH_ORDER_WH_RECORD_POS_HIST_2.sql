CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_replenish_order_wh_record_pos_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warehouse fuer das die Bestellung aufgegeben wurde; FK auf WAREHOUSE/ LOCATION_2'),
order_record_id STRING(20) NOT NULL
OPTIONS(description='Bestellnummer, Zusammensetzung: src_orig_supplier_nr (4 Stellen), Datum (DDMMYY, 6 Stellen) und laufende Nummer (2Stellen) fuer Lieferant-Datum-Kombination; Wawi: po_nr.'),
order_pos_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Versionsnr. der Bestellung (wird bei nachtraeglicher Aenderung der Bestellung hochgezaehlt); Wawi: lfdnr.'),
order_pos_created_tmsp DATETIME OPTIONS(description='Zeitstempel der Aufgabe der Bestellung; Wawi: datum'),
order_pos_updated_tmsp DATETIME OPTIONS(description='Zeitstempel der Aenderung der Bestellung; Wawi: datumm2'),
delivery_dt DATE OPTIONS(description='Anlieferungsdatum; Wawi: liefdatum'),
delivery_tmsp DATETIME OPTIONS(description='Anlieferungszeitstempel; Konkatiniert aus Wawi liefdatum und Wawi liefzeit'),
order_status_cd BIGNUMERIC(38,0)
OPTIONS(description='Bestellstatus, 0 = Bestellung offen, 1 = Bestellung nach Mengenkorrektur, 2 = Bestellung geschlossen, 9 = Bestellung geloescht; Wawi: status_2'),
part_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Teil der Bestellposition ist noch offen; Wawi: knzteil'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bestellter Artikel_2; FK auf ITEM_2'),
order_qty_type_cd BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Code, der aussagt, wie die order_qty zu interpretieren ist. 0 = Kolli/Kutija, 1 = Lage/Sloj, 2 = Duesseld./DD, 3 = EP, 4 = Stueck/Komad; Wawi: disponr.'),
order_qty BIGNUMERIC(38,5) OPTIONS(description='Menge der Bestellposition; Wawi: menge'),
delivered_order_qty BIGNUMERIC(38,5) OPTIONS(description='Ausstehende Menge der Bestellposition; Wawi: menge2'),
case_factor BIGNUMERIC(38,0)
OPTIONS(description='Palettenfaktor (EP, DD, Lage oder Kolli) in Kolli von der Bestelleinheit mit der bestellt wird. Multipliziert mit menge ergibt sich daraus die Bestellmenge in Kolli.Wawi: kartonfakt.'),
real_case_size BIGNUMERIC(38,5)
OPTIONS(description='idR identisch zur case size des bestellten Artikels (lookup via item_sid), teilweise abweichend; Wawi: decimalcase'),
order_diff BIGNUMERIC(38,0)
OPTIONS(description='Differenz gibt an, welche Abweichung für ein Artikel_2 in dieser Artikelgruppe beim Wareneingang erlaubt ist. Wawi: artgruppe.differenzwe'),
task_id BIGNUMERIC(38,0)
OPTIONS(description='Ein vom Modul EGIN gesetzter Schluessel, wenn in der DispoPos_2 Tabelle Updates vorgenommen werden. Wawi: taskid'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Bestelldatum; Wawi: extrahiert aus order_record_id'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (loc_sid, order_record_id, order_pos_version_nr, item_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Historisierte Positionen fuer Bestellungen (Dispositionen) von Artikeln eines Lieferanten zu einem WH.             WaWi: t_wawi_dispo_orderdetail_wh_2');