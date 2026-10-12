-- Bereich wird in DWH generiert, existiert nicht im Quellsystem Maritz

-- 20180502 twie: SPEC0037245 Neuanlage Lookup Bereich in Maritz
 -- 20190404 twie: SPEC0053317 FK auf Umfrage

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_bereich (ber_id, umfrage_id) AS SELECT ber_id,
 umfrage_id
FROM kfl_production_dbp_view.v_mcx_l_bereich;