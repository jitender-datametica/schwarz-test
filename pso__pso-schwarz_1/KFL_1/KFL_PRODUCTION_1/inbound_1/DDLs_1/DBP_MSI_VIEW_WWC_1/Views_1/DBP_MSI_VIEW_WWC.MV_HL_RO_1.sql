CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_HL_RO_1 as
   SELECT  mandant_id, ma_id AS hausleiter_id, ma_anrede, ma_name, ma_vorname

   FROM dbp_view.v_ma_spr_zu_1

   WHERE  spr_id = 95 AND
   (mandant_id, ma_id) IN (SELECT mandant_id, hausleiter_id
   FROM dbp_msi_v_view.v_wup_denorm_1 );