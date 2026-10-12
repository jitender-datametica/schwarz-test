CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sortiment_wg_verteilung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_2 eines Kalenderjahres, Format JJJJMM'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) NOT NULL,
hwg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Hauptwarengruppe'),
owg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Oberwarengruppe'),
nielsen_umsatz_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der OWG innerhalb der Warengruppe (Nielsen Artikel_2)'),
nielsen_umsatz_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der UWG innerhalb der Warengruppe (Nielsen Artikel_2)'),
nielsen_artikel_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel_2 der OWG innerhalb der Warengruppe (Nielsen Artikel_2)'),
nielsen_artikel_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel_2 der UWG innerhalb der Warengruppe (Nielsen Artikel_2)'),
kl_umsatz_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel_2)'),
kl_umsatz_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Umsatz der innerhalb der Warengruppe (Kaufland Artikel_2)'),
kl_artikel_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel_2 der OWG innerhalb der Warengruppe (Kaufland Artikel_2)'),
kl_artikel_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Anzahl Artikel_2 der UWG innerhalb der Warengruppe (Kaufland Artikel_2)'),
kl_ertrag_anteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Rohertrag (ek_mep) der OWG innerhalb der Warengruppe (Kaufland Artikel_2)'),
kl_ertrag_anteil_uwg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Rohertrag (ek_mep) der UWG innerhalb der Warengruppe (Kaufland Artikel_2)'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sortimentstool - Verteilung der Anzahl Artikel_2 und Umsatz (sowie Rohertrag bei KL-Artikel_2) innerhalb der WG auf Ebene WUG_ID (Nielsen und Kaufland-interne Daten)');