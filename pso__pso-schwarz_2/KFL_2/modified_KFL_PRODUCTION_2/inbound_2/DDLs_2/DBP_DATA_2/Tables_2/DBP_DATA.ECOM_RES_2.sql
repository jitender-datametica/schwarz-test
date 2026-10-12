--==============================================================
-- Table: ecom_res_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ecom_res_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ECOM_RES_2 (
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer im DWH',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Gültigkeitbeginn für diesen Datensatz.',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion. Referenz zur Tabelle aktion_2 (wakh.aktnr)',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ECOM_RES PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Die Tabelle enthält die reservierbaren Artikel_2 für E-Commerce. Quelle ist zek_ecom_res';

