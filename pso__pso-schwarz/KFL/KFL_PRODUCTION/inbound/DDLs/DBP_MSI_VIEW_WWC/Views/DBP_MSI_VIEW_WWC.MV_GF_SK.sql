CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_GF_SK as
   SELECT  mandant_id, ma_id AS gf_id, ma_anrede, ma_name, ma_vorname, CAST(ma_name AS varchar(40)) gf_name

   FROM dbp_view.v_ma_spr_zu

   WHERE  spr_id = 108 AND
   (mandant_id, ma_id) IN (SELECT mandant_id, gf_gbl_vertrieb_id
   FROM dbp_msi_v_view.v_wup_denorm );