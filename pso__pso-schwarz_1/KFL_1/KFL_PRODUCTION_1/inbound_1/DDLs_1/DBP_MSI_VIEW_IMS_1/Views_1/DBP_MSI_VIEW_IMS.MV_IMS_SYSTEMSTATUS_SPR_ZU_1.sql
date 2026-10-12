CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IMS_SYSTEMSTATUS_SPR_ZU_1 AS
-- 20.08.2013 twie: Erstellung Sprachview Systemstatus
-- 20.08.2013 twie: gleiche ID kann in anderem Mandanten andere Bedeutung haben. Deshalb pro ID - Mandantkomination ein Eintrag in Landessprache. Attribut somit nicht mehrsprachfähig.

   SELECT
   v01.systemstatus_id,
   v01.mandant_id,
   v01.systemstatus_bez_kurz,
   v01.systemstatus_bez

  FROM dbp_view.v_ims_systemstatus_spr_zu_1 v01
   JOIN dbp_view.v_mandant_spr_zu_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.spr_id = v02.spr_id
   ;