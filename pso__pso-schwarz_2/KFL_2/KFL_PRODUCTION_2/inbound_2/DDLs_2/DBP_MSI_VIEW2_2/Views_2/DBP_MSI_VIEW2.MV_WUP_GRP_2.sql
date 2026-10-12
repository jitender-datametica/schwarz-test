CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WUP_GRP_2 (wup_grp_id ,wup_grp_bez,wup_grp_typ_id)
AS
   SELECT wupgrp_id, wupgrp_bez, wupgrptyp_id from dbp_view.v_wup_grp_2;