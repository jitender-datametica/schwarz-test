CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_MANDANT_GRP_ZU_1 (mandantgrp_id, mandant_id)
AS
   SELECT  mandantgrp_id, mandant_id from dbp_view.v_mandant_grp_zu_1 where mandant_id=1;