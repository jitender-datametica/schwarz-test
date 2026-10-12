CREATE OR REPLACE TABLE kfl_production_dbp_data.ts_mengenaenderungen_writeback (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Aktion-ID'),
art_id INTEGER NOT NULL OPTIONS(description='Artikelnummer im DWH. Wird aus matnr erzeugt.'),
dat_von DATE OPTIONS(description='Aktion gültig von.'),
dat_bis DATE OPTIONS(description='Aktion gültig bis.'),
angebot_id INTEGER NOT NULL OPTIONS(description='Offer / Angebot-ID.'),
dat_beladung DATE NOT NULL OPTIONS(description='Technisches Beladungsdatum.'),
menge_ohne_bestand_genehmigt_fg INTEGER
OPTIONS(description='Flag: Wird vom User gesetzt, wenn die Werbebestellmenge (z.B. in der Bestellung ans Verteilzentrum) errechnet ohne Berücksichtigung des aktuellen Bestands weiter verwendet werden soll. Ohne Bestandsberücksichtigung ist z.B. für den Fall, dass ein aktuell hoher Bestand vor der Aktion wegen Mhd-Ablauf verfällt, oder es wegen anderer Aktionen zu erwarten ist, dass der Bestand sich abverkauft, weshalb die unreduzierte Bestellmenge genommen werden kann.\n            Einträge werden durch MSTR gepflegt und in Abinitio weiterverarbeitet. Mit oder ohne Bestandsberücksichtigung schließen sich gegenseitig aus. Es kann also immer nur einer von beiden aktiv sein. Die Variante mit zwei Flags wurde anstatt eines Codes gewählt, da es eine übersichtlichere Ansicht in MSTR ermöglicht, als ein drop-down Menü'),
menge_mit_bestand_genehmigt_fg INTEGER
OPTIONS(description='Flag: Wird vom User gesetzt, wenn die Werbebestellmenge (z.B. in der Bestellung ans Verteilzentrum) errechnet mit Berücksichtigung des aktuellen Bestands weiter verwendet werden soll. Mit Bestandsberücksichtigung ist z.B. für den Fall, dass es einen aktuell hohen Bestand des Artikels gibt, der vor der Aktion wahrscheinlich nicht signifikant abnimmt, was eine Reduktion der Bestellmenge zur Folge haben kann.\n            Einträge werden durch MSTR gepflegt und in Abinitio weiterverarbeitet.  Mit oder ohne Bestandsberücksichtigung schließen sich gegenseitig aus. Es kann also immer nur einer von beiden aktiv sein. Die Variante mit zwei Flags wurde anstatt eines Codes gewählt, da es eine übersichtlichere Ansicht in MSTR ermöglicht, als ein drop-down Menü'),
werbeaenderung_menge_uebertragen NUMERIC(29,3)
OPTIONS(description='Übertragene Menge zu SAP. (Wird aktuell nicht benutzt. Muss später geklärt werden ob die Spalte bennötigt wird, nachdem weitere Länder (vielleicht alle) an WBS angebunden sind.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
fixmenge_wfl_bme INTEGER
OPTIONS(description='Die feste Menge, die vom Benutzer eingegeben und auf alle Filialen aufgeteilt werden muss (diese Berechnung wird im Replenishment Core durchgeführt).\n            (FixMenge Bedueted : Freez Diese Menge, um sie an alle Filialen zu aufzuteilen)'),
menge_mindestplatzierung_cluster_1_ame INTEGER
OPTIONS(description='Minimum Quantity eines Artikels für eine Filiale in Cluster 1. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.'),
menge_mindestplatzierung_cluster_2_ame INTEGER
OPTIONS(description='Minimum Quantity eines Artikels für eine Filiale in Cluster 2. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.'),
menge_mindestplatzierung_cluster_3_ame INTEGER
OPTIONS(description='Minimum Quantity eines Artikels für eine Filiale in Cluster 3. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.'),
wfl_menge_geprueft_fg INTEGER
OPTIONS(description='Flag,  Waren Fluss (Supply Change Managment Flag), die der Benutzer  auf 1 setzen kann ,um zu markieren, dass er die Mengen fuer diesen Artkel bereits überprüft hat und beibehalten wird,solange es keine Aenderungen bei der Promotion gibt.'),
wfl_nutzer_kommentar_txt STRING(100)
OPTIONS(description='Frei-Text-Feld fuer den Benutzer\n            Dieses Feld dient dazu, einen zusätzlichen Kommentar zu einem Artikel hinzuzufügen. Es dient dazu, besser nachzuvollziehen, was das Problem vorher war.'),
init_lief_clear_stock_id INTEGER
OPTIONS(description='Clear-Stock ID that says how to distribute stock. The goal is to change the clear-stock-flag-logic, so that the user has the possibility to use a third option for distributing the DC stock:\n            0 = do not apply the logic (distribute according to demand in the stores)\n            1 = distribute the whole blocked stock in DC\n            2 = distribute the whole stock in DC (blocked stock + free stock)'),
estimation_id INTEGER
OPTIONS(description='With this ID the user can decide in which way the estimation for WBS TP2 should be calculated.\n            ID 0 = no estimation\n            ID 1 = calculate normal estimation process\n            ID 2 = only fill up maximum capacity (Berechnung für die Werbung in WBS, aber nur um das Regal aufzufüllen)'),
adjustment_id INTEGER
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n            2 = Platzhalter (Stand 28.03.2025)\n            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine manuelle Bestellanlage durch das Land notwendig.'),
gk_fg INTEGER OPTIONS(description='Flag: Gondelkopf'),
PRIMARY KEY (mandant_id, aktion_id, angebot_id, dat_beladung, art_id) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - Writeback of promotional item quantity approval.\n             (Tabelle liegt aktuell im falschen Schema. Sollte in DBP_MSI_DATA sein.)');