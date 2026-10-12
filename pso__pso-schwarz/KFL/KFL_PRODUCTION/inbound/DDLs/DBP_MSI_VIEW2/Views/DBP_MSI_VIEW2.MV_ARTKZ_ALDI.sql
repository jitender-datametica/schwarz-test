CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_ALDI ( aldi_bez,aldi_id,mandant_id,spr_id)
AS
   select case when aldi_bez='system generated' then 'kein Aldiartikel' else aldi_bez end, aldi_id, mandant_id, spr_id from dbp_view.v_artkz_aldi where mandant_id=1;