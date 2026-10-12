--==============================================================
-- Table: inventur_warenverlust_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_1
   generated from Powerdesigner on Freitag, 6. Juni 2025 14:13:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_WARENVERLUST_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   inventur_id                         INTEGER     NOT NULL COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Der "WUP_1" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter WUP_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   inventurart_id                      INTEGER     NOT NULL COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
   dat_inventur_von                    DATE             NOT NULL COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.',
   dat_inventur_bis                    DATE             NOT NULL COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.',
   dat_inventur_buchung_von            DATE             COMMENT 'Start des betrachteten Inventurzeitraums nach Verbuchung der Inventur_1 in SAP.',
   dat_inventur_buchung_bis            DATE             COMMENT 'Ende des betrachteten Inventurzeitraums nach Verbuchung der Inventur_1 in SAP.',
   gj                                  INTEGER     COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
   art_id                              INTEGER     COMMENT 'Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   wg_id                               INTEGER     COMMENT 'ID der Warengruppe',
   owg_id                              INTEGER     COMMENT 'ID der Oberwarengruppe',
   hwg_id                              INTEGER     COMMENT 'ID der Hauptwarengruppe',
   abt_id                              INTEGER     COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
   loesch_fg                           INTEGER     COMMENT 'Löschkennzeichen, das nachträglich durch VT Orga in den Ländern gesetzt werden kann, falls Zeitraum oder Inventurart aus der Betrachtung herausgenommen werden soll.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_WARENVERLUST PRIMARY KEY (inventur_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle basiert auf Excel und dient als Steuertabelle für die Berechnung von Warenverlusten. Sie enthält die spezifischen Inventurarten, Länder, Filialen und Zeiträume, für die die Verlustberechnungen durchgeführt werden sollen.';
