--==============================================================
-- Table: ts_mengenaenderungen_writeback_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_mengenaenderungen_writeback_1
   generated from Powerdesigner on Dienstag, 29. April 2025 09:21:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_MENGENAENDERUNGEN_WRITEBACK_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Aktion_1-ID',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer im DWH. Wird aus matnr erzeugt.',
   dat_von                             DATE             COMMENT 'Aktion_1 gültig von.',
   dat_bis                             DATE             COMMENT 'Aktion_1 gültig bis.',
   angebot_id                          INTEGER     NOT NULL COMMENT 'Offer / Angebot_1-ID.',
   dat_beladung                        DATE             NOT NULL COMMENT 'Technisches Beladungsdatum.',
   menge_ohne_bestand_genehmigt_fg     INTEGER     COMMENT 'Flag: Wird vom User gesetzt, wenn die Werbebestellmenge (z.B. in der Bestellung ans Verteilzentrum) errechnet ohne Berücksichtigung des aktuellen Bestands weiter verwendet werden soll. Ohne Bestandsberücksichtigung ist z.B. für den Fall, dass ein aktuell hoher Bestand vor der Aktion_1 wegen Mhd-Ablauf verfällt, oder es wegen anderer Aktionen zu erwarten ist, dass der Bestand sich abverkauft, weshalb die unreduzierte Bestellmenge genommen werden kann.
            Einträge werden durch MSTR gepflegt und in Abinitio weiterverarbeitet. Mit oder ohne Bestandsberücksichtigung schließen sich gegenseitig aus. Es kann also immer nur einer von beiden aktiv sein. Die Variante mit zwei Flags wurde anstatt eines Codes gewählt, da es eine_1 übersichtlichere Ansicht in MSTR ermöglicht, als ein drop-down Menü',
   menge_mit_bestand_genehmigt_fg      INTEGER     COMMENT 'Flag: Wird vom User gesetzt, wenn die Werbebestellmenge (z.B. in der Bestellung ans Verteilzentrum) errechnet mit Berücksichtigung des aktuellen Bestands weiter verwendet werden soll. Mit Bestandsberücksichtigung ist z.B. für den Fall, dass es einen aktuell hohen Bestand des Artikels gibt, der vor der Aktion_1 wahrscheinlich nicht signifikant abnimmt, was eine_1 Reduktion der Bestellmenge zur Folge haben kann.
            Einträge werden durch MSTR gepflegt und in Abinitio weiterverarbeitet.  Mit oder ohne Bestandsberücksichtigung schließen sich gegenseitig aus. Es kann also immer nur einer von beiden aktiv sein. Die Variante mit zwei Flags wurde anstatt eines Codes gewählt, da es eine_1 übersichtlichere Ansicht in MSTR ermöglicht, als ein drop-down Menü',
   werbeaenderung_menge_uebertragen    NUMBER(29,3)     COMMENT 'Übertragene Menge zu SAP. (Wird aktuell nicht benutzt. Muss später geklärt werden ob die Spalte bennötigt wird, nachdem weitere Länder (vielleicht alle) an WBS angebunden sind.)',
   fixmenge_wfl_bme                    INTEGER     COMMENT 'Die feste Menge, die vom Benutzer eingegeben und auf alle Filialen aufgeteilt werden muss (diese Berechnung wird im Replenishment Core durchgeführt).
            (FixMenge Bedueted : Freez Diese Menge, um sie an alle Filialen zu aufzuteilen)',
   menge_mindestplatzierung_cluster_1_ame INTEGER     COMMENT 'Minimum Quantity eines Artikels für eine_1 Filiale in Cluster 1. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.',
   menge_mindestplatzierung_cluster_2_ame INTEGER     COMMENT 'Minimum Quantity eines Artikels für eine_1 Filiale in Cluster 2. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.',
   menge_mindestplatzierung_cluster_3_ame INTEGER     COMMENT 'Minimum Quantity eines Artikels für eine_1 Filiale in Cluster 3. Die Filialen werden je nach Größe in verschiedene Cluster unterteilt, Die Mindestmenge ist im Replenishment Core vorberechnet und wird vom User festgelegt.',
   wfl_menge_geprueft_fg               INTEGER     COMMENT 'Flag,  Waren Fluss (Supply Change Managment Flag), die der Benutzer  auf 1 setzen kann ,um zu markieren, dass er die Mengen fuer diesen Artkel bereits überprüft hat und beibehalten wird,solange es keine Aenderungen bei der Promotion gibt.',
   wfl_nutzer_kommentar_txt            VARCHAR(100)     COMMENT 'Frei-Text-Feld fuer den Benutzer
            Dieses Feld dient dazu, einen zusätzlichen Kommentar zu einem Artikel_1 hinzuzufügen. Es dient dazu, besser nachzuvollziehen, was das Problem vorher war.',
   estimation_id                       INTEGER     COMMENT 'With this ID the user can decide in which way the estimation for WBS TP2 should be calculated.
            ID 0 = no estimation
            ID 1 = calculate normal estimation process
            ID 2 = only fill up maximum capacity (Berechnung für die Werbung in WBS, aber nur um das Regal aufzufüllen)',
   init_lief_clear_stock_id            INTEGER     COMMENT 'Clear-Stock ID that says how to distribute stock. The goal is to change the clear-stock-flag-logic, so that the user has the possibility to use a third option for distributing the DC stock:
            0 = do not apply the logic (distribute according to demand in the stores)
            1 = distribute the whole blocked stock in DC
            2 = distribute the whole stock in DC (blocked stock + free stock)',
   adjustment_id                       INTEGER     COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.
            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R
            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.
            2 = Platzhalter (Stand 28.03.2025)
            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_1 manuelle Bestellanlage durch das Land_1 notwendig.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_MENGENAENDERUNGEN_WRITEBACK PRIMARY KEY (mandant_id, aktion_id, angebot_id, dat_beladung, art_id) NOT ENFORCED
)  COMMENT = 'SCM-WBS - Writeback of promotional item_1 quantity approval.
             (Tabelle liegt aktuell im falschen Schema. Sollte in DBP_MSI_DATA sein.)';
