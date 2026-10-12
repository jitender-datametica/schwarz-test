CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VW_2 as
   -- LOOKUP Vertriebsweg (Einkauf)
   -- 2012KW46 Review, Erweiterung KMO
   SELECT
   mandant_id, vw_id, vw_bez, sap_vw_id
   FROM dbp_view.v_l_vw_2
   WHERE vwart_id=1
   AND vw_id IN (0,1,2,3,10);