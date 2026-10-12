CREATE TABLE DBP_DATA.SORTIMENT_WG_VERTEILUNG_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Monat_2 eines Kalenderjahres, Format JJJJMM',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	WUG_ID NUMBER(38,0) NOT NULL,
	HWG_ID NUMBER(38,0) COMMENT 'ID der Hauptwarengruppe',
	OWG_ID NUMBER(38,0) COMMENT 'ID der Oberwarengruppe',
	NIELSEN_UMSATZ_ANTEIL_OWG NUMBER(38,5) COMMENT 'Anteil Umsatz der OWG innerhalb der Warengruppe (Nielsen Artikel_2)',
	NIELSEN_UMSATZ_ANTEIL_UWG NUMBER(38,5) COMMENT 'Anteil Umsatz der UWG innerhalb der Warengruppe (Nielsen Artikel_2)',
	NIELSEN_ARTIKEL_ANTEIL_OWG NUMBER(38,5) COMMENT 'Anteil Anzahl Artikel_2 der OWG innerhalb der Warengruppe (Nielsen Artikel_2)',
	NIELSEN_ARTIKEL_ANTEIL_UWG NUMBER(38,5) COMMENT 'Anteil Anzahl Artikel_2 der UWG innerhalb der Warengruppe (Nielsen Artikel_2)',
	KL_UMSATZ_ANTEIL_OWG NUMBER(38,5) COMMENT 'Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel_2)',
	KL_UMSATZ_ANTEIL_UWG NUMBER(38,5) COMMENT 'Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel_2)',
	KL_ARTIKEL_ANTEIL_OWG NUMBER(38,5) COMMENT 'Anteil Anzahl Artikel_2 der OWG innerhalb der Warengruppe (Kaufland Artikel_2)',
	KL_ARTIKEL_ANTEIL_UWG NUMBER(38,5) COMMENT 'Anteil Anzahl Artikel_2 der UWG innerhalb der Warengruppe (Kaufland Artikel_2)',
	KL_ERTRAG_ANTEIL_OWG NUMBER(38,5) COMMENT 'Anteil Rohertrag (ek_mep) der OWG innerhalb der Warengruppe (Kaufland Artikel_2)',
	KL_ERTRAG_ANTEIL_UWG NUMBER(38,5) COMMENT 'Anteil Rohertrag (ek_mep) der UWG innerhalb der Warengruppe (Kaufland Artikel_2)',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sortimentstool - Verteilung der Anzahl Artikel_2 und Umsatz (sowie Rohertrag bei KL-Artikel_2) innerhalb der WG auf Ebene WUG_ID (Nielsen und Kaufland-interne Daten)'
;