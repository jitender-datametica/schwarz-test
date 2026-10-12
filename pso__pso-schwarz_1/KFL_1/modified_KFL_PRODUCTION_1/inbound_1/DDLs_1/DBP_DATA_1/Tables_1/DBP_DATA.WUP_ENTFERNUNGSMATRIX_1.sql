--==============================================================
-- Table: wup_entfernungsmatrix_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_entfernungsmatrix_1
   generated from Powerdesigner on Freitag, 12. Januar 2024 12:39:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_ENTFERNUNGSMATRIX_1 (
   wup_id_a                            INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   wup_id_b                            INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   nb_id_a                             INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer die Nebenbetriebskennziffer',
   nb_id_b                             INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer die Nebenbetriebskennziffer',
   mandant_id_a                        INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   mandant_id_b                        INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   distanz_fahrweg_km                  NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Entfernung in auf Straßen zurückzulegenden Kilometern zwischen den zwei Standorten A und B',
   dauer_fahrzeit_min                  INTEGER     COMMENT 'Dauer der Fahrzeit in Minuten zwischen den zwei Standorten A und B',
   maut_km                             NUMBER(29,3)     COMMENT 'Anzahl mautpflichtiger Kilometer von DISTANZ_FAHRWEG_KM',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_ENTFERNUNGSMATRIX PRIMARY KEY (wup_id_a, wup_id_b, nb_id_a, nb_id_b, mandant_id_a, mandant_id_b) NOT ENFORCED
)  COMMENT = 'Entfernung (Fahrkilometer) zwischen zwei beliebigen Standorten';
