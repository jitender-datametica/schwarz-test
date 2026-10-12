CREATE TABLE DBP_DATA.BSCH_RECH_DET_GP_SUM_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2',
   dat                                 DATE            NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
   gp_id                               INTEGER    NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   vw_id                               INTEGER    NOT NULL COMMENT 'ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte',
   ek_n                                NUMBER(29,4)    NOT NULL COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema)',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BSCH_RECH_DET_GP_SUM PRIMARY KEY (mandant_id, dat, gp_id, vw_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Aggregat über Wareneingänge pro Lieferant, Tag_2 und Vertriebsweg - MULTISET';
