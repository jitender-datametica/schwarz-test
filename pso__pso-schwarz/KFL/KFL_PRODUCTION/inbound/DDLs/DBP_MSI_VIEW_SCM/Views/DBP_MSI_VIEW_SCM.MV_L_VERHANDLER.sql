CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_VERHANDLER as
   SELECT DISTINCT
   v01.mandant_id, v01.verhandler_id, case when v01.verhandler_id = '' then 'leer/empty' else v01.verhandler_id end as verhandler_bez
   FROM dbp_view.v_art v01
   WHERE v01.dat_bis='9999-12-31';