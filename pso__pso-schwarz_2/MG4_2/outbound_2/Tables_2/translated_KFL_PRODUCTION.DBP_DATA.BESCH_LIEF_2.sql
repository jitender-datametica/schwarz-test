CREATE OR REPLACE TABLE kfl_production_dbp_data.besch_lief_2 (
mandant_id INTEGER NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
lief_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
kj INTEGER NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID, wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
versandstelle_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_2 Gruppe_2 von Laderampen) oder um eine_2 logische Gruppierung (z.B. eine_2 Gruppe_2 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
lief_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_2 Lieferung bearbeitet.'),
dat_lief_soll DATE NOT NULL
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen.'),
vertr_beleg_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. ob der Lieferschein aufgrund eines Wareneingangs generiert wurde.'),
lief_pal_typ_id STRING(1) NOT NULL
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_2 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.'),
kunde_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nummer des Warenempfängers der Lieferung. Diese Nummer referenziert die DWH Tabelle wup. COMPRESS mit CAMSET_L.'),
auftraggeber_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kunde, der die Waren oder Dienstleistungen bestellt. Der Auftraggeber übernimmt die vertragliche Haftung für den Kundenauftrag. COMPRESS mit CAMSET_L.'),
anzahl_packstueck INTEGER OPTIONS(description='Gesamte Anzahl der Packstücke für alle Positionen der Lieferung.'),
werbeware_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Wird gefüllt, wenn die Bestellart eine_2 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B-W und N-S = Schnellschuss.'),
dat_lagerbew_ist DATE OPTIONS(description='Warenbewegungsdatum im Lieferschein.'),
system_id INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id_kunde INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als dem des WUP_2 gehören, z.B. Lager aus CZ beliefert Markt in SK.'),
cd_kz STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für Cross Docking aus zlvcd.  Referenz zur Lookuptabelle l_cd_typ.'),
wup_id_cd INTEGER NOT NULL OPTIONS(description='Nummer des Verteilzentrums bei CD-Verkehren.'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie.'),
stellplatz_faktor NUMERIC(29,2) DEFAULT 1 NOT NULL
OPTIONS(description='Korrekturwert zur Berechnung der Anzahl der Stellplätze.'),
belos_vorgang_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Referenz zum Belos-Vorgang. Nicht in jedem Fall vorhanden. Defaultwert ist 0.'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Die 18-stellige Nummer der Versandeinheit (NVE) aus dem Feld zzlvcdnve. Aus Konsistenzgründen als STRING(20) mit zwei führenden Nullen abgespeichert. COMPRESS mit CAMSET_L.'),
wg_verkett_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag. Zeigt an, ob eine_2 Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz.'),
wg_verkett_lief INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Die Warengruppenverkettung ist artikelbezogen. Wird in SAP auf die Kopftabelle hochgezogen, die erste Position als Quelle. Stimmt also bei Mischpaletten nicht für alle Positionen. Referenziert auf die Tabelle l_wg_verkettung. Das SAP-Feld ist zzlwgrv.'),
gp_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID). Entspricht elifn aus der Quelle.'),
we_status_id STRING(1) COLLATE 'und:ci' DEFAULT '-' NOT NULL
OPTIONS(description='Wareneingangsstatus-ID, aus zlvwestatus.'),
dat_aktion DATE OPTIONS(description='Werbedatum.'),
dat_erstellung DATE OPTIONS(description='Erstellungsdatum des Lieferbeleges - Quelle: LIKP.ERDAT.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lief_beleg_id, kj) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Kopfdaten der Lieferscheine aus der SAP Tabelle LIPK enthalten.');