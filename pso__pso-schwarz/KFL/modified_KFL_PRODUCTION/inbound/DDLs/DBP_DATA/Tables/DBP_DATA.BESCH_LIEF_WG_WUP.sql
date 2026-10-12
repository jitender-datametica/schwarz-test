--==============================================================
-- Table: besch_lief_wg_wup
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_wg_wup
   generated from Powerdesigner on Tuesday, April 12, 2022 1:46:27 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_LIEF_WG_WUP CLUSTER BY (DAT_LIEF_SOLL)(
   mandant_id                          INTEGER    NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   wup_id                              INTEGER    NOT NULL COMMENT 'Nummer des VZ',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   lagerort_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Dieses Feld referenziert die DWH Tabelle Lagerort.',
   diff_id                             VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Wenn eine Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.',
   dat_lief_soll                       DATE            NOT NULL COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen.',
   lief_typ_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine Lieferung bearbeitet.',
   vertr_beleg_typ_id                  VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. wurde der Lieferschein aufgrund eines Wareneingangs generiert.',
   wg_id                               INTEGER    NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER    NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   kunde_id                            VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Warenempfänger (Marktnummer)',
   wg_verkett_lief                     INTEGER    DEFAULT -1 NOT NULL COMMENT 'Die Warengruppenverkettung gibt an, welche Artikel gemeinsam auf eine Palette gepackt werden.',
   menge_lief_soll_bme                 NUMBER(29,3)    COMMENT 'Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.',
   menge_lief_soll_kolli               NUMBER(29,3)    COMMENT 'Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  ',
   betrag_lief_soll                    NUMBER(29,2)    COMMENT 'Aggregation betrag_lief_soll aus besch_lief_det',
   menge_lief_ist_bme                  NUMBER(29,3)    COMMENT 'Menge der Lieferposition, ausgedrückt in Verkaufsmengeneinheiten aus lfimg.',
   menge_lief_ist_kolli                NUMBER(29,3)    COMMENT 'Anzahl der Kollis der Lieferposition. Ermittlung bei der Kommisionierung',
   betrag_lief_ist                     NUMBER(29,2)    COMMENT 'Aggregation betrag_lief_ist aus besch_lief_det',
   lief_pal_typ_id                     VARCHAR(2)      COLLATE 'en-ci' NOT NULL COMMENT 'aus der Tabelle besch_lief',
   anzahl_position                     INTEGER    COMMENT 'Anzahl der Positionen in der besch_lief_det',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' DEFAULT 'EUR' NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   mandant_id_kunde                    INTEGER    DEFAULT 1 NOT NULL COMMENT 'Der Kunde kann zu einem anderen Mandanten als der WUP gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK',
   vk_netto_lief_soll                  NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Soll-Liefermenge bewertet zum Verkaufspreis minus MehrWertSteuer',
   vk_netto_lief_ist                   NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Ist-Liefermenge bewertet zum Verkaufspreis minus MehrWertSteuer',
   werbeware_id                        VARCHAR(1)      COLLATE 'en-ci' DEFAULT ' ' NOT NULL COMMENT 'Aus besch_lief: Wenn die Bestellart eine Werbebestellart ist. Wertevorrat: W     Werbung       N      Normalware    B      W und N       S      Schnellschuss',
   bestellart_id                       VARCHAR(4)      COLLATE 'en-ci' DEFAULT '    ' NOT NULL COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
   hu_status_id                        VARCHAR(4)      COLLATE 'en-ci' DEFAULT '    ' NOT NULL COMMENT 'Bewegungsstatus der Handling Unit',
   anzahl_packstueck                   INTEGER    DEFAULT 0 NOT NULL COMMENT 'Aggregation der Gesamtanzahl  der Packstücke für alle Positionen der Lieferung',
   brtvol_ladung_liter                 NUMBER(29,3)    DEFAULT 0 NOT NULL COMMENT 'Volumen der Ladung in Litern. Wird aud handling_unit.vol_ladung errechnet',
   brtvol_ladung_liter_gedeckelt       NUMBER(29,3)    DEFAULT 0 NOT NULL COMMENT 'Volumen der Ladung in Litern. Wird aud handling_unit.vol_ladung errechnet - Deckelung des Volumen der einzelnen HU auf max. 2304 cdm',
   auslieferungsgruppe_id              VARCHAR(4)      COMMENT 'Auslieferungsgruppe aus ZLF_AUSLFEL',
   ntvol_ladung_liter                  NUMBER(29,3)    COMMENT 'Nettovolumen HU in Liter',
   ntvol_ladung_liter_gedeckelt        NUMBER(29,3)    COMMENT 'Nettovolumen HU in Liter (gedeckelt)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_LIEF_WG_WUP PRIMARY KEY (mandant_id, wup_id, nb_id, lagerort_id, diff_id, dat_lief_soll, lief_typ_id, vertr_beleg_typ_id, wg_id, arthiertyp_id, kunde_id, wg_verkett_lief) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Diese Tabelle enthält die nach Warengruppe, Lagerort und Lieferscheintyp  aggregierten Lieferscheine - MULTISET';


