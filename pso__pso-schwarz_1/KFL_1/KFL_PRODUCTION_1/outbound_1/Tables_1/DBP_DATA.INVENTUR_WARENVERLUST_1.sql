--==============================================================
-- Table: inventur_warenverlust_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_1
   generated from Powerdesigner on Freitag, 6. Juni 2025 14:13:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_warenverlust_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
inventur_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der "WUP_1" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter WUP_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
inventurart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von DATE NOT NULL
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.'),
dat_inventur_bis DATE NOT NULL
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.'),
dat_inventur_buchung_von DATE
OPTIONS(description='Start des betrachteten Inventurzeitraums nach Verbuchung der Inventur_1 in SAP.'),
dat_inventur_buchung_bis DATE
OPTIONS(description='Ende des betrachteten Inventurzeitraums nach Verbuchung der Inventur_1 in SAP.'),
gj BIGNUMERIC(38,0)
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe'),
owg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Oberwarengruppe'),
hwg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Hauptwarengruppe'),
abt_id BIGNUMERIC(38,0)
OPTIONS(description='Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.'),
loesch_fg BIGNUMERIC(38,0)
OPTIONS(description='Löschkennzeichen, das nachträglich durch VT Orga in den Ländern gesetzt werden kann, falls Zeitraum oder Inventurart aus der Betrachtung herausgenommen werden soll.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (inventur_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle basiert auf Excel und dient als Steuertabelle für die Berechnung von Warenverlusten. Sie enthält die spezifischen Inventurarten, Länder, Filialen und Zeiträume, für die die Verlustberechnungen durchgeführt werden sollen.');