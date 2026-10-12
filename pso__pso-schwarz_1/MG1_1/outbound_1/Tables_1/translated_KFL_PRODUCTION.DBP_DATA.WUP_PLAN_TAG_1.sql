CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WUP_PLAN_TAG_1 (
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
DAT DATE NOT NULL OPTIONS(description='Datum'),
PLAN_TAG_FG INTEGER
OPTIONS(description='Wenn die Daten bereits in der SST auf der Ebene wup_1 und Tag_1 geliefert wurden: 1, sonst  0'),
UMSATZ_NETTO_PLAN NUMERIC(18,2) OPTIONS(description='geplanter Nettoumsatz'),
WRG_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
UMSATZ_NETTO_PLAN_EXTERN NUMERIC(18,2) OPTIONS(description='umsatz_netto_plan_extern. Upload aus Excel'),
MENGE_ABSATZ_OHNE_PFAND_PLAN NUMERIC(29,3)
OPTIONS(description='Geplante Anzahl der zu verkaufenden Artikel_1 (ohne Pfand-Artikel_1) auf  Ebene Filiale/Tag.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (WUP_ID, NB_ID, MANDANT_ID, DAT) NOT ENFORCED
) OPTIONS(description='VIS - Planwerte pro Markt und Tag_1');