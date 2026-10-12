--==============================================================
-- Table: warenverfuegbarkeit_wup_art_stunde_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: warenverfuegbarkeit_wup_art_stunde_1
   generated from Powerdesigner on Dienstag, 27. August 2024 15:57:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.warenverfuegbarkeit_wup_art_stunde_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenumschlagsplatz-ID der Filiale, in der der Artikel_1 verkauft wird.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des verkauften Artikel.'),
dat_auswertung DATE NOT NULL OPTIONS(description='Datum der Auswertung im Format JJJJ-MM_1-TT.'),
zeit_stunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Volle Stunde (00 bis 23) der Auswertung.'),
bewart_id BIGNUMERIC(38,0)
OPTIONS(description='Bewegungsart des verkauften Artikels. 1002 = SA = Sonderaktion (Werbeartikel), 1001 = AF = Aktionsfrei (kein Werbeartikel)'),
anz_bon_artikel BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Bons, in denen der Artikel_1 in diesem Zeitraum verkauft wurde.'),
menge_verkauft BIGNUMERIC(38,3)
OPTIONS(description='Gesamtverkaufte Menge des Artikels in diesem Zeitraum. Es kann sowohl in Stück als auch in Kilogramm angegeben sein (je nach Artikel_1).'),
anz_bon_gesamt BIGNUMERIC(38,0)
OPTIONS(description='Gesamtzahl der erstellten Bons in der Filiale in diesem Zeitraum. Unabhängig von der Anzahl der verkauften Artikel. Die Anzahl kann aufgrund von Abschriften_1 und Retouren von den Daten in DBP_ODS.ODS_BON_VERKAUF_1 abweichen.'),
ausverkauft_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen, das angibt, ob der Artikel_1 in diesem Zeitraum vollständig ausverkauft war.'),
eckartikel_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen, das angibt ob der Artikel_1 in diesem Zeitraum ein Eckartikel ist. Unter einem Eckartikel versteht man einen Artikel_1, auf den die Kunden besonders achten und der dementsprechend immer verfügbar sein sollte.'),
topseller_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen, das angibt, ob der Artikel_1 einer der 25 meistverkauften Artikel_1 der letzten 3 Jahre ist.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_auswertung, zeit_stunde) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält detaillierte Informationen über die stündliche Verfügbarkeit der Artikel. Sie bezieht sich nur auf O&G und Backartikel, die entweder Eckartikel oder Topseller sind. Sie dient der Analyse von Abverkäufen und Out-of-Stock-Situationen.');