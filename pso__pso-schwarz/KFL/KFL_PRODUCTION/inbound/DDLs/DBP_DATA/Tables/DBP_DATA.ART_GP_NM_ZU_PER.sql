--==============================================================
-- Table: art_gp_nm_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_nm_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GP_NM_ZU_PER (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'DWH Artikelnummer',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode
            ',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             NUMBER(38,0)     NOT NULL COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem die Zuordnung gilt. Bei aktuellen Zuordnungen: 9999-12-31',
   vz_wup_id                           NUMBER(38,0)     NOT NULL COMMENT 'Verteilzentrum, von dem der Artikel beschafft wird. Falls der Artikel nicht aus einem VZ kommt, ist in diesem Feld der Markt selbst gespeichert',
   bq_findung_id                       NUMBER(38,0)     NOT NULL COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess',
   bezugsweg_id                        NUMBER(38,0)     NOT NULL COMMENT 'Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GP_NM_ZU_PER PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Artikel - Lieferanten-Zuordnung mit n:m - Beziehung. Enthält den Markt zur Herstellung der Eindeutigkeit. (entspricht etwa Tabelle art_gp_zu_per plus wup_id)';

