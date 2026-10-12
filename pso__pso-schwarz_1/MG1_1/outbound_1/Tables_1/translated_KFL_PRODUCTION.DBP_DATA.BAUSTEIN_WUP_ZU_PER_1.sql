CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BAUSTEIN_WUP_ZU_PER_1 (
BAUSTEIN_ID INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende des Gültigkeitszeitraums Format\'YYYY-MM_1-DD\''),
DAT_VON DATE OPTIONS(description='Beginn des Gültigkeitszeitraums Format\'YYYY-MM_1-DD\''),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, DAT_BIS, BAUSTEIN_ID) NOT ENFORCED
) OPTIONS(description='TP2/7 AIS - Zuordnung Baustein zu Wup_1 - MULTISET');