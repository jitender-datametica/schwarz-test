--==============================================================
-- Table: bon_mp_leergut_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bon_mp_leergut_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BON_MP_LEERGUT_ZU (
   bon_id                              VARCHAR(25)      NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   bon_zeile                           INTEGER     NOT NULL COMMENT 'Laufende Nummer der Bonzeile',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   mp_ods_id                           INTEGER     NOT NULL COMMENT 'ID der Manipulationsart bei ODS-Bon-Auswertungen. Referenz zu l_mp_ods',
   barcode_lgb                         INTEGER     COMMENT 'Der Barcode des Leergutbons aus dem Quellfeld ods_bon_verkauf.ean_kasse',
   umsatz_brutto                       NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag des Kassenbons',
   start_bon_zeile                     TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung',
   kasse_nr                            INTEGER     NOT NULL COMMENT 'Nummer der Kasse',
   kassierer_enc                       INTEGER     COMMENT 'Nummer des Kassierers. Verschlüsselt in der Versorgung',
   nb_id                               INTEGER     NOT NULL COMMENT ' Nebenbetriebskennziffer. Bei Märkten immer = 0',
   bon_nr_extern                       INTEGER     COMMENT 'Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten',
   zahlung_typ_id                      INTEGER     COMMENT 'ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden',
   personal_id                         VARCHAR(25)      COMMENT 'Personalnummer(nur bei Personalrabett) als Hashwert verfremdet (Compress)',
   alert_fg                            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag zeigt an, ob die Zeile bereits für einen Alert-Bericht verwendet wurde, dann = 1',
   storno_fg                           INTEGER     NOT NULL DEFAULT 0 COMMENT 'Das Storno Flag kennzeichnet Leergutbons, die storniert wurden. Diese Bons sollen nicht ausgewertet werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BON_MP_LEERGUT_ZU PRIMARY KEY (bon_id, bon_dat, bon_zeile, wup_id, mp_ods_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Tabelle enthält Leergutbons (Kopf- und Positionsdaten), die einer Leergut-Manipulationsart zugeordnet wurden (durch Versorgung)';

