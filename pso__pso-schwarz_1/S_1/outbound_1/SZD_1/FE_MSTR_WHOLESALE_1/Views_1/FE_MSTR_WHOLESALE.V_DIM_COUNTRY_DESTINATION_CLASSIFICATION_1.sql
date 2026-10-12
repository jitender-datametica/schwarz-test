CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_country_destination_classification_1 (container_dest_country_classification
) AS SELECT 'Nur EU-Ware' AS container_dest_country_classification
UNION ALL
SELECT 'Nicht EU-Ware & EU-Ware'
UNION ALL
SELECT 'Nur Nicht-EU-Ware';