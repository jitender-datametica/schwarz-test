CREATE OR REPLACE VIEW kfl_production_dbp_view.v_warenverfuegbarkeit_wup_art_stunde_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), wup_id
OPTIONS(description='Warenumschlagsplatz-ID der Filiale, in der der Artikel_1 verkauft wird.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.'),
art_id OPTIONS(description='ID des verkauften Artikel.'), dat_auswertung
OPTIONS(description='Datum der Auswertung im Format JJJJ-MM_1-TT.'), zeit_stunde
OPTIONS(description='Volle Stunde (00 bis 23) der Auswertung.'), bewart_id
OPTIONS(description='Bewegungsart des verkauften Artikels. 1002 = SA = Sonderaktion (Werbeartikel), 1001 = AF = Aktionsfrei (kein Werbeartikel)'),
anz_bon_artikel OPTIONS(description='Anzahl der Bons, in denen der Artikel_1 in diesem Zeitraum verkauft wurde.'),
menge_verkauft
OPTIONS(description='Gesamtverkaufte Menge des Artikels in diesem Zeitraum. Es kann sowohl in Stück als auch in Kilogramm angegeben sein (je nach Artikel_1).'),
anz_bon_gesamt
OPTIONS(description='Gesamtzahl der erstellten Bons in der Filiale in diesem Zeitraum. Unabhängig von der Anzahl der verkauften Artikel. Die Anzahl kann aufgrund von Abschriften_1 und Retouren von den Daten in DBP_ODS.ODS_BON_VERKAUF_1 abweichen.'),
ausverkauft_fg
OPTIONS(description='Kennzeichen, das angibt, ob der Artikel_1 in diesem Zeitraum vollständig ausverkauft war.'),
eckartikel_fg
OPTIONS(description='Kennzeichen, das angibt ob der Artikel_1 in diesem Zeitraum ein Eckartikel ist. Unter einem Eckartikel versteht man einen Artikel_1, auf den die Kunden besonders achten und der dementsprechend immer verfügbar sein sollte.'),
topseller_fg
OPTIONS(description='Kennzeichen, das angibt, ob der Artikel_1 einer der 25 meistverkauften Artikel_1 der letzten 3 Jahre ist.'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT DETAILLIERTE INFORMATIONEN ÜBER DIE STÜNDLICHE VERFÜGBARKEIT DER ARTIKEL. SIE BEZIEHT SICH NUR AUF O&G UND BACKARTIKEL, DIE ENTWEDER ECKARTIKEL ODER TOPSELLER SIND. SIE DIENT DER ANALYSE VON ABVERKÄUFEN UND OUT-OF-STOCK-SITUATIONEN.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_auswertung,
 zeit_stunde,
 bewart_id,
 anz_bon_artikel,
 menge_verkauft,
 anz_bon_gesamt,
 ausverkauft_fg,
 eckartikel_fg,
 topseller_fg
FROM kfl_production_dbp_data.warenverfuegbarkeit_wup_art_stunde_1;