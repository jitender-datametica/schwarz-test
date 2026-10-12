CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BESCH_LIEF_1 (
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
LIEF_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
KJ INTEGER NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID, wird verwendet für Beziehung Lager zu Verteilzentrum.'),
NB_ID INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
VERSANDSTELLE_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_1 Gruppe_1 von Laderampen) oder um eine_1 logische Gruppierung (z.B. eine_1 Gruppe_1 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
VERKAUFSORGANISATION_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
LIEF_TYP_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_1 Lieferung bearbeitet.'),
DAT_LIEF_SOLL DATE NOT NULL
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen.'),
VERTR_BELEG_TYP_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. ob der Lieferschein aufgrund eines Wareneingangs generiert wurde.'),
LIEF_PAL_TYP_ID STRING(1) NOT NULL
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_1 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.'),
KUNDE_ID STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nummer des Warenempfängers der Lieferung. Diese Nummer referenziert die DWH Tabelle wup. COMPRESS mit CAMSET_L.'),
AUFTRAGGEBER_ID STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kunde, der die Waren oder Dienstleistungen bestellt. Der Auftraggeber übernimmt die vertragliche Haftung für den Kundenauftrag. COMPRESS mit CAMSET_L.'),
ANZAHL_PACKSTUECK INTEGER OPTIONS(description='Gesamte Anzahl der Packstücke für alle Positionen der Lieferung.'),
WERBEWARE_ID STRING(1) COLLATE 'und:ci'
OPTIONS(description='Wird gefüllt, wenn die Bestellart eine_1 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B-W und N-S = Schnellschuss.'),
DAT_LAGERBEW_IST DATE OPTIONS(description='Warenbewegungsdatum im Lieferschein.'),
SYSTEM_ID INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
MANDANT_ID_KUNDE INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als dem des WUP_1 gehören, z.B. Lager aus CZ beliefert Markt in SK.'),
CD_KZ STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für Cross Docking aus zlvcd.  Referenz zur Lookuptabelle l_cd_typ.'),
WUP_ID_CD INTEGER NOT NULL OPTIONS(description='Nummer des Verteilzentrums bei CD-Verkehren.'),
LAGERNUMMER_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie.'),
STELLPLATZ_FAKTOR NUMERIC(29,2) DEFAULT 1 NOT NULL
OPTIONS(description='Korrekturwert zur Berechnung der Anzahl der Stellplätze.'),
BELOS_VORGANG_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Referenz zum Belos-Vorgang. Nicht in jedem Fall vorhanden. Defaultwert ist 0.'),
HANDLING_UNIT_ID_EXT STRING(20) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Die 18-stellige Nummer der Versandeinheit (NVE) aus dem Feld zzlvcdnve. Aus Konsistenzgründen als STRING(20) mit zwei führenden Nullen abgespeichert. COMPRESS mit CAMSET_L.'),
WG_VERKETT_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag. Zeigt an, ob eine_1 Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz.'),
WG_VERKETT_LIEF INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Die Warengruppenverkettung ist artikelbezogen. Wird in SAP auf die Kopftabelle hochgezogen, die erste Position als Quelle. Stimmt also bei Mischpaletten nicht für alle Positionen. Referenziert auf die Tabelle l_wg_verkettung. Das SAP-Feld ist zzlwgrv.'),
GP_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID). Entspricht elifn aus der Quelle.'),
WE_STATUS_ID STRING(1) COLLATE 'und:ci' DEFAULT '-' NOT NULL
OPTIONS(description='Wareneingangsstatus-ID, aus zlvwestatus.'),
DAT_AKTION DATE OPTIONS(description='Werbedatum.'),
DAT_ERSTELLUNG DATE OPTIONS(description='Erstellungsdatum des Lieferbeleges - Quelle: LIKP.ERDAT.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, LIEF_BELEG_ID, KJ) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Kopfdaten der Lieferscheine aus der SAP Tabelle LIPK enthalten.');