CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.tupel_tags_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden'),
tupel_tag STRING(200) DEFAULT '-1' NOT NULL OPTIONS(description='Freitext, der vom User matching_ids zugeordnet wird'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='Pflege produktspezifischer Kurzinformationen zur Sortimentsarbeit durch User im Frontend');