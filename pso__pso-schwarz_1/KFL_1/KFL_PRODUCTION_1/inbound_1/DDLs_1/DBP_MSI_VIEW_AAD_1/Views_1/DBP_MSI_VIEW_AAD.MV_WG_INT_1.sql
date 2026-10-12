CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_WG_INT_1 AS
--10.07.2023 snik: SPEC0202038 WG Lookup
   SELECT DISTINCT
     wg.arthiertyp_id
   , wg.wg_id
   , wg.owg_id
   FROM dbp_view.v_wg_per_1 wg
   WHERE wg.arthiertyp_id = 2 AND wg.dat_bis = '9999-12-31'
;