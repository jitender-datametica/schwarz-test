CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_container_country_destination_classification_1 (container_resource_item_sid
, container_dest_country_classification) AS SELECT FACT.container_resource_item_sid,
  CASE
  WHEN AVG(CASE
     WHEN COUNTRY_POL.eu_member_fg
     THEN 1
     ELSE 0
     END) = 1
  THEN 'Nur EU-Ware'
  WHEN AVG(CASE
      WHEN COUNTRY_POL.eu_member_fg
      THEN 1
      ELSE 0
      END) > 0 AND AVG(CASE
      WHEN COUNTRY_POL.eu_member_fg
      THEN 1
      ELSE 0
      END) < 1
  THEN 'Nicht EU-Ware & EU-Ware'
  WHEN AVG(CASE
     WHEN COUNTRY_POL.eu_member_fg
     THEN 1
     ELSE 0
     END) = 0
  THEN 'Nur Nicht-EU-Ware'
  ELSE NULL
  END AS container_dest_country_classification
FROM szd_core.t_fact_lot_lot_part_container_1 AS FACT
 INNER JOIN szd_core.t_dim_country_political_1 AS COUNTRY_POL ON CASE
   WHEN LENGTH(FACT.shipping_destination_cd) = 3 AND CASE
      WHEN REGEXP_CONTAINS(FACT.shipping_destination_cd, r'K')
      THEN LENGTH(REGEXP_REPLACE(FACT.shipping_destination_cd, CONCAT('(.*?)', 'K', '(.*)'), '\\1')) + 1
      ELSE 0
      END = 1
   THEN RIGHT(FACT.shipping_destination_cd, 2)
   WHEN LENGTH(FACT.shipping_destination_cd) = 3 AND CASE
       WHEN REGEXP_CONTAINS(FACT.shipping_destination_cd, r'K')
       THEN LENGTH(REGEXP_REPLACE(FACT.shipping_destination_cd, CONCAT('(.*?)', 'K', '(.*)'), '\\1')) + 1
       ELSE 0
       END = 0 AND FACT.shipping_destination_cd <> 'CON'
   THEN LEFT(FACT.shipping_destination_cd, 2)
   WHEN LENGTH(FACT.shipping_destination_cd) = 4 AND CASE
      WHEN REGEXP_CONTAINS(FACT.shipping_destination_cd, r'KO')
      THEN LENGTH(REGEXP_REPLACE(FACT.shipping_destination_cd, CONCAT('(.*?)', 'KO', '(.*)'), '\\1')) + 1
      ELSE 0
      END = 1
   THEN RIGHT(FACT.shipping_destination_cd, 2)
   WHEN LENGTH(FACT.shipping_destination_cd) = 4 AND CASE
      WHEN REGEXP_CONTAINS(FACT.shipping_destination_cd, r'OS')
      THEN LENGTH(REGEXP_REPLACE(FACT.shipping_destination_cd, CONCAT('(.*?)', 'OS', '(.*)'), '\\1')) + 1
      ELSE 0
      END = 1
   THEN RIGHT(FACT.shipping_destination_cd, 2)
   ELSE FACT.shipping_destination_cd
   END = COUNTRY_POL.iso_country_cd
GROUP BY FACT.container_resource_item_sid;