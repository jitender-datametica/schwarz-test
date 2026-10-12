--==============================================================
-- Table: cos_bonuskauf_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_sum_2
   generated from Powerdesigner on Monday, 22 April 2024 11:56:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.COS_BONUSKAUF_SUM_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   bonuskauf_id                        VARCHAR(20)      NOT NULL COMMENT 'Eindeutige ID einer Bonuskaufaktion.',
   kampagnen_id_liste_txt              VARCHAR(2000)    COMMENT 'Komma-separierte Textliste von Kampagnen-IDs, die einer bestimmten bonuskauf_id zugeordnet sind.',
   coupon_typ_name                     VARCHAR(20)      NOT NULL DEFAULT 'Coupon' COMMENT 'Beschreibt um welchen Coupontyp es sich handelt: Partner, Marktplatz, SMP, Coupon.',
   aktion_typ_name                     VARCHAR(20)      NOT NULL DEFAULT 'Normal' COMMENT 'Beschreibt um welchen Aktionstyp es sich handelt: Gamification, Checkout, Kaufbar, Reco, Normal.',
   anz_zielgruppengroesse              INTEGER     COMMENT 'Gibt die Zielgruppengröße des Coupons an.',
   kanal_liste_txt                     VARCHAR(256)     COMMENT 'Komma-separierte Textliste der Kommunikationskanäle, über die der Coupon bespielt wurde. Gilt aktuell nur für Partnercoupons. DBP_DATA.COS_BONUSKAUF.BONUSKAUF_PARTNER_FG = 1: App, Web, SSC (Self Service Cockpit), Marktplatz, Kampagne. Mehrfachauswahl ist möglich.',
   anz_punkte_coupon_benoetigt         INTEGER     COMMENT 'Anzahl der Punkte die eingelöst werden müssen (erwerben) um den Coupon verwenden zu können.',
   anz_aktivierungen_kaufbar           INTEGER     COMMENT 'Gibt die Anzahl der Aktivierungen von kaufbaren Coupons wieder.',
   anz_aktivierungen_nicht_kaufbar     INTEGER     COMMENT 'Gibt die Anzahl der Aktivierungen von nicht-kaufbaren Coupons wieder.',
   anz_gesamt_aktivierungen            INTEGER     COMMENT 'Gesamtanzahl der Aktivierungen.',
   rate_aktivierungsquote              NUMBER(29,5)     COMMENT 'Berechnet sich aus der Gesamtanzahl der Aktivierungen / Zielgruppengroesse.',
   anz_einloesungen_kaufbar            INTEGER     COMMENT 'Gibt die Anzahl der Einloesungen von kaufbaren Coupons wieder.',
   anz_einloesungen_nicht_kaufbar      INTEGER     COMMENT 'Gibt die Anzahl der Einloesungen von nicht-kaufbaren Coupons wieder.',
   anz_gesamt_einloesungen             INTEGER     COMMENT 'Gesamtanzahl der Einloesungen.',
   rate_einloesequote                  NUMBER(29,5)     COMMENT 'Berechnet sich aus den Gesamteinloesungen / Gesamtaktivierungen.',
   anz_gesamt_punkte_einloesungen      INTEGER     COMMENT 'Gesamtanzahl der eingelösten Punkte. Berechnet sich aus Anzahl Punkte Coupon benötigt * Anzahl Gesamteinloesungen.',
   anz_unique_kunden                   INTEGER     COMMENT 'Anzahl der eindeutigen CRM-Kunden-IDs. Da eine_2 bonuskauf_id mehrere Kampagnen besitzen kann, zählen hier die eindeutigen crm_kunden_ids im Gültigkeitszeitraum des Coupons.',
   betrag_bonuskauf_umsatz_brutto      NUMBER(29,4)     COMMENT 'Der Bruttoumsatz der durch den Coupon generiert wurde.',
   betrag_bonuskauf_umsatz_brutto_konz NUMBER(29,4)     COMMENT 'Der Bruttoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.',
   betrag_bonuskauf_umsatz_netto       NUMBER(29,4)     COMMENT 'Der Nettoumsatz der durch den Coupon generiert wurde.',
   betrag_bonuskauf_umsatz_netto_konz  NUMBER(29,4)     COMMENT 'Der Nettoumsatz der durch den Coupon generiert wurde, in Konzernwaehrung zum Tageskurs.',
   menge_bonuskauf_bme                 NUMBER(29,3)     COMMENT 'Die Abverkaufsmenge die durch den Coupon generiert wurde. Es kann in Stück oder bei Gewichtsartikeln in KG sein.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSKAUF_SUM PRIMARY KEY (mandant_id, bonuskauf_id) NOT ENFORCED
)  COMMENT = 'Couponaggregationstabelle zur Optimierung der Performance in EK Kunde';
