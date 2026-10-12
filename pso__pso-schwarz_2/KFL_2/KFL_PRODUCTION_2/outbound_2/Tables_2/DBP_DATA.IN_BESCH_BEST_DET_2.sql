--==============================================================
-- Table: in_besch_best_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_besch_best_det_2
   generated from Powerdesigner on Montag, 22. August 2022 09:49:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_besch_best_det_2 (
best_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer des Einkaufsbelegs aus ebeln'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegposition des Einkaufsbelegs aus ebelp'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
in_art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
menge_best_bme NUMERIC(18,3) NOT NULL
OPTIONS(description='bestellte Menge des Artikel_2 dieser Position in Bestellmengeneinheit aus menge'),
best_menge_einh_id STRING(3) NOT NULL
OPTIONS(description='Einheit der Bestellmenge aus meins. Entspricht nicht meins aus der Tabelle mara_2!'),
best_preis_menge_einh_id STRING(3) OPTIONS(description='ID der alternativen Mengeneinheit aus meinh'),
loesch_id STRING(1) NOT NULL
OPTIONS(description='die loesch_id enthält das Löschkennzeichen für diese Position aus loekz'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
retourenpos_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Flag gibt an ob die Position eine_2 Retourenposition ist aus retpo'),
dupli_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Bestimmte Positionen werden im SAP dupliziert und manipuliert und im Feld ekpo.txz01 mit (+) gekennzeichnet. Solche Positionen erhalten im DWH eine_2 1'),
besch_pos_typ_id STRING(1) NOT NULL
OPTIONS(description='Positionstyp im Einkaufsbeleg aus pstyp. Wichtig für FLW ist die Ausprägung 0 = Normal, evtl. noch 5= Strecke'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
nettopreis NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Gibt den Nettopreis pro Preiseinheit an. Aus netpr'),
betrag_pos_netto_best_wrg NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Nettobestellwert in Bestellwährung aus netwr'),
endrech_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Endrechnungs Flag aus erekz'),
rech_plan_id INTEGER OPTIONS(description='Rechnungsplannummer aus fplnr. Hat eine_2 Referenz zur SAP Tabelle FPLA'),
bsak_dat_buch DATE
OPTIONS(description='Buchungsdatum der Rechnung.Wird aus der Tabelle bsak zu Performancezwecken angereichert'),
menge_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Bestellmenge in Basismengeneinheit (Einheit in in_art_2 vorhanden), kann von marm_2 abweichen, aus ekpo.umrez/ekpo.umren errechnet, für BIS benötigt'),
unterposition_typ_id STRING(1) DEFAULT ' ' NOT NULL OPTIONS(description='Auftrags- oder Unterpositionstyp aus uptyp'),
in_wg_id STRING(10) DEFAULT '          ' NOT NULL
OPTIONS(description='Warengruppe aus dem Industriesystem. Quelle ist matkl'),
k_shop_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen, ob der Artikel_2 zum Zeitpunkt der Bestellung (bsak_dat_buch) im K-Shop gelistet ist'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (best_beleg_id, best_beleg_pos_id, mandant_id) NOT ENFORCED
) OPTIONS(description='BIS - Bestellungen  - Detaildaten aus SAP EKPO_2 - MULTISET');