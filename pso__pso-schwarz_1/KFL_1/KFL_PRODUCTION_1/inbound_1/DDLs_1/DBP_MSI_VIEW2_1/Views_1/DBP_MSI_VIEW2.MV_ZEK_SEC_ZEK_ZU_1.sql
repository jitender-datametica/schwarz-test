CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ZEK_SEC_ZEK_ZU_1 
(
 zek_sec_id
,mandant_id
,zek_id
)
AS
   SELECT
   zek_id AS zek_sec_id,
   mandant_id,
   zek_id

   FROM dbp_msi_view2.mv_zek_1
   WHERE zek_id <> '-1'

   UNION
   
   SELECT
   '97' AS zek_sec_id,
   mandant_id,
   '97' AS zek_id

   FROM dbp_msi_view2.mv_zek_1
   WHERE zek_id <> '-1'
   AND mandant_id = 1;