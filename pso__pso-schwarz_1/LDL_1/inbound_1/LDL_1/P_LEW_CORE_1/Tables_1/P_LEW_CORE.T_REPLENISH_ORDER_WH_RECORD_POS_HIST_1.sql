CREATE TABLE P_LEW_CORE.T_REPLENISH_ORDER_WH_RECORD_POS_HIST_1 CLUSTER BY (
     client_id, dwh_cal_dt
)(
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)    NOT NULL COMMENT 'Warehouse fuer das die Bestellung aufgegeben wurde; FK auf WAREHOUSE/ LOCATION_1',
   order_record_id                     VARCHAR(20)    NOT NULL COMMENT 'Bestellnummer, Zusammensetzung: src_orig_supplier_nr (4 Stellen), Datum (DDMMYY, 6 Stellen) und laufende Nummer (2Stellen) fuer Lieferant-Datum-Kombination; Wawi: po_nr.',
   order_pos_version_nr                NUMBER(38,0)    NOT NULL COMMENT 'Versionsnr. der Bestellung (wird bei nachtraeglicher Aenderung der Bestellung hochgezaehlt); Wawi: lfdnr.',
   order_pos_created_tmsp              TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel der Aufgabe der Bestellung; Wawi: datum',
   order_pos_updated_tmsp              TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel der Aenderung der Bestellung; Wawi: datumm2',
   delivery_dt                         DATE            COMMENT 'Anlieferungsdatum; Wawi: liefdatum',
   delivery_tmsp                       TIMESTAMP_NTZ(9) COMMENT 'Anlieferungszeitstempel; Konkatiniert aus Wawi liefdatum und Wawi liefzeit',
   order_status_cd                     NUMBER(38,0)    COMMENT 'Bestellstatus, 0 = Bestellung offen, 1 = Bestellung nach Mengenkorrektur, 2 = Bestellung geschlossen, 9 = Bestellung geloescht; Wawi: status_1',
   part_fg                             NUMBER(38,0)    NOT NULL COMMENT 'Teil der Bestellposition ist noch offen; Wawi: knzteil',
   item_sid                            NUMBER(38,0)    NOT NULL COMMENT 'Bestellter Artikel_1; FK auf ITEM_1',
   order_qty_type_cd                   NUMBER(38,0)    NOT NULL COMMENT 'Code, der aussagt, wie die order_qty zu interpretieren ist. 0 = Kolli/Kutija, 1 = Lage/Sloj, 2 = Duesseld./DD, 3 = EP, 4 = Stueck/Komad; Wawi: disponr.',
   order_qty                           NUMBER(38,5)    COMMENT 'Menge der Bestellposition; Wawi: menge',
   delivered_order_qty                 NUMBER(38,5)    COMMENT 'Ausstehende Menge der Bestellposition; Wawi: menge2',
   case_factor                         NUMBER(38,0)    COMMENT 'Palettenfaktor (EP, DD, Lage oder Kolli) in Kolli von der Bestelleinheit mit der bestellt wird. Multipliziert mit menge ergibt sich daraus die Bestellmenge in Kolli.Wawi: kartonfakt.',
   real_case_size                      NUMBER(38,5)    COMMENT 'idR identisch zur case size des bestellten Artikels (lookup via item_sid), teilweise abweichend; Wawi: decimalcase',
   order_diff                          NUMBER(38,0)    COMMENT 'Differenz gibt an, welche Abweichung für ein Artikel_1 in dieser Artikelgruppe beim Wareneingang erlaubt ist. Wawi: artgruppe.differenzwe',
   task_id                             NUMBER(38,0)    COMMENT 'Ein vom Modul EGIN gesetzter Schluessel, wenn in der DispoPos_1 Tabelle Updates vorgenommen werden. Wawi: taskid',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_cal_dt                          DATE            NOT NULL COMMENT 'Bestelldatum; Wawi: extrahiert aus order_record_id',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_REPLENISH_ORDER_WH_RECORD_POS_HIST PRIMARY KEY (loc_sid, order_record_id, order_pos_version_nr, item_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'Historisierte Positionen fuer Bestellungen (Dispositionen) von Artikeln eines Lieferanten zu einem WH.
             WaWi: t_wawi_dispo_orderdetail_wh_1';
