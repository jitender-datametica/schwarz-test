DELETE FROM ldl_data_production_core_rel.t_person
WHERE dwh_node_cd = 'P_LEW_CORE' AND first_name || family_name IN (SELECT first_name || family_name AS A267536012
   FROM ldl_data_production_core_rel.t_person
   WHERE dwh_node_cd = 'OSO');