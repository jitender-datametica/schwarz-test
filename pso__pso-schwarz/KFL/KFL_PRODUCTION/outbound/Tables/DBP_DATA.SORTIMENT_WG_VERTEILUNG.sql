CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sortiment_wg_verteilung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) NOT NULL,
hwg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Hauptwarengruppe'),
owg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Oberwarengruppe'),
nielsen_umsatz_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der OWG innerhalb der Warengruppe (Nielsen Artikel)'),
nielsen_umsatz_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der UWG innerhalb der Warengruppe (Nielsen Artikel)'),
nielsen_artikel_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel der OWG innerhalb der Warengruppe (Nielsen Artikel)'),
nielsen_artikel_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel der UWG innerhalb der Warengruppe (Nielsen Artikel)'),
kl_umsatz_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel)'),
kl_umsatz_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel)'),
kl_artikel_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel der OWG innerhalb der Warengruppe (Kaufland Artikel)'),
kl_artikel_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel der UWG innerhalb der Warengruppe (Kaufland Artikel)'),
kl_ertrag_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Rohertrag (ek_mep) der OWG innerhalb der Warengruppe (Kaufland Artikel)'),
kl_ertrag_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Rohertrag (ek_mep) der UWG innerhalb der Warengruppe (Kaufland Artikel)'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sortimentstool - Verteilung der Anzahl Artikel und Umsatz (sowie Rohertrag bei KL-Artikel) innerhalb der WG auf Ebene WUG_ID (Nielsen und Kaufland-interne Daten)');