-- 20180509 twie: SPEC0037245 Neuanlage Lookup Teilbereich in Maritz

-- 20190617 twie: NSR0798599 teilbereich_id von INTEGER zu INTEGER , damit einheitlich zu audimex Feld

-- Teilbereich wird in DWH generiert, existiert nicht im Quellsystem Maritz

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_teilbereich_1 (teilbereich_id, ber_id) AS SELECT CAST(teilbereich_id AS BIGNUMERIC)
 AS teilbereich_id,
 ber_id
FROM kfl_production_dbp_view.v_mcx_l_teilbereich_1;