-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_l_zeitspanne_einkauf (zeitspanne_einkauf_id
, zeitspanne_einkauf_sort_id) AS SELECT zeitspanne_einkauf_id,
 zeitspanne_einkauf_sort_id
FROM dbp_view.v_mdl_l_zeitspanne_einkauf AS V01;