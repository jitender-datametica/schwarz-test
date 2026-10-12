--==============================================================
-- Table: bon_mp_leergut_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bon_mp_leergut_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bon_mp_leergut_zu_1 (
bon_id STRING(25) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
bon_zeile BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Laufende Nummer der Bonzeile'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land_1'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
mp_ods_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Manipulationsart bei ODS-Bon-Auswertungen. Referenz zu l_mp_ods_1'),
barcode_lgb NUMERIC(26,0) OPTIONS(description='Der Barcode des Leergutbons aus dem Quellfeld ods_bon_verkauf.ean_kasse'),
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag des Kassenbons'),
start_bon_zeile DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
kasse_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Kasse'),
kassierer_enc BIGNUMERIC(38,0) OPTIONS(description='Nummer des Kassierers. Verschlüsselt in der Versorgung'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=' Nebenbetriebskennziffer. Bei Märkten immer = 0'),
bon_nr_extern BIGNUMERIC(38,0) OPTIONS(description='Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten'),
zahlung_typ_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden'),
personal_id STRING(25) OPTIONS(description='Personalnummer(nur bei Personalrabett) als Hashwert verfremdet (Compress)'),
alert_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob die Zeile bereits für einen Alert-Bericht verwendet wurde, dann = 1'),
storno_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Das Storno Flag kennzeichnet Leergutbons, die storniert wurden. Diese Bons sollen nicht ausgewertet werden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bon_id, bon_dat, bon_zeile, wup_id, mp_ods_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS - Tabelle enthält Leergutbons (Kopf- und Positionsdaten), die einer Leergut-Manipulationsart zugeordnet wurden (durch Versorgung)');