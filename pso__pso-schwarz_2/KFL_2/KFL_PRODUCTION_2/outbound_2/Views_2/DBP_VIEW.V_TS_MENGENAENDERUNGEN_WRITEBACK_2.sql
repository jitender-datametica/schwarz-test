CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_mengenaenderungen_writeback_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), aktion_id OPTIONS(description='Aktion_2-ID'), art_id
OPTIONS(description='Artikelnummer im DWH. Wird aus matnr erzeugt.'), dat_von OPTIONS(description='Aktion_2 gültig von.'),
dat_bis OPTIONS(description='Aktion_2 gültig bis.'), angebot_id OPTIONS(description='Offer / Angebot_2-ID.'), dat_beladung
OPTIONS(description='Technisches Beladungsdatum.'), menge_ohne_bestand_genehmigt_fg
OPTIONS(description='Flag: Wird vom User gesetzt, wenn die Werbebestellmenge (z.B. in der Bestellung ans Verteilzentrum) errechnet ohne Berücksichtigung des aktuellen Bestands weiter verwendet werden soll. Ohne Bestandsberücksichtigung ist z.B. für den Fall, dass ein aktuell hoher Bestand vor der Aktion_2 wegen Mhd-Ablauf verfällt, oder es wegen anderer Aktionen zu erwarten ist, dass der Bestand sich abverkauft, weshalb die unreduzierte Bestellmenge genommen werden kann.\nEinträge werden durch MSTR gepflegt und in Abinitio weiterverarbeitet. Mit oder ohne Bestandsberücksichtigung schließen sich gegenseitig aus. Es kann also immer nur einer von beiden aktiv sein. Die Variante mit zwei Flags wurde anstatt eines Codes gewählt, da es eine_2 übersichtlichere Ansicht in MSTR ermöglicht, als ein drop-down Menü'),
menge_mit_bestand_genehmigt_fg
OPTIONS(description='Flag: Wird vom User gesetzt, wenn die Werbebestellmenge (z.B. in der Bestellung ans Verteilzentrum) errechnet mit Berücksichtigung des aktuellen Bestands weiter verwendet werden soll. Mit Bestandsberücksichtigung ist z.B. für den Fall, dass es einen aktuell hohen Bestand des Artikels gibt, der vor der Aktion_2 wahrscheinlich nicht signifikant abnimmt, was eine_2 Reduktion der Bestellmenge zur Folge haben kann.\nEinträge werden durch MSTR gepflegt und in Abinitio weiterverarbeitet.  Mit oder ohne Bestandsberücksichtigung schließen sich gegenseitig aus. Es kann also immer nur einer von beiden aktiv sein. Die Variante mit zwei Flags wurde anstatt eines Codes gewählt, da es eine_2 übersichtlichere Ansicht in MSTR ermöglicht, als ein drop-down Menü'),
werbeaenderung_menge_uebertragen
OPTIONS(description='Übertragene Menge zu SAP. (Wird aktuell nicht benutzt. Muss später geklärt werden ob die Spalte bennötigt wird, nachdem weitere Länder (vielleicht alle) an WBS angebunden sind.)'),
fixmenge_wfl_bme
OPTIONS(description='Die feste Menge, die vom Benutzer eingegeben und auf alle Filialen aufgeteilt werden muss (diese Berechnung wird im Replenishment Core durchgeführt).\n(FixMenge Bedueted : Freez Diese Menge, um sie an alle Filialen zu aufzuteilen)'),
menge_mindestplatzierung_cluster_1_ame
OPTIONS(description='Minimum Quantity eines Artikels für eine_2 Filiale in Cluster 1. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.'),
menge_mindestplatzierung_cluster_2_ame
OPTIONS(description='Minimum Quantity eines Artikels für eine_2 Filiale in Cluster 2. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.'),
menge_mindestplatzierung_cluster_3_ame
OPTIONS(description='Minimum Quantity eines Artikels für eine_2 Filiale in Cluster 3. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.'),
wfl_menge_geprueft_fg
OPTIONS(description='Flag,  Waren Fluss (Supply Change Managment Flag), die der Benutzer  auf 1 setzen kann ,um zu markieren, dass er die Mengen fuer diesen Artkel bereits überprüft hat und beibehalten wird,solange es keine Aenderungen bei der Promotion gibt.'),
wfl_nutzer_kommentar_txt
OPTIONS(description='Frei-Text-Feld fuer den Benutzer\nDieses Feld dient dazu, einen zusätzlichen Kommentar zu einem Artikel_2 hinzuzufügen. Es dient dazu, besser nachzuvollziehen, was das Problem vorher war.'),
estimation_id
OPTIONS(description='With this ID the user can decide in which way the estimation for WBS TP2 should be calculated.\nID 0 = no estimation\nID 1 = calculate normal estimation process\nID 2 = only fill up maximum capacity (Berechnung für die Werbung in WBS, aber nur um das Regal aufzufüllen)'),
init_lief_clear_stock_id
OPTIONS(description='Clear-Stock ID that says how to distribute stock. The goal is to change the clear-stock-flag-logic, so that the user has the possibility to use a third option for distributing the DC stock:\n0 = do not apply the logic (distribute according to demand in the stores)\n1 = distribute the whole blocked stock in DC\n2 = distribute the whole stock in DC (blocked stock + free stock)'),
adjustment_id
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n2 = Platzhalter (Stand 28.03.2025)\n3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_2 manuelle Bestellanlage durch das Land_2 notwendig.'),
gk_fg OPTIONS(description='Flag: Gondelkopf'), td_insert, td_update) AS SELECT mandant_id,
 aktion_id,
 art_id,
 dat_von,
 dat_bis,
 angebot_id,
 dat_beladung,
 menge_ohne_bestand_genehmigt_fg,
 menge_mit_bestand_genehmigt_fg,
 werbeaenderung_menge_uebertragen,
 fixmenge_wfl_bme,
 menge_mindestplatzierung_cluster_1_ame,
 menge_mindestplatzierung_cluster_2_ame,
 menge_mindestplatzierung_cluster_3_ame,
 wfl_menge_geprueft_fg,
 wfl_nutzer_kommentar_txt,
 estimation_id,
 init_lief_clear_stock_id,
 adjustment_id,
 gk_fg,
 td_insert,
 td_update
FROM kfl_production_dbp_data.ts_mengenaenderungen_writeback_2;