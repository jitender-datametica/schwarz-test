--==============================================================
-- Table: bestellart_wg_vorlauf_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bestellart_wg_vorlauf_per
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESTELLART_WG_VORLAUF_PER (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wg_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
   dat_von                             DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   tage_vorlauf                        NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl Tage Vorlauf',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESTELLART_WG_VORLAUF_PER PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, bestellart_id, dat_von) NOT ENFORCED
)  COMMENT = 'SCM - Tagevorlauf zur Ermittlung des Lieferdatums, aus SAP ZSCM_DC_GI_DATE';

