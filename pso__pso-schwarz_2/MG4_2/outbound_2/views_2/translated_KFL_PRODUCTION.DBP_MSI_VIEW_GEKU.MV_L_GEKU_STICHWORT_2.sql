-- 17.09.2013 twie: Anlage_2 Lookup Stichwort
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_geku_stichwort_2 (geku_stichwort_uid
) AS SELECT geku_stichwort_uid
FROM kfl_production_dbp_view.v_l_geku_stichwort_2;