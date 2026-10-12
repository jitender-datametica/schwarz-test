CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_GP_NM_ZU_PER (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ART_ID INTEGER NOT NULL OPTIONS(description='DWH Artikelnummer'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode\n            '),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
EINKAUFSORGANISATION_ID INTEGER NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
DAT_BIS DATE NOT NULL OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei aktuellen Zuordnungen: 9999-12-31'),
VZ_WUP_ID INTEGER NOT NULL
OPTIONS(description='Verteilzentrum, von dem der Artikel beschafft wird. Falls der Artikel nicht aus einem VZ kommt, ist in diesem Feld der Markt selbst gespeichert'),
BQ_FINDUNG_ID INTEGER NOT NULL OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess'),
BEZUGSWEG_ID INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, WUP_ID, NB_ID, DAT_VON) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Artikel - Lieferanten-Zuordnung mit n:m - Beziehung. Enthält den Markt zur Herstellung der Eindeutigkeit. (entspricht etwa Tabelle art_gp_zu_per plus wup_id)');