--==============================================================
-- Table: besch_lief
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief
   generated from Powerdesigner on Freitag, 11. November 2022 15:57:44
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_LIEF (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   lief_beleg_id                       INTEGER    NOT NULL COMMENT 'Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.',
   kj                                  INTEGER    NOT NULL COMMENT 'Kalenderjahr, Format JJJJ.',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup ID, wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   versandstelle_id                    VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine Gruppe von Laderampen) oder um eine logische Gruppierung (z.B. eine Gruppe von Personen, die für die Versandaktivitäten zuständig ist) handeln.',
   verkaufsorganisation_id             VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.',
   lief_typ_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine Lieferung bearbeitet.',
   dat_lief_soll                       DATE            NOT NULL COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen.',
   vertr_beleg_typ_id                  VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. ob der Lieferschein aufgrund eines Wareneingangs generiert wurde.',
   lief_pal_typ_id                     VARCHAR(1)      NOT NULL COMMENT 'Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.',
   kunde_id                            VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Nummer des Warenempfängers der Lieferung. Diese Nummer referenziert die DWH Tabelle wup. COMPRESS mit CAMSET_L.',
   auftraggeber_id                     VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Kunde, der die Waren oder Dienstleistungen bestellt. Der Auftraggeber übernimmt die vertragliche Haftung für den Kundenauftrag. COMPRESS mit CAMSET_L.',
   anzahl_packstueck                   INTEGER    COMMENT 'Gesamte Anzahl der Packstücke für alle Positionen der Lieferung.',
   werbeware_id                        VARCHAR(1)      COLLATE 'en-ci' COMMENT 'Wird gefüllt, wenn die Bestellart eine Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B-W und N-S = Schnellschuss.',
   dat_lagerbew_ist                    DATE            COMMENT 'Warenbewegungsdatum im Lieferschein.',
   system_id                           INTEGER    DEFAULT 7 NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id_kunde                    INTEGER    DEFAULT 1 NOT NULL COMMENT 'Der Kunde kann zu einem anderen Mandanten als dem des WUP gehören, z.B. Lager aus CZ beliefert Markt in SK.',
   cd_kz                               VARCHAR(2)      COLLATE 'en-ci' NOT NULL COMMENT 'Kennzeichen für Cross Docking aus zlvcd.  Referenz zur Lookuptabelle l_cd_typ.',
   wup_id_cd                           INTEGER    NOT NULL COMMENT 'Nummer des Verteilzentrums bei CD-Verkehren.',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie.',
   stellplatz_faktor                   NUMBER(29,2)    DEFAULT 1 NOT NULL COMMENT 'Korrekturwert zur Berechnung der Anzahl der Stellplätze.',
   belos_vorgang_id                    INTEGER    DEFAULT 0 NOT NULL COMMENT 'Referenz zum Belos-Vorgang. Nicht in jedem Fall vorhanden. Defaultwert ist 0.',
   handling_unit_id_ext                VARCHAR(20)     COLLATE 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'Die 18-stellige Nummer der Versandeinheit (NVE) aus dem Feld zzlvcdnve. Aus Konsistenzgründen als varchar(20) mit zwei führenden Nullen abgespeichert. COMPRESS mit CAMSET_L.',
   wg_verkett_fg                       INTEGER    DEFAULT 0 NOT NULL COMMENT 'Flag. Zeigt an, ob eine Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz.',
   wg_verkett_lief                     INTEGER    DEFAULT -1 NOT NULL COMMENT 'Die Warengruppenverkettung ist artikelbezogen. Wird in SAP auf die Kopftabelle hochgezogen, die erste Position als Quelle. Stimmt also bei Mischpaletten nicht für alle Positionen. Referenziert auf die Tabelle l_wg_verkettung. Das SAP-Feld ist zzlwgrv.',
   gp_id                               INTEGER    DEFAULT -1 NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID). Entspricht elifn aus der Quelle.',
   we_status_id                        VARCHAR(1)      COLLATE 'en-ci' DEFAULT '-' NOT NULL COMMENT 'Wareneingangsstatus-ID, aus zlvwestatus.',
   dat_aktion                          DATE            COMMENT 'Werbedatum.',
   dat_erstellung                      DATE            COMMENT 'Erstellungsdatum des Lieferbeleges - Quelle: LIKP.ERDAT.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_LIEF PRIMARY KEY (mandant_id, lief_beleg_id, kj) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die Kopfdaten der Lieferscheine aus der SAP Tabelle LIPK enthalten.';