CREATE TABLE DBP_DATA.SORTIMENT_WG_VERTEILUNG_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	KJMO INTEGER NOT NULL COMMENT 'Monat_1 eines Kalenderjahres, Format JJJJMM',
	WG_ID INTEGER NOT NULL COMMENT 'ID der Warengruppe',
	WUG_ID INTEGER NOT NULL,
	HWG_ID INTEGER COMMENT 'ID der Hauptwarengruppe',
	OWG_ID INTEGER COMMENT 'ID der Oberwarengruppe',
	NIELSEN_UMSATZ_ANTEIL_OWG NUMBER(29,5) COMMENT 'Anteil Umsatz der OWG innerhalb der Warengruppe (Nielsen Artikel_1)',
	NIELSEN_UMSATZ_ANTEIL_UWG NUMBER(29,5) COMMENT 'Anteil Umsatz der UWG innerhalb der Warengruppe (Nielsen Artikel_1)',
	NIELSEN_ARTIKEL_ANTEIL_OWG NUMBER(29,5) COMMENT 'Anteil Anzahl Artikel_1 der OWG innerhalb der Warengruppe (Nielsen Artikel_1)',
	NIELSEN_ARTIKEL_ANTEIL_UWG NUMBER(29,5) COMMENT 'Anteil Anzahl Artikel_1 der UWG innerhalb der Warengruppe (Nielsen Artikel_1)',
	KL_UMSATZ_ANTEIL_OWG NUMBER(29,5) COMMENT 'Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel_1)',
	KL_UMSATZ_ANTEIL_UWG NUMBER(29,5) COMMENT 'Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel_1)',
	KL_ARTIKEL_ANTEIL_OWG NUMBER(29,5) COMMENT 'Anteil Anzahl Artikel_1 der OWG innerhalb der Warengruppe (Kaufland Artikel_1)',
	KL_ARTIKEL_ANTEIL_UWG NUMBER(29,5) COMMENT 'Anteil Anzahl Artikel_1 der UWG innerhalb der Warengruppe (Kaufland Artikel_1)',
	KL_ERTRAG_ANTEIL_OWG NUMBER(29,5) COMMENT 'Anteil Rohertrag (ek_mep) der OWG innerhalb der Warengruppe (Kaufland Artikel_1)',
	KL_ERTRAG_ANTEIL_UWG NUMBER(29,5) COMMENT 'Anteil Rohertrag (ek_mep) der UWG innerhalb der Warengruppe (Kaufland Artikel_1)',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sortimentstool - Verteilung der Anzahl Artikel_1 und Umsatz (sowie Rohertrag bei KL-Artikel_1) innerhalb der WG auf Ebene WUG_ID (Nielsen und Kaufland-interne Daten)'
;