CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WUP_GRP_ZU (mandant_id,nb_id,referenzierend,referenziert,wup_id,wup_grp_id)
AS
   SELECT mandant_id, nb_id, referenzierend, referenziert, wup_id, wupgrp_id from dbp_view.v_wup_grp_zu where mandant_id=1;