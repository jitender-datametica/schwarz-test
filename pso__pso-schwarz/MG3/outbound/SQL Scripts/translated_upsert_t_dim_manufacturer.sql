TRUNCATE TABLE szd_production_core.t_dim_manufacturer;


INSERT INTO szd_production_core.t_dim_manufacturer (manufacturer_sid, manufacturer_group_cd, manufacturer_name,
 dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_manufacturer_temp
 WHERE manufacturer_sid IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY manufacturer_sid ORDER BY dwh_created_tmsp IS NULL DESC, dwh_created_tmsp DESC
       )) = 1);


COMMIT TRANSACTION;