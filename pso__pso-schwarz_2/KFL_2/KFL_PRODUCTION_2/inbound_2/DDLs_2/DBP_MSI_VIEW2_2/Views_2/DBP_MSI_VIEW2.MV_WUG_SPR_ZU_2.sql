CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WUG_SPR_ZU_2 (mandant_id, wug_id,arthiertyp_id,wg_id,spr_id,wug_bez,wug_id_bez)
AS
   SELECT mandant_id, wug_id, arthiertyp_id, wg_id, spr_id, wug_bez,
   cast( cast(wug_id as CHAR(10)) || '   ' || wug_bez AS CHAR(50)) from dbp_view.v_wug_spr_zu_2 where spr_id=22 and mandant_id=1 and arthiertyp_id=2;