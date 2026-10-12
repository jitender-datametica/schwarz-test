--==============================================================
-- Table: flw_kalk_erzeugnis_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_erzeugnis_det_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALK_ERZEUGNIS_DET_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   kalk_id                             NUMBER(18,0)     NOT NULL COMMENT 'Kalkulationsnummer aus kalnr',
   kalkulationsart_id                  VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Kalkulationsart aus kalka. Schlüssel, der die interne Steuerung der Kalkulationsanwendung steuert (Bezugsobjekt z.B. Material, Musterkalkulation, Auftrag, Projekt). Die Kalkulationsart wird in der Kalkulationsvariante hinterlegt.',
   bewertung_variante_id               VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Bewertungsvariante aus bwvar',
   kalk_version_id                     NUMBER(38,0)     NOT NULL COMMENT 'Kalkulationsversion aus tvers',
   vorstufe_fg                         NUMBER(38,0)     NOT NULL COMMENT 'ist = 1, wenn Vorstufe, sonst 0 aus kkzst',
   dat_kalk                            DATE             NOT NULL COMMENT 'Kalkulationsdatum (Key) - Datum, an dem die Kalkulation erstellt wurde',
   kst001                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: Materialeinzelkosten Rohmaterial  Mandant_2 2: Materialeinzelkosten Rohmaterial  aus kst001',
   kst002                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: MEK Verarbeitungsmaterial Mandant_2 2: --- aus kst002',
   kst003                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: MEK Zusätze Mandant_2 2: --- aus kst003',
   kst004                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: MEK Verpackung Mandant_2 2: --- aus kst004',
   kst005                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: FEK Trennprozess Mandant_2 2: MEK Verarbeitungsmaterial aus kst005',
   kst006                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: FEK Mischprozess Mandant_2 2:---  aus kst006',
   kst008                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: Materialgemeinkosten  Mandant_2 2: --- aus kst008',
   kst009                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2:  MEK Verpackung aus kst009',
   kst010                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: Fertigungsgemeinkosten Mandant_2 2: --- aus kst010',
   kst011                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2: FEK Trennprozess aus kst011',
   kst012                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: Vertriebsgemeinkosten Mandant_2 2: --- aus kst012',
   kst013                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2: FEK Mischprozess aus kst013',
   kst014                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: Verwaltungsgemeinkosten Mandant_2 2: --- aus kst014',
   kst015                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2:  Vertriebseinzelkosten aus kst015',
   kst017                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2:  Materialgemeinkosten aus kst017',
   kst019                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2: Fertigungsgemeinkosten aus kst019',
   kst021                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2: Vertriebsgemeinkosten  aus kst021',
   kst023                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: --- Mandant_2 2: Verwaltungsgemeinkosten aus kst023',
   kst007                              NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Mandant_2 1: Vertriebseinzelkosten Mandant_2 2: MEK Zusätze aus kst007',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALK_ERZEUGNIS_DET PRIMARY KEY (mandant_id, kalk_id, kalkulationsart_id, bewertung_variante_id, kalk_version_id, vorstufe_fg, dat_kalk) NOT ENFORCED
)  COMMENT = 'FLW - Positionsdaten zur Materialkalkulation aus keph';

