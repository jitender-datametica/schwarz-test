CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_muki (country_id, muki_id) AS SELECT DISTINCT LAND.country_id,
 ART2.kl_art_id AS muki_id
FROM smp_production_data_shared_kfl.dbp_data_art AS ART1
 LEFT JOIN smp_production_data_shared_kfl.dbp_data_art AS ART2 ON ART1.mutter_wb_id = ART2.art_id AND ART1.mandant_id =
     ART2.mandant_id AND ART1.dat_bis = DATE '9999-12-31' AND ART2.dat_bis = DATE '9999-12-31'
 INNER JOIN smp_production_core_rel.t_country AS LAND ON ART1.mandant_id = LAND.division_country_ref;