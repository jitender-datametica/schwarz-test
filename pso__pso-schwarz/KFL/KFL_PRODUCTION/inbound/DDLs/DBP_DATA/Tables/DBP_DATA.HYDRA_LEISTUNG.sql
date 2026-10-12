--==============================================================
-- Table: hydra_leistung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_leistung
   generated from Powerdesigner on Montag, 22. August 2022 13:09:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HYDRA_LEISTUNG (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   buchungskreis_id_hydra              VARCHAR(4)      NOT NULL COMMENT 'Buchungskreis aus Hydra',
   produktivitaetsschl_hydra           VARCHAR(14)     NOT NULL COMMENT 'Produktivitätsschlüssel aus Hydra',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'Lagernummer / Lagerkomplex   ',
   transport_gv_id                     VARCHAR(18)     NOT NULL COMMENT 'Geschäftsvorfall',
   belegart_id_hydra                   VARCHAR(4)      NOT NULL COMMENT 'Belegart aus Hydra',
   wg_verkett_lief                     NUMBER(38,0)    NOT NULL COMMENT 'WG-Verkettung Lieferung',
   dat                                 DATE            NOT NULL COMMENT 'Feld vom Typ DATS         ',
   menge_1                             NUMBER(15,3)    COMMENT 'Stück für Kennzahl 1',
   dauer_1                             NUMBER(9,2)     COMMENT 'Dauer für Kennzahl 1 in Stunden',
   menge_2                             NUMBER(15,3)    COMMENT 'Stück für Kennzahl 2',
   dauer_2                             NUMBER(9,2)     COMMENT 'Dauer für Kennzahl 2 in Stunden',
   menge_3                             NUMBER(15,3)    COMMENT 'Stück für Kennzahl 3',
   dauer_3                             NUMBER(9,2)     COMMENT 'Dauer für Kennzahl 3 in Stunden',
   menge_4                             NUMBER(15,3)    COMMENT 'Stück für Kennzahl 4',
   dauer_4                             NUMBER(9,2)     COMMENT 'Dauer für Kennzahl 4 in Stunden',
   abrechnung_fg                       NUMBER(38,0)    COMMENT 'Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern',
   personalteilbereich_id              VARCHAR(4)      COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HYDRA_LEISTUNG PRIMARY KEY (mandant_id, buchungskreis_id_hydra, produktivitaetsschl_hydra, lagernummer_id, transport_gv_id, belegart_id_hydra, wg_verkett_lief, dat) NOT ENFORCED
)  COMMENT = '2DO - for clarification';
