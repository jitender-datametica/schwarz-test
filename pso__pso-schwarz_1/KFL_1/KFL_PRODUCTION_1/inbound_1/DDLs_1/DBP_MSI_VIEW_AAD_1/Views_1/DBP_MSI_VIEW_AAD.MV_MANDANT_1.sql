CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_MANDANT_1 AS
--07.06.2023 twie: SPEC0200542 Lookup Mandant_1
SELECT
     mandant_id
   , mandant_bez
   , mandant_kbez
   ,mandant_sort_id
FROM dbp_view.v_mandant_1;