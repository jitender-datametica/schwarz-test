CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_L_MWST_1 as
   SELECT
   mwst_id, mandant_id, mwst, mwst_bez, dat_von, dat_bis
   FROM dbp_view.v_mwst_per_1
   WHERE dat_bis = '9999-12-31'
;