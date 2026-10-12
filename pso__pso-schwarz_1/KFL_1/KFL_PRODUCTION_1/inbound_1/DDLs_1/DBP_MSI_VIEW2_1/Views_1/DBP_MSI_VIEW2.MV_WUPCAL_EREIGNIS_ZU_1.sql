CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WUPCAL_EREIGNIS_ZU_1 (wup_id ,mandant_id,nb_id,dat,ereignistyp_id,ereignis_id,offen )
AS
   SELECT wup_id, mandant_id, nb_id, dat, ereignistyp_id, ereignis_id, offen from dbp_view.v_wupcal_ereignis_zu_1 where mandant_id=1;