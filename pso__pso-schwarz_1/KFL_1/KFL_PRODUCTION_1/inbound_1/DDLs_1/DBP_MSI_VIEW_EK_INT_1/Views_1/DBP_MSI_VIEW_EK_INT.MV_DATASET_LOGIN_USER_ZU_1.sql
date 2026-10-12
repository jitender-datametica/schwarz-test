CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_DATASET_LOGIN_USER_ZU_1
(
mandant_id
,datasetuser_id
,loginuser_id)
AS
   SELECT DISTINCT
   art.mandant_id, art.user_id, us.user_id
   FROM dbp_msi_view_ek_int.mv_art_user_zu_1 art_1
   JOIN dbp_msi_view_ek_int.mv_user_rolle_ek_int_zu_1 us
   ON (art.mandant_id = us.mandant_id AND
   art.user_id = DECODE(us.rolle_id,4,'Superuser',us.user_id));