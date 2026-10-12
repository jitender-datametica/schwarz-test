CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_L_CONTIDLAYOUT as

   SELECT DISTINCT

   CASE
   WHEN containertyp_id IN (1,2,3,5,7,14,15,17,30) THEN '1'
   WHEN containertyp_id IN (4,6,8,9,10,16) THEN '2'
   ELSE '99' END AS LayoutID, CASE
   WHEN LayoutID IN (1) THEN 'Etikett'
   WHEN LayoutID IN (2) THEN 'Plakat'
   WHEN LayoutID IN (99) THEN 'Restmenge'
   ELSE 'NA' END AS Layout


   FROM dbp_view.v_eps_containertyp_spr_zu;