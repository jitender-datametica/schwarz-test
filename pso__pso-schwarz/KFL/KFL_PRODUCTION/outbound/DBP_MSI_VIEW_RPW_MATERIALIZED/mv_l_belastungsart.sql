-- 19.07.2023 twie: SPEC0064436 Select * ersetzt

CREATE OR REPLACE VIEW dbp_msi_view_rpw_materialized.mv_l_belastungsart (belastungsart_vd_id,
belastungsart_id) AS SELECT belastungsart_vd_id,
 belastungsart_id
FROM dbp_view.v_rpw_l_belastungsart;