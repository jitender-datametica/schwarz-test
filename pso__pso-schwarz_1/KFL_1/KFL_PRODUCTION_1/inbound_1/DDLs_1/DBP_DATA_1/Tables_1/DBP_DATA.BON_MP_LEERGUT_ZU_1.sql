--==============================================================
-- Table: bon_mp_leergut_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bon_mp_leergut_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BON_MP_LEERGUT_ZU_1 (
   bon_id                              VARCHAR(25)      NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   bon_zeile                           NUMBER(38,0)     NOT NULL COMMENT 'Laufende Nummer der Bonzeile',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   mp_ods_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID der Manipulationsart bei ODS-Bon-Auswertungen. Referenz zu l_mp_ods_1',
   barcode_lgb                         NUMBER(26,0)     COMMENT 'Der Barcode des Leergutbons aus dem Quellfeld ods_bon_verkauf.ean_kasse',
   umsatz_brutto                       NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag des Kassenbons',
   start_bon_zeile                     TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung',
   kasse_nr                            NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Kasse',
   kassierer_enc                       NUMBER(38,0)     COMMENT 'Nummer des Kassierers. Verschlüsselt in der Versorgung',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT ' Nebenbetriebskennziffer. Bei Märkten immer = 0',
   bon_nr_extern                       NUMBER(38,0)     COMMENT 'Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten',
   zahlung_typ_id                      NUMBER(38,0)     COMMENT 'ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden',
   personal_id                         VARCHAR(25)      COMMENT 'Personalnummer(nur bei Personalrabett) als Hashwert verfremdet (Compress)',
   alert_fg                            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag zeigt an, ob die Zeile bereits für einen Alert-Bericht verwendet wurde, dann = 1',
   storno_fg                           NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Das Storno Flag kennzeichnet Leergutbons, die storniert wurden. Diese Bons sollen nicht ausgewertet werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BON_MP_LEERGUT_ZU PRIMARY KEY (bon_id, bon_dat, bon_zeile, wup_id, mp_ods_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Tabelle enthält Leergutbons (Kopf- und Positionsdaten), die einer Leergut-Manipulationsart zugeordnet wurden (durch Versorgung)';

